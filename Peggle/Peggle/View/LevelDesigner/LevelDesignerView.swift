//
//  LevelDesignerView.swift
//  Peggle
//
//  Created by proglab on 1/2/24.
//

import SwiftUI

struct LevelDesignerView: View {
    @ObservedObject var levelDesignerVM: LevelDesignerVM
    @State private var currentColor: PegColor = .blue
    @State private var isEraseMode = false

    var body: some View {
        VStack(spacing: 0) {
            NavigationStack {
            BoardView(levelDesignerVM: levelDesignerVM, currentColor: $currentColor, isEraseMode: $isEraseMode)
            ControlsView(levelDesignerVM: levelDesignerVM)
            SelectorsView(currentColor: $currentColor, isEraseMode: $isEraseMode)
        }
//        .border(Color.black)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

#Preview {
    LevelDesignerView(levelDesignerVM: LevelDesignerVM())
}
