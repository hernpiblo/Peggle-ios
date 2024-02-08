//
//  ControlsView.swift
//  Peggle
//
//  Created by proglab on 25/1/24.
//

import SwiftUI

struct ControlsView: View {
    @ObservedObject var levelDesignerVM: LevelDesignerVM
    @State private var levelName: String = ""
    @State private var savedLevelNames: [String] = []
    @State private var isLevelNameBlank = false
    @State private var isEmptyBoard = false
    @State private var saveLevelSuccessful = false
    @State private var isSavedOrLoaded = false

    var body: some View {
        HStack {
            LevelNameTextBox(levelName: $levelName)

            SaveButton(levelDesignerVM: levelDesignerVM,
                       levelName: $levelName,
                       isLevelNameBlank: $isLevelNameBlank,
                       isEmptyBoard: $isEmptyBoard,
                       saveLevelSuccessful: $saveLevelSuccessful,
                       isSavedOrLoaded: $isSavedOrLoaded)

            LoadButton(levelDesignerVM: levelDesignerVM,
                       levelName: $levelName,
                       savedLevelNames: $savedLevelNames,
                       isSavedOrLoaded: $isSavedOrLoaded)

            ResetButton(levelDesignerVM: levelDesignerVM,
                        levelName: $levelName,
                        isSavedOrLoaded: $isSavedOrLoaded)

            StartButton(levelName: $levelName,
                        isSavedOrLoaded: $isSavedOrLoaded)

            Alerts(isLevelNameBlank: $isLevelNameBlank,
                   isEmptyBoard: $isEmptyBoard,
                   saveLevelSuccessful: $saveLevelSuccessful,
                   levelName: $levelName)
        }
        .padding(20)
    }
}


private struct LevelNameTextBox: View {
    @Binding var levelName: String

    var body: some View {
        TextField("Enter a level name", text: $levelName)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10.0)
                    .strokeBorder(Color.black, style: StrokeStyle(lineWidth: 1.0))
            )
    }
}


private struct SaveButton: View {
    @ObservedObject var levelDesignerVM: LevelDesignerVM
    @Binding var levelName: String
    @Binding var isLevelNameBlank: Bool
    @Binding var isEmptyBoard: Bool
    @Binding var saveLevelSuccessful: Bool
    @Binding var isSavedOrLoaded: Bool

    var body: some View {
        Button(Constants.ButtonText.SAVE) {
            if levelName.isEmpty {
                isLevelNameBlank = true
            } else if levelDesignerVM.isEmpty() {
                isEmptyBoard = true
            } else {
                saveLevelSuccessful = levelDesignerVM.saveLevel(levelName)
                isSavedOrLoaded = saveLevelSuccessful
            }
        }
        .padding()
    }
}


private struct LoadButton: View {
    @ObservedObject var levelDesignerVM: LevelDesignerVM
    @Binding var levelName: String
    @Binding var savedLevelNames: [String]
    @Binding var isSavedOrLoaded: Bool

    var body: some View {
        Menu(Constants.ButtonText.LOAD) {
            ForEach(savedLevelNames, id: \.self) { levelName in
                Button(levelName) {
                    if levelDesignerVM.loadLevel(levelName) {
                        self.levelName = levelName
                        isSavedOrLoaded = true
                    }
                }
            }
        }
        .onTapGesture {
            savedLevelNames = LevelManager.listAllLevels()
        }
        .onAppear {
            savedLevelNames = LevelManager.listAllLevels()
        }
        .padding()
    }
}


private struct ResetButton: View {
    @ObservedObject var levelDesignerVM: LevelDesignerVM
    @Binding var levelName: String
    @Binding var isSavedOrLoaded: Bool

    var body: some View {
        Button(Constants.ButtonText.RESET) {
            levelDesignerVM.resetLevel()
            levelName = ""
            isSavedOrLoaded = false
        }
        .padding()
    }
}


private struct StartButton: View {
    @Binding var levelName: String
    @Binding var isSavedOrLoaded: Bool

    var level: Level {
        LevelManager.loadLevel(levelName: levelName) ?? Level()
    }

    var body: some View {
//        NavigationStack {
            NavigationLink(Constants.ButtonText.START) {
                GameView(gameVM: GameVM(level: level))
//                b()
                    .navigationBarBackButtonHidden()
            }.disabled(!isSavedOrLoaded)
//        }
            //        .border(Color.black)
//        .frame(width: 80, height: 80)
    }
}


private struct Alerts: View {
    @Binding var isLevelNameBlank: Bool
    @Binding var isEmptyBoard: Bool
    @Binding var saveLevelSuccessful: Bool
    @Binding var levelName: String

    var body: some View {
        Text("")
            .alert(isPresented: $isLevelNameBlank, content: {
                Alert(title: Text("Level name cannot be blank"))
            })
            .hidden()

        Text("")
            .alert(isPresented: $isEmptyBoard, content: {
                Alert(title: Text("Place at least 1 peg"))
            })
            .hidden()

        Text("")
            .alert(isPresented: $saveLevelSuccessful, content: {
                Alert(title: Text("Level - \"\(levelName)\" saved!"))
            })
            .hidden()
    }
}

#Preview {
    ControlsView(levelDesignerVM: LevelDesignerVM())
}
