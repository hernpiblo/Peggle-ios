//
//  GameView.swift
//  Peggle
//
//  Created by proglab on 7/2/24.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var gameVM: GameVM

    var body: some View {
        VStack {
            GeometryReader { _ in
                ZStack {
                    BackgroundView(gameVM: gameVM)
                    GamePegsView(gameVM: gameVM)
                    if gameVM.ballInPlay() && gameVM.getBall() != nil {
                        BallView(gameVM: gameVM, ball: gameVM.getBall()!)
                    }
                }
            }
            .frame(width: gameVM.getLevelSize().width,
                   height: gameVM.getLevelSize().height)
            Spacer() // TODO: Add headers
        }
        .ignoresSafeArea()
    }
}


private struct BackgroundView: View {
    @ObservedObject var gameVM: GameVM

    var body: some View {
        Image(Constants.ImageName.BACKGROUND)
            .resizable()
            .scaledToFill()
            .frame(width: gameVM.getLevelSize().width,
                   height: gameVM.getLevelSize().height)
            .onTapGesture { tapLocation in
                gameVM.shootBall(at: tapLocation)
            }
    }
}


private struct GamePegsView: View {
    @ObservedObject var gameVM: GameVM

    var body: some View {
        ForEach(gameVM.getGamePegs(), id: \.self) { peg in
            GamePegView(gameVM: gameVM, peg: peg)
        }
    }
}

#Preview {
    GameView(gameVM: GameVM(level:
                                Level(name: "Preview",
                                      pegs: [Peg(
                                        position: CGPoint(x: 200, y: 200),
                                        color: .blue,
                                        radius: BallView.ballRadius
                                      ),
                                             Peg(
                                               position: CGPoint(x: 500, y: 700),
                                               color: .orange,
                                               radius: BallView.ballRadius
                                             )],
                                      size: CGSize(width: 820.0, height: 932.0))))
}
