//
//  BoardView.swift
//  Peggle
//
//  Created by proglab on 4/2/24.
//

import SwiftUI

struct BoardView: View {
    @ObservedObject var levelDesignerVM: LevelDesignerVM
    @Binding var currentColor: PegColor
    @Binding var isEraseMode: Bool

    var body: some View {
        GeometryReader { geo in
            ZStack {
                BackgroundView(geo: geo, levelDesignerVM: levelDesignerVM,
                               currentColor: $currentColor, isEraseMode: $isEraseMode)
                PegsView(geo: geo, levelDesignerVM: levelDesignerVM, isEraseMode: $isEraseMode)
            }
        }
    }
}


private struct BackgroundView: View {
    var geo: GeometryProxy
    @ObservedObject var levelDesignerVM: LevelDesignerVM
    @Binding var currentColor: PegColor
    @Binding var isEraseMode: Bool

    var body: some View {
        Image(Constants.ImageName.BACKGROUND)
            .resizable()
            .scaledToFill()
            .frame(width: geo.size.width, height: geo.size.height)
            .onTapGesture { tapLocation in
                boardTap(at: tapLocation, in: geo)
            }
    }

    private func boardTap(at tapLocation: CGPoint, in geo: GeometryProxy) {
        guard !isEraseMode else { return }
        levelDesignerVM.addPeg(at: tapLocation, in: geo.size, pegColor: currentColor)
    }
}


private struct PegsView: View {
    var geo: GeometryProxy
    @ObservedObject var levelDesignerVM: LevelDesignerVM
    @Binding var isEraseMode: Bool

    var body: some View {
        ForEach(levelDesignerVM.getPegs(), id: \.self) { peg in
            PegView(peg: peg, geoSize: geo.size, levelDesignerVM: levelDesignerVM, isEraseMode: $isEraseMode)
        }
    }
}
