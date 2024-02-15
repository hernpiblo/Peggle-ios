//
//  GameEngine.swift
//  Peggle
//
//  Created by proglab on 15/2/24.
//

import SwiftUI

class GameEngine {
    private static let frameDuration: CGFloat = 0.50 // Lower = slower gameplay
    private static let gravity: CGFloat = 1.5 // Downwards is positive
    private static let dampingFactor: CGFloat = 0.995 // Lower = more air resistance
    private static let coefficientOfRestitution: CGFloat = 0.95 // Lower = less bouncy
    private static let minDurationToAutoHide: CGFloat = 300.0
    private static let velocityThreshold: CGFloat = 0

    private var gameVM: GameVM
    private var ball: Ball? { gameVM.ball }

    private var displayLink: CADisplayLink!
    private var autoHideBenchmarkPositions: Queue<CGPoint> = Queue()
    private var currentTimeElapsed: CGFloat = 0

    init(gameVM: GameVM) {
        self.gameVM = gameVM
        initDisplayLink()
    }

    func initDisplayLink() {
        displayLink = CADisplayLink(target: self, selector: #selector(update))
        displayLink.add(to: .current, forMode: .default)
    }

    @objc private func update() {
        updateNextFrame()
        updateWallBounce()
        updatePegCollision()
        if checkBallOut() {
            hideHitPegs()
        }
        updateAutoHide()
    }

    private func updateNextFrame() {
        guard ball != nil else { return }
        PhysicsEngine.updateBallNextFrame(
            ball: ball!,
            frameDuration: GameEngine.frameDuration,
            gravity: GameEngine.gravity,
            dampingFactor: GameEngine.dampingFactor,
            velocityThreshold: GameEngine.velocityThreshold
        )
    }

    private func updateWallBounce() {
        guard ball != nil else { return }
        PhysicsEngine.updateBallBounceWithWall(
            ball: ball!,
            size: gameVM.level.boardSize
        )
        PhysicsEngine.penetrationResolutionWall(
            ball: ball!,
            size: gameVM.level.boardSize
        )
    }

    private func updatePegCollision() {
        guard ball != nil else { return }
        for peg in gameVM.level.pegs {
            if !peg.isHidden && peg.isCollidingWith(ball!) {
                let newVelocity = PhysicsEngine.calculateCollisionNewVelocity(
                    ball: ball!,
                    peg: peg,
                    coefficientOfRestitution: GameEngine.coefficientOfRestitution
                )
                ball!.setVelocity(newVelocity)
                PhysicsEngine.penetrationResolutionPeg(move: ball!, awayFrom: peg)
                peg.hit()
            }
        }
    }

    private func checkBallOut() -> Bool {
        return gameVM.isBallInPlay && ball != nil && ball!.y >= gameVM.level.boardSize.height - Ball.radius
    }

    private func hideHitPegs() {
        gameVM.ballOut()
    }

    // Keep track of a sliding window (using a queue) of past positions.
    // If current position is within a certain distance of the first position in the window
    // means, the ball hasn't moved much and is considered stuck and we prematurely remove pegs
    private func updateAutoHide() {
        guard ball != nil else { return }
        let numPositionsToTrack = Int(GameEngine.minDurationToAutoHide / GameEngine.frameDuration)
        if autoHideBenchmarkPositions.count < numPositionsToTrack {
            autoHideBenchmarkPositions.enqueue(ball!.position)
        } else if let first = autoHideBenchmarkPositions.dequeue() {
            if first.distance(to: ball!.position) <= Ball.size {
                gameVM.level.hideHitPegs()
                autoHideBenchmarkPositions.clear()
            } else {
                autoHideBenchmarkPositions.enqueue(ball!.position)
            }
        }
    }
}
