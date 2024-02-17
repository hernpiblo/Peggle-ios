//
//  GameView.swift
//  Peggle
//
//  Created by proglab on 7/2/24.
//

import SwiftUI

struct GameView: View {
    var gameVM: GameViewModel

    var body: some View {
        VStack(spacing: 0) {
            HeaderView(gameVM: gameVM)
            MainGameView(gameVM: gameVM)
            TitleView(gameVM: gameVM)
        }
        .ignoresSafeArea()
    }
}

private struct HeaderView: View {
    @Bindable var gameVM: GameViewModel

    var body: some View {
        HStack {
            Spacer()
            VStack {
                Text("Points")
                    .font(.system(size: 30))
                Text("\(gameVM.points)")
                    .font(.system(size: 60))
                    .fontWeight(.bold)
            }
            Spacer()
            Spacer()
            VStack {
                Text("Balls remaining")
                    .font(.system(size: 30))
                Text("\(gameVM.numBalls)")
                    .font(.system(size: 60))
                    .fontWeight(.bold)
            }
            Spacer()
        }
        .frame(minHeight: 0, maxHeight: .infinity)
        .foregroundColor(.white)
        .background(.cyan)
    }
}

private struct MainGameView: View {
    @Bindable var gameVM: GameViewModel

    var body: some View {
        GeometryReader { _ in
            ZStack {
                BackgroundView(gameVM: gameVM)
                GamePegsView(gameVM: gameVM)
                if gameVM.isBallInPlay && gameVM.ball != nil {
                    BallView(gameVM: gameVM, ball: gameVM.ball!)
                }
                CannonView(gameVM: gameVM)
            }
        }
        .frame(width: gameVM.level.boardSize.width,
               height: gameVM.level.boardSize.height)
    }
}

private struct BackgroundView: View {
    var gameVM: GameViewModel

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
    var gameVM: GameViewModel

    var body: some View {
        ForEach(gameVM.pegs, id: \.self) { peg in
            GamePegView(gameVM: gameVM, peg: peg)
        }
    }
}

private struct CannonView: View {
    var gameVM: GameViewModel

    var body: some View {
        Image(Constants.ImageName.CANNON)
            .resizable()
            .frame(width: 100, height: 100)
            .rotationEffect(gameVM.cannonAngle)
            .position(x: gameVM.level.boardSize.width / 2,
                      y: 45)
    }
}

private struct TitleView: View {
    @Bindable var gameVM: GameViewModel

    var body: some View {
        Text(gameVM.level.name)
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(Color.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.brown)
    }
}

#Preview {
    GameView(gameVM: GameViewModel(level:
        Level(pegs: [Peg(position: CGPoint(x: 200, y: 200),
                         radius: Ball.radius, color: .blue),
                     Peg(position: CGPoint(x: 500, y: 700),
                         radius: Ball.radius, color: .orange)],
              name: "Level 1",
              boardSize: CGSize(width: 820.0, height: 932.0)),
              numBalls: 10))
}
