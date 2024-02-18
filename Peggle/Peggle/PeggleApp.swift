//
//  PeggleApp.swift
//  Peggle
//
//  Created by proglab on 24/1/24.
//

import SwiftUI

@main
struct PeggleApp: App {
    @State var levelDesignerVM = LevelDesignerViewModel()

    var body: some Scene {
        WindowGroup {
            LevelDesignerView(levelDesignerVM: levelDesignerVM)

//            GameView(gameVM: GameVM(level:
//                    Level(pegs: [Peg(position: CGPoint(x: 050, y: 500), radius: Ball.radius, color: .orange),
//                                 Peg(position: CGPoint(x: 100, y: 500), radius: Ball.radius, color: .orange),
//                                 Peg(position: CGPoint(x: 150, y: 500), radius: Ball.radius, color: .orange),
//                                 Peg(position: CGPoint(x: 200, y: 500), radius: Ball.radius, color: .orange),
//                                 Peg(position: CGPoint(x: 250, y: 500), radius: Ball.radius, color: .orange),
//                                 Peg(position: CGPoint(x: 300, y: 500), radius: Ball.radius, color: .orange),
//                                 Peg(position: CGPoint(x: 350, y: 500), radius: Ball.radius, color: .orange),
//                                 Peg(position: CGPoint(x: 400, y: 500), radius: Ball.radius, color: .orange),
//                                 Peg(position: CGPoint(x: 400, y: 450), radius: Ball.radius, color: .orange),
//                                 Peg(position: CGPoint(x: 400, y: 400), radius: Ball.radius, color: .orange),
//                                 Peg(position: CGPoint(x: 400, y: 350), radius: Ball.radius, color: .orange),
//                                 Peg(position: CGPoint(x: 400, y: 300), radius: Ball.radius, color: .orange),
//                                 Peg(position: CGPoint(x: 400, y: 250), radius: Ball.radius, color: .orange),
//                                 Peg(position: CGPoint(x: 400, y: 200), radius: Ball.radius, color: .orange),
//                                 Peg(position: CGPoint(x: 400, y: 150), radius: Ball.radius, color: .orange),
//                                 Peg(position: CGPoint(x: 400, y: 550), radius: Ball.radius, color: .orange),
//                                 Peg(position: CGPoint(x: 400, y: 600), radius: Ball.radius, color: .orange),
//                                 Peg(position: CGPoint(x: 400, y: 650), radius: Ball.radius, color: .orange),
//                                 Peg(position: CGPoint(x: 400, y: 700), radius: Ball.radius, color: .orange),
//                                 Peg(position: CGPoint(x: 400, y: 750), radius: Ball.radius, color: .orange),
//                                 Peg(position: CGPoint(x: 400, y: 800), radius: Ball.radius, color: .orange),
//                                 Peg(position: CGPoint(x: 350, y: 800), radius: Ball.radius, color: .orange),
//                                 Peg(position: CGPoint(x: 300, y: 800), radius: Ball.radius, color: .orange),
//                                 Peg(position: CGPoint(x: 250, y: 800), radius: Ball.radius, color: .orange),
//                                 Peg(position: CGPoint(x: 200, y: 800), radius: Ball.radius, color: .orange),
//                                 Peg(position: CGPoint(x: 150, y: 800), radius: Ball.radius, color: .orange),
//                                 Peg(position: CGPoint(x: 100, y: 800), radius: Ball.radius, color: .orange),
//                                 Peg(position: CGPoint(x: 050, y: 800), radius: Ball.radius, color: .orange)
//                                ], name: "Preview", boardSize: CGSize(width: 820.0, height: 932.0)),
//                                    numBalls: 10))
        }
    }
}
