//
//  LevelDesignerView.swift
//  Peggle
//
//  Created by proglab on 1/2/24.
//

import SwiftUI

struct LevelDesignerView: View {
    var levelDesignerVM: LevelDesignerVM
    @State private var currentColor: PegColor = .blue
    @State private var isEraseMode = false
    @State private var isSavedOrLoaded = false
    @State private var currentPegRadius: CGFloat = Peg.defaultRadius

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ControlsView(levelDesignerVM: levelDesignerVM,
                             isSavedOrLoaded: $isSavedOrLoaded)
                BoardView(levelDesignerVM: levelDesignerVM,
                          currentColor: $currentColor,
                          isEraseMode: $isEraseMode,
                          isSavedOrLoaded: $isSavedOrLoaded,
                          currentPegRadius: $currentPegRadius)
                SelectorsView(currentColor: $currentColor,
                              isEraseMode: $isEraseMode)
            }
            .ignoresSafeArea()
        }
        .navigationViewStyle(.stack)
        .statusBar(hidden: true)
    }
}

#Preview {
    LevelDesignerView(levelDesignerVM: LevelDesignerVM())
}
