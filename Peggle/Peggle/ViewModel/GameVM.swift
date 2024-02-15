//
//  GameViewVM.swift
//  Peggle
//
//  Created by proglab on 13/2/24.
//

import SwiftUI

@Observable
class GameVM {
    private(set) var level = Level()
    private(set) var ball: Ball?
    private(set) var isBallInPlay = false
    var pegs: [Peg] { level.pegs }
    private (set) var numBalls: Int
    private (set) var points: Int = 0
    private (set) var cannonAngle = Angle()

    private var gameEngine: GameEngine! // App should not run if game engine is somehow nil

    init(level: Level, numBalls: Int) {
        self.level = level
        self.numBalls = numBalls
        initGameEngine()
    }

    func initGameEngine() {
        self.gameEngine = GameEngine(gameVM: self)
    }

    func startLevel(_ levelName: String) {
        guard let level: Level = LevelManager.loadLevel(levelName) else { return }
        self.level = level
    }

    func shootBall(at tapLocation: CGPoint) {
        guard !isBallInPlay else { return }
        let ballInitialPosition = CGPoint(x: level.boardSize.width / 2, y: 45)
        let ballInitialVelocity = PhysicsEngine.getInitialVelocity(
            tapLocation, ballInitialPosition,
            speed: Ball.initialSpeed
        )
        cannonAngle = Angle(radians: Double(atan2(ballInitialVelocity.dy, ballInitialVelocity.dx) - .pi / 2))
        ball = Ball(position: ballInitialPosition, velocity: ballInitialVelocity)
        isBallInPlay = true
    }

    func ballOut() {
        ball = nil
        isBallInPlay = false
        level.hideHitPegs()
    }
}
