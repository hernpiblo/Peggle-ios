//
//  BoardView.swift
//  Peggle
//
//  Created by proglab on 4/2/24.
//

import SwiftUI

struct BoardView: View {
    var levelDesignerVM: LevelDesignerVM
    @Binding var currentColor: PegColor
    @Binding var isEraseMode: Bool
    @Binding var isSavedOrLoaded: Bool
    @Binding var currentPegRadius: CGFloat

    var body: some View {
        GeometryReader { geo in
            ZStack {
                BackgroundView(geo: geo,
                               levelDesignerVM: levelDesignerVM,
                               currentColor: $currentColor,
                               isEraseMode: $isEraseMode,
                               isSavedOrLoaded: $isSavedOrLoaded,
                               currentPegRadius: $currentPegRadius)
                PegsView(levelDesignerVM: levelDesignerVM,
                         isEraseMode: $isEraseMode,
                         isSavedOrLoaded: $isSavedOrLoaded)
            }
            .onAppear { levelDesignerVM.setSize(geo.size) }
        }
    }
}

private struct BackgroundView: View {
    var geo: GeometryProxy
    var levelDesignerVM: LevelDesignerVM
    @Binding var currentColor: PegColor
    @Binding var isEraseMode: Bool
    @Binding var isSavedOrLoaded: Bool
    @Binding var currentPegRadius: CGFloat

    var body: some View {
        Image(Constants.ImageName.BACKGROUND)
            .resizable()
            .scaledToFill()
            .frame(width: geo.size.width, height: geo.size.height)
            .onTapGesture { tapLocation in
                boardTap(at: tapLocation)
            }
    }

    private func boardTap(at tapLocation: CGPoint) {
        guard !isEraseMode else { return }
        let addSuccessful = levelDesignerVM.addPeg(at: tapLocation, radius: currentPegRadius, color: currentColor)
        if addSuccessful { isSavedOrLoaded = false }
    }
}

private struct PegsView: View {
    var levelDesignerVM: LevelDesignerVM
    @Binding var isEraseMode: Bool
    @Binding var isSavedOrLoaded: Bool

    var body: some View {
        ForEach(levelDesignerVM.level.pegs) { peg in
            PegView(levelDesignerVM: levelDesignerVM,
                    isEraseMode: $isEraseMode,
                    isSavedOrLoaded: $isSavedOrLoaded,
                    peg: peg)
        }
    }
}
