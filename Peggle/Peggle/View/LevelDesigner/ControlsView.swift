//
//  ControlsView.swift
//  Peggle
//
//  Created by proglab on 25/1/24.
//

import SwiftUI

struct ControlsView: View {
    @ObservedObject var levelDesignerVM: LevelDesignerVM
    @State var levelNameInput : String = "My Level #1"

    var body: some View {
        HStack() {
            TextField("Enter a level name", text: $levelNameInput)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10.0)
                        .strokeBorder(Color.black, style: StrokeStyle(lineWidth: 1.0))
                )
            
            Button("SAVE") {
                saveLevel()
            }
            .padding()
            
            Button("LOAD") {
                loadLevel()
            }
            .padding()
            
            Button("RESET") {
                resetLevel()
            }
            .padding()
            
            Button("START") {
                startLevel()
            }
            .padding()
        }
        .padding(20)
        .background(.yellow)
    }
    
    func saveLevel() {
        
    }
    
    func loadLevel() {
        
    }
    
    func resetLevel() {
        levelDesignerVM.resetLevel()
    }
    
    func startLevel() {
        
    }
}

#Preview {
    ControlsView(levelDesignerVM: LevelDesignerVM())
}
