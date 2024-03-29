//
//  ControlsView.swift
//  Peggle
//
//  Created by proglab on 25/1/24.
//

import SwiftUI

struct ControlsView: View {
    var levelDesignerVM: LevelDesignerViewModel
    @State private var levelName: String = ""
    @State private var savedLevelNames: [String] = []
    @State private var isLevelNameBlankAlert = false
    @State private var isEmptyBoardAlert = false
    @State private var isSaveLevelSuccessfulAlert = false
    @State private var isLevelNameDuplicateAlert = false
    @Binding var isSavedOrLoaded: Bool

    var body: some View {
        HStack {
            LevelNameTextBox(levelName: $levelName)

            SaveButton(levelDesignerVM: levelDesignerVM,
                       levelName: $levelName,
                       savedLevelNames: $savedLevelNames,
                       isLevelNameBlankAlert: $isLevelNameBlankAlert,
                       isEmptyBoardAlert: $isEmptyBoardAlert,
                       isSaveLevelSuccessfulAlert: $isSaveLevelSuccessfulAlert,
                       isLevelNameDuplicateAlert: $isLevelNameDuplicateAlert,
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

            Alerts(levelDesignerVM: levelDesignerVM,
                   levelName: $levelName,
                   savedLevelNames: $savedLevelNames,
                   isLevelNameBlankAlert: $isLevelNameBlankAlert,
                   isEmptyBoardAlert: $isEmptyBoardAlert,
                   isSaveLevelSuccessfulAlert: $isSaveLevelSuccessfulAlert,
                   isLevelNameDuplicateAlert: $isLevelNameDuplicateAlert,
                   isSavedOrLoaded: $isSavedOrLoaded)
        }
        .padding(20)
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(.white)
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
    var levelDesignerVM: LevelDesignerViewModel
    @Binding var levelName: String
    @Binding var savedLevelNames: [String]
    @Binding var isLevelNameBlankAlert: Bool
    @Binding var isEmptyBoardAlert: Bool
    @Binding var isSaveLevelSuccessfulAlert: Bool
    @Binding var isLevelNameDuplicateAlert: Bool
    @Binding var isSavedOrLoaded: Bool

    var body: some View {
        Button(Constants.ButtonText.SAVE) {
            isSavedOrLoaded = false
            if levelName.isEmpty {
                isLevelNameBlankAlert = true
            } else if levelDesignerVM.isEmpty() {
                isEmptyBoardAlert = true
            } else if LevelManager.listAllLevels().contains(levelName) {
                isLevelNameDuplicateAlert = true
            } else {
                isSaveLevelSuccessfulAlert = levelDesignerVM.saveLevel(levelName)
                savedLevelNames = LevelManager.listAllLevels()
                isSavedOrLoaded = isSaveLevelSuccessfulAlert
            }
        }
        .padding()
    }
}

private struct LoadButton: View {
    var levelDesignerVM: LevelDesignerViewModel
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
    var levelDesignerVM: LevelDesignerViewModel
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
        LevelManager.loadLevel(levelName) ?? Level()
    }

    var body: some View {
        NavigationLink(Constants.ButtonText.START) {
            GameView(gameVM: GameViewModel(level: level, numBalls: 10))
        }
        .onAppear { isSavedOrLoaded = false }
        .disabled(!isSavedOrLoaded)
    }
}

private struct Alerts: View {
    var levelDesignerVM: LevelDesignerViewModel
    @Binding var levelName: String
    @Binding var savedLevelNames: [String]
    @Binding var isLevelNameBlankAlert: Bool
    @Binding var isEmptyBoardAlert: Bool
    @Binding var isSaveLevelSuccessfulAlert: Bool
    @Binding var isLevelNameDuplicateAlert: Bool
    @Binding var isSavedOrLoaded: Bool

    var body: some View {
        Text("")
            .alert(isPresented: $isLevelNameBlankAlert, content: {
                Alert(title: Text("Level name cannot be blank"))
            })
            .hidden()

        Text("")
            .alert(isPresented: $isEmptyBoardAlert, content: {
                Alert(title: Text("Place at least 1 peg"))
            })
            .hidden()

        Text("")
            .alert(isPresented: $isSaveLevelSuccessfulAlert, content: {
                Alert(title: Text("Level - \"\(levelName)\" saved!"))
            })
            .hidden()

        Text("")
            .alert("Level name already exist", isPresented: $isLevelNameDuplicateAlert) {
                Button("Overwrite") {
                    isSaveLevelSuccessfulAlert = levelDesignerVM.saveLevel(levelName)
                    savedLevelNames = LevelManager.listAllLevels()
                    isSavedOrLoaded = isSaveLevelSuccessfulAlert
                }
                Button("Cancel", role: .cancel) {}
            }
    }
}
