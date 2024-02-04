//
//  ControlsView.swift
//  Peggle
//
//  Created by proglab on 25/1/24.
//

import SwiftUI

struct ControlsView: View {
    @ObservedObject var levelDesignerVM: LevelDesignerVM
    @State var levelNameInput: String = ""
    @State var savedLevelNames: [String] = []
    @State var isLevelNameBlank = false
    @State var isLevelNameExist = false
    @State var isEmptyBoard = false
    @State var saveLevelSuccessful = false

    var body: some View {
        HStack {
            LevelNameTextBox(levelNameInput: $levelNameInput)

            SaveButton(levelDesignerVM: levelDesignerVM,
                       levelNameInput: $levelNameInput,
                       savedLevelNames: $savedLevelNames,
                       isLevelNameBlank: $isLevelNameBlank,
                       isLevelNameExist: $isLevelNameExist,
                       isEmptyBoard: $isEmptyBoard,
                       saveLevelSuccessful: $saveLevelSuccessful)

            LoadButton(levelDesignerVM: levelDesignerVM,
                       levelNameInput: $levelNameInput,
                       savedLevelNames: $savedLevelNames)

            ResetButton(levelDesignerVM: levelDesignerVM, levelNameInput: $levelNameInput)

            StartButton()

            Alerts(isLevelNameBlank: $isLevelNameBlank,
                   isLevelNameExist: $isLevelNameExist,
                   isEmptyBoard: $isEmptyBoard,
                   saveLevelSuccessful: $saveLevelSuccessful)
        }
        .padding(20)
    }
}


private struct LevelNameTextBox: View {
    @Binding var levelNameInput: String

    var body: some View {
        TextField("Enter a level name", text: $levelNameInput)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10.0)
                    .strokeBorder(Color.black, style: StrokeStyle(lineWidth: 1.0))
            )
    }
}


private struct SaveButton: View {
    @ObservedObject var levelDesignerVM: LevelDesignerVM
    @Binding var levelNameInput: String
    @Binding var savedLevelNames: [String]
    @Binding var isLevelNameBlank: Bool
    @Binding var isLevelNameExist: Bool
    @Binding var isEmptyBoard: Bool
    @Binding var saveLevelSuccessful: Bool

    var body: some View {
        Button(Constants.ButtonText.SAVE) {
            if levelNameInput.isEmpty {
                isLevelNameBlank = true
            } else if levelDesignerVM.isEmpty() {
                isEmptyBoard = true
            } else if levelDesignerVM.checkLevelNameExist(levelNameInput) {
                isLevelNameExist = true
            } else {
                saveLevelSuccessful = levelDesignerVM.saveLevel(levelNameInput)
            }
        }
        .padding()
    }
}


private struct LoadButton: View {
    @ObservedObject var levelDesignerVM: LevelDesignerVM
    @Binding var levelNameInput: String
    @Binding var savedLevelNames: [String]

    var body: some View {
        Menu(Constants.ButtonText.LOAD) {
            ForEach(savedLevelNames, id: \.self) { levelName in
                Button(levelName) {
                    if levelDesignerVM.loadLevel(levelName) {
                        levelNameInput = levelName
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
    @Binding var levelNameInput: String

    var body: some View {
        Button(Constants.ButtonText.RESET) {
            levelDesignerVM.resetLevel()
            levelNameInput = ""
        }
        .padding()
    }
}


private struct StartButton: View {
    var body: some View {
        Button(Constants.ButtonText.START) {
            // TODO: Start level
        }
        .padding()
    }
}


private struct Alerts: View {
    @Binding var isLevelNameBlank: Bool
    @Binding var isLevelNameExist: Bool
    @Binding var isEmptyBoard: Bool
    @Binding var saveLevelSuccessful: Bool

    var body: some View {
        Text("")
            .alert(isPresented: $isLevelNameBlank, content: {
                Alert(title: Text("Level name cannot be blank"))
            })
            .hidden()

        Text("")
            .alert(isPresented: $isLevelNameExist, content: {
                Alert(title: Text("Level name already exist, use a different name"))
            })
            .hidden()

        Text("")
            .alert(isPresented: $isEmptyBoard, content: {
                Alert(title: Text("Place at least 1 ball"))
            })
            .hidden()

        Text("")
            .alert(isPresented: $saveLevelSuccessful, content: {
                Alert(title: Text("Level saved!"))
            })
            .hidden()
    }
}


#Preview {
    ControlsView(levelDesignerVM: LevelDesignerVM())
}
