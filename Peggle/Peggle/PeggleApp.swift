//
//  PeggleApp.swift
//  Peggle
//
//  Created by proglab on 24/1/24.
//

import SwiftUI

@main
struct PeggleApp: App {
    @State var levelDesignerVM = LevelDesignerVM()

    var body: some Scene {
        WindowGroup {
//                LevelDesignerView(levelDesignerVM: levelDesignerVM)
            GameView(gameVM: GameVM(level:
                                        Level(pegs: [Peg(
                                                        position: CGPoint(x: 200, y: 200),
                                                        radius: Ball.radius, color: .blue
                                                    ),
                                                     Peg(
                                                        position: CGPoint(x: 50, y: 500),
                                                        radius: Ball.radius, color: .orange
                                                     ),
                                                     Peg(
                                                        position: CGPoint(x: 100, y: 500),
                                                        radius: Ball.radius, color: .orange
                                                     ),
                                                     Peg(
                                                        position: CGPoint(x: 150, y: 500),
                                                        radius: Ball.radius, color: .orange
                                                     ),
                                                     Peg(
                                                        position: CGPoint(x: 200, y: 500),
                                                        radius: Ball.radius, color: .orange
                                                     ),
                                                     Peg(
                                                        position: CGPoint(x: 250, y: 500),
                                                        radius: Ball.radius, color: .orange
                                                     ),
                                                     Peg(
                                                        position: CGPoint(x: 300, y: 500),
                                                        radius: Ball.radius, color: .orange
                                                     ),
                                                     Peg(
                                                        position: CGPoint(x: 350, y: 500),
                                                        radius: Ball.radius, color: .orange
                                                     ),
                                                     Peg(
                                                        position: CGPoint(x: 400, y: 500),
                                                        radius: Ball.radius, color: .orange
                                                     )], name: "Preview",
//                                              Level(pegs: [Peg(
//                                                              position: CGPoint(x: 200, y: 200),
//                                                              radius: Ball.radius, color: .blue
//                                                          ),
//                                                           Peg(
//                                                              position: CGPoint(x: 300, y: 500),
//                                                              radius: Ball.radius, color: .orange
//                                                           ),
//                                                           Peg(
//                                                              position: CGPoint(x: 360, y: 560),
//                                                              radius: Ball.radius, color: .orange
//                                                           ),
//                                                           Peg(
//                                                              position: CGPoint(x: 360, y: 440),
//                                                              radius: Ball.radius, color: .orange
//                                                           ),
//                                                           Peg(
//                                                              position: CGPoint(x: 420, y: 620),
//                                                              radius: Ball.radius, color: .orange
//                                                           ),
//                                                           Peg(
//                                                              position: CGPoint(x: 480, y: 560),
//                                                              radius: Ball.radius, color: .orange
//                                                           ),
//                                                           Peg(
//                                                              position: CGPoint(x: 480, y: 440),
//                                                              radius: Ball.radius, color: .orange
//                                                           ),
//                                                           Peg(
//                                                              position: CGPoint(x: 540, y: 500),
//                                                              radius: Ball.radius, color: .orange
//                                                           )], name: "Preview",
                                              boardSize: CGSize(width: 820.0, height: 932.0))))
        }
    }
}
