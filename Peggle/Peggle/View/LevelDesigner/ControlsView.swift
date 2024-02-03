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
    @State var saveLevelSuccessful = false
    @State var isLevelNameBlank = false
    @State var isEmptyBoard = false

    var body: some View {
        HStack {
            TextField("Enter a level name", text: $levelNameInput)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10.0)
                        .strokeBorder(Color.black, style: StrokeStyle(lineWidth: 1.0))
                )

            Button("SAVE") {
                if levelNameInput.isEmpty {
                    print("Level Name empty")
                    isLevelNameBlank = true
                } else if levelDesignerVM.isEmpty() {
                    print("No balls")
                    isEmptyBoard = true
                } else {
                    print("Attempting to save...")
                    saveLevelSuccessful = levelDesignerVM.saveLevel(levelNameInput)
                }
            }
            .padding()

            Text("")
                .alert(isPresented: $isLevelNameBlank, content: {
                    Alert(title: Text("Level name cannot be blank"))
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

            Menu("LOAD") {
                ForEach(savedLevelNames, id: \.self) { levelName in
                    Button(levelName) {
                        print("Loading level: \(levelName)")
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

            Button("RESET") {
                levelDesignerVM.resetLevel()
            }
            .padding()

            Button("START") {
                // Start level
            }
            .padding()
        }
        .padding(20)
        .background(.yellow)
    }
}

#Preview {
    ControlsView(levelDesignerVM: LevelDesignerVM())
}
