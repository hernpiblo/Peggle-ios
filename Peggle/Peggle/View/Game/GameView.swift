//
//  GameView.swift
//  Peggle
//
//  Created by proglab on 7/2/24.
//

import SwiftUI

struct GameView: View {
    var gameVM: GameVM

    var body: some View {
        VStack {
            GeometryReader { _ in
                ZStack {
                    BackgroundView(gameVM: gameVM)
                    GamePegsView(gameVM: gameVM)
                    if gameVM.isBallInPlay && gameVM.ball != nil {
                        BallView(gameVM: gameVM, ball: gameVM.ball!)
                    }
                }
            }
            .frame(width: gameVM.level.boardSize.width,
                   height: gameVM.level.boardSize.height)
            Spacer() // TODO: Add headers
        }
        .ignoresSafeArea()
    }
}

private struct BackgroundView: View {
    var gameVM: GameVM

    var body: some View {
        Image(Constants.ImageName.BACKGROUND)
            .resizable()
            .scaledToFill()
            .frame(width: gameVM.level.boardSize.width,
                   height: gameVM.level.boardSize.height)
            .onTapGesture { tapLocation in
                gameVM.shootBall(at: tapLocation)
            }
    }
}

private struct GamePegsView: View {
    var gameVM: GameVM

    var body: some View {
        ForEach(gameVM.pegs, id: \.self) { peg in
            GamePegView(gameVM: gameVM, peg: peg)
        }
    }
}

#Preview {
    GameView(gameVM: GameVM(level:
                                Level(pegs: [Peg(
                                    position: CGPoint(x: 200, y: 200),
                                    radius: Ball.radius, color: .blue
                                ),
                                             Peg(
                                                position: CGPoint(x: 500, y: 700),
                                                radius: Ball.radius, color: .orange
                                             )], name: "Preview",
                                      boardSize: CGSize(width: 820.0, height: 932.0))))
}
