//
//  PeggleApp.swift
//  Peggle
//
//  Created by proglab on 24/1/24.
//

import SwiftUI

@main
struct PeggleApp: App {
    @StateObject var levelDesignerVM = LevelDesignerVM()

    var body: some Scene {
        WindowGroup {
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
//            LevelDesignerView(levelDesignerVM: levelDesignerVM)
//            GameView(gameVM: GameVM(level:
//                                        Level(name: "Preview",
//                                              pegs: [Peg(
//                                                position: CGPoint(x: 0, y: 0),
//                                                color: .blue,
//                                                radius: BallView.ballRadius
//                                              )],
//                                              size: CGSize(width: 820.0, height: 932.0))))
//            ContentView()
//            ControlsView(levelDesignerVM: LevelDesignerVM())
//            b()
        }
    }
}
