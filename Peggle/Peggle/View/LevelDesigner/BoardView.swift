//
//  BoardView.swift
//  Peggle
//
//  Created by proglab on 4/2/24.
//

import SwiftUI

struct BoardView: View {
    var levelDesignerVM: LevelDesignerVM
    let cannonSize: CGFloat = 100
    @Binding var currentColor: PegColor
    @Binding var isEraseMode: Bool
    @Binding var isSavedOrLoaded: Bool
    @Binding var currentPegRadius: CGFloat

    var body: some View {
        GeometryReader { geo in
            ZStack {
                BackgroundView(geo: geo,
                               levelDesignerVM: levelDesignerVM,
                               cannonSize: cannonSize,
                               currentColor: $currentColor,
                               isEraseMode: $isEraseMode,
                               isSavedOrLoaded: $isSavedOrLoaded,
                               currentPegRadius: $currentPegRadius)
                PegsView(levelDesignerVM: levelDesignerVM,
                         cannonSize: cannonSize,
                         isEraseMode: $isEraseMode,
                         isSavedOrLoaded: $isSavedOrLoaded)
                StaticCannonView(levelDesignerVM: levelDesignerVM,
                                 cannonSize: cannonSize,
                                 boardSize: geo.size)
            }
            .onAppear { levelDesignerVM.setSize(geo.size) }
        }
    }
}

private struct BackgroundView: View {
    var geo: GeometryProxy
    var levelDesignerVM: LevelDesignerVM
    let cannonSize: CGFloat
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
        let addSuccessful = levelDesignerVM.addPeg(at: tapLocation, radius: currentPegRadius, color: currentColor, cannonSize: cannonSize)
        if addSuccessful { isSavedOrLoaded = false }
    }
}

private struct PegsView: View {
    var levelDesignerVM: LevelDesignerVM
    let cannonSize: CGFloat
    @Binding var isEraseMode: Bool
    @Binding var isSavedOrLoaded: Bool

    var body: some View {
        ForEach(levelDesignerVM.level.pegs) { peg in
            PegView(levelDesignerVM: levelDesignerVM,
                    cannonSize: cannonSize,
                    isEraseMode: $isEraseMode,
                    isSavedOrLoaded: $isSavedOrLoaded,
                    peg: peg)
        }
    }
}

private struct StaticCannonView: View {
    var levelDesignerVM: LevelDesignerVM
    let cannonSize: CGFloat
    var boardSize: CGSize

    var body: some View {
        Image(Constants.ImageName.CANNON)
            .resizable()
            .frame(width: cannonSize, height: cannonSize)
            .position(x: boardSize.width / 2, y: 45)
    }
}
