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
    private var autoHideBenchmarkPositions: Queue<CGPoint> = Queue()
    private var currentTimeElapsed: CGFloat = 0
    private (set) var numBalls: Int
    private (set) var points: Int = 0

    private static let frameDuration: CGFloat = 0.50 // Lower = slower gameplay
    private static let gravity: CGFloat = 1.5 // Downwards is positive
    private static let dampingFactor: CGFloat = 0.995 // Lower = more air resistance
    private static let coefficientOfRestitution: CGFloat = 0.95 // Lower = less bouncy
    private static let minDurationToAutoHide: CGFloat = 300.0

    private var displayLink: CADisplayLink!

    init(level: Level, numBalls: Int) {
        self.level = level
        self.numBalls = numBalls
        initDisplayLink()
    }

    private func initDisplayLink() {
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
            frameDuration: GameVM.frameDuration,
            gravity: GameVM.gravity,
            dampingFactor: GameVM.dampingFactor,
            velocityThreshold: 0
        )
    }

    private func updateWallBounce() {
        guard ball != nil else { return }
        PhysicsEngine.updateBallBounceWithWall(
            ball: ball!,
            size: level.boardSize
        )
        PhysicsEngine.penetrationResolutionWall(
            ball: ball!,
            size: level.boardSize
        )
    }

    private func updatePegCollision() {
        guard ball != nil else { return }
        for peg in level.pegs {
            if !peg.isHidden && peg.isCollidingWith(ball!) {
                let newVelocity = PhysicsEngine.calculateCollisionNewVelocity(
                    ball: ball!,
                    peg: peg,
                    coefficientOfRestitution: GameVM.coefficientOfRestitution
                )
                ball!.setVelocity(newVelocity)
                PhysicsEngine.penetrationResolutionPeg(move: ball!, awayFrom: peg)
                peg.hit()
            }
        }
    }

    private func checkBallOut() -> Bool {
        return isBallInPlay && ball != nil && ball!.y >= level.boardSize.height - Ball.radius
    }

    private func hideHitPegs() {
        ball = nil
        isBallInPlay = false
        level.hideHitPegs()
    }

    // Keep track of a sliding window (using a queue) of past positions.
    // If current position is within a certain distance of the first position in the window
    // means, the ball hasn't moved much and is considered stuck and we prematurely remove pegs
    private func updateAutoHide() {
        guard ball != nil else { return }
        let numPositionsToTrack = Int(GameVM.minDurationToAutoHide / GameVM.frameDuration)
        if autoHideBenchmarkPositions.count < numPositionsToTrack {
            autoHideBenchmarkPositions.enqueue(ball!.position)
        } else if let first = autoHideBenchmarkPositions.dequeue() {
            if first.distance(to: ball!.position) <= Ball.size {
                level.hideHitPegs()
                autoHideBenchmarkPositions.clear()
            } else {
                autoHideBenchmarkPositions.enqueue(ball!.position)
            }
        }
    }

    func startLevel(_ levelName: String) {
        guard let level: Level = LevelManager.loadLevel(levelName) else { return }
        self.level = level
    }

    func shootBall(at tapLocation: CGPoint) {
        guard !isBallInPlay else { return }
        let ballInitialPosition = CGPoint(x: level.boardSize.width / 2, y: Ball.radius)
        let ballInitialVelocity = PhysicsEngine.getInitialVelocity(
            tapLocation, ballInitialPosition,
            speed: Ball.initialSpeed
        )
        ball = Ball(position: ballInitialPosition, velocity: ballInitialVelocity)
        isBallInPlay = true
    }
}
