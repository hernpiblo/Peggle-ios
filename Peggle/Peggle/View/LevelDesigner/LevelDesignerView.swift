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
    @State private var currentPegRadius: CGFloat = Peg.defaultRadius

    var body: some View {
        VStack(spacing: 0) {
            BoardView(levelDesignerVM: levelDesignerVM,
                      currentColor: $currentColor,
                      isEraseMode: $isEraseMode,
                      currentPegRadius: $currentPegRadius)
            ControlsView(levelDesignerVM: levelDesignerVM)
            SelectorsView(currentColor: $currentColor, isEraseMode: $isEraseMode)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

#Preview {
    LevelDesignerView(levelDesignerVM: LevelDesignerVM())
}
