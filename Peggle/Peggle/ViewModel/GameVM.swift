//
//  GameVM.swift
//  Peggle
//
//  Created by proglab on 7/2/24.
//

import SwiftUI

class GameVM: ObservableObject {
    @Published private var level = Level()
    @Published private var ball: Ball?
//    @Published var isHidingProcess = false

    private let magnitude = 30.0
    private let frameDuration = 0.50
    private let origin: CGPoint

    @Published private var isBallInPlay = false
    private var displayLink: CADisplayLink!

    init(level: Level) {
        self.level = level
        origin = level.getOrigin()
        initDisplayLink()
    }


    private func initDisplayLink() {
        displayLink = CADisplayLink(target: self, selector: #selector(update))
        displayLink.add(to: .current, forMode: .default)
    }


    @objc private func update() {
        guard var currentBall = ball else { return }
        currentBall = PhysicsEngine.getBallWithNextPositionAndVelocity(ball: currentBall, frameDuration: frameDuration)
        currentBall = PhysicsEngine.updateBallBounceWithWall(ball: currentBall, size: level.getSize())
        let pegs = level.getPegs()
        for peg in pegs {
            if !peg.isHidden && peg.isCollidingWith(currentBall) {
                let newVelocity = PhysicsEngine.calculateCollisionNewVelocity(currentBall, peg)
                currentBall = currentBall.setVelocity(newVelocity)
                level.hitPeg(peg)
                break
            }
        }
        ball = currentBall
        if checkIfBallOut() {
            ball = nil
            isBallInPlay = false
//            withAnimation(.easeInOut(duration: 1.0)) {
//                isHidingProcess = true
                level.hideHitPegs()
//                isHidingProcess = false
//            }
        }
    }
    
    func startLevel(_ levelName: String) {
        guard let level: Level = LevelManager.loadLevel(levelName: levelName) else { return }
        self.level = level
    }


    func shootBall(at tapLocation: CGPoint) {
        if !isBallInPlay {
            let initialVelocity = PhysicsEngine.getInitialVelocity(tapLocation, origin, magnitude: magnitude)
            let initialPosition = CGPoint(x: level.getOrigin().x, y: level.getOrigin().y + Ball.ballRadius + 10)
            let initialBall = Ball(position: initialPosition, velocity: initialVelocity)
            ball = initialBall
            isBallInPlay = true
        }
    }


    func checkIfBallOut() -> Bool {
        return isBallInPlay
            && ball != nil
            && ball!.getPosition().y >= level.getSize().height
    }


    func getBall() -> Ball? {
        return ball
    }


    func getLevelSize() -> CGSize {
        return level.getSize()
    }


    func getGamePegs() -> [Peg] {
        return level.getPegs()
    }


    func ballInPlay() -> Bool {
        return isBallInPlay
    }
}
