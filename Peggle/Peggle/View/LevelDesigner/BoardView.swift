//
//  BoardView.swift
//  Peggle
//
//  Created by proglab on 4/2/24.
//

import SwiftUI

struct BoardView: View {
    @ObservedObject var levelDesignerVM: LevelDesignerVM
    @Binding var currentColor: BallColor
    @Binding var isEraseMode: Bool

    var body: some View {
        GeometryReader { geo in
            ZStack {
                BackgroundView(geo: geo, levelDesignerVM: levelDesignerVM,
                               currentColor: $currentColor, isEraseMode: $isEraseMode)
                BallsView(geo: geo, levelDesignerVM: levelDesignerVM, isEraseMode: $isEraseMode)
            }
        }
    }
}


private struct BackgroundView: View {
    var geo: GeometryProxy
    @ObservedObject var levelDesignerVM: LevelDesignerVM
    @Binding var currentColor: BallColor
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
        levelDesignerVM.addBall(at: tapLocation, in: geo.size, ballColor: currentColor)
    }
}


private struct BallsView: View {
    var geo: GeometryProxy
    @ObservedObject var levelDesignerVM: LevelDesignerVM
    @Binding var isEraseMode: Bool

    var body: some View {
        ForEach(levelDesignerVM.getBalls(), id: \.self) { ball in
            BallView(ball: ball, geoSize: geo.size, levelDesignerVM: levelDesignerVM, isEraseMode: $isEraseMode)
        }
    }
}
