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

    private static let frameDuration: CGFloat = 0.50
    private static let gravity: CGFloat = 1.5 // Downwards is positive
    private static let dampingFactor: CGFloat = 0.995 // Lower = more air resistance
    private static let coefficientOfRestitution: CGFloat = 0.995 // Lower = less bouncy

    private var displayLink: CADisplayLink!

    init(level: Level) {
        self.level = level
        initDisplayLink()
    }

    private func initDisplayLink() {
        displayLink = CADisplayLink(target: self, selector: #selector(update))
        displayLink.add(to: .current, forMode: .default)
    }

    @objc private func update() {
        guard ball != nil else { return }
        PhysicsEngine.updateBallNextFrame(ball: ball!, frameDuration: GameVM.frameDuration, gravity: GameVM.gravity, dampingFactor: GameVM.dampingFactor)
        PhysicsEngine.updateBallBounceWithWall(ball: ball!, size: level.boardSize)
        
        for peg in level.pegs {
            if !peg.isHidden && peg.isCollidingWith(ball!) {
                let newVelocity = PhysicsEngine.calculateCollisionNewVelocity(ball: ball!, peg: peg, coefficientOfRestitution: GameVM.coefficientOfRestitution)
                ball!.setVelocity(newVelocity)
                peg.hit()
                break
            }
        }
        
        if checkIfBallOut() {
            ball = nil
            isBallInPlay = false
            level.hideHitPegs()
        }
    }
    
    func startLevel(_ levelName: String) {
        guard let level: Level = LevelManager.loadLevel(levelName) else { return }
        self.level = level
    }

    func shootBall(at tapLocation: CGPoint) {
        guard !isBallInPlay else { return }
        let ballInitialPosition = CGPoint(x: level.boardSize.width / 2, y: Ball.radius)
        let ballInitialVelocity = PhysicsEngine.getInitialVelocity(tapLocation, ballInitialPosition, speed: Ball.initialSpeed)
        ball = Ball(position: ballInitialPosition, velocity: ballInitialVelocity)
        isBallInPlay = true
    }

    func checkIfBallOut() -> Bool {
        return isBallInPlay
            && ball != nil
            && ball!.y >= level.boardSize.height - Ball.radius
    }
}
