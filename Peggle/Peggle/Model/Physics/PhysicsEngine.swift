//
//  PhysicsEngine.swift
//  Peggle
//
//  Created by proglab on 7/2/24.
//

import CoreGraphics

struct PhysicsEngine {
    static let gravity: CGFloat = 3 // Downwards is positive

    static func getInitialVelocity(_ tapLocation: CGPoint, _ origin: CGPoint, magnitude: CGFloat) -> CGVector {
        let displacement = CGVector(dx: tapLocation.x - origin.x, dy: tapLocation.y - origin.y)

        // Normalize
        let length = sqrt(displacement.dx * displacement.dx + displacement.dy * displacement.dy)
        let unitVector = CGVector(dx: displacement.dx / length, dy: displacement.dy / length)

        // Scale unit vector
        let velocity = CGVector(dx: unitVector.dx * magnitude, dy: unitVector.dy * magnitude)

        return velocity
    }


    static func nextFrameBall(ball: Ball, pegs: [Peg], size: CGSize, frameDuration: CGFloat) -> Ball {
        var ballNextPos = getBallWithNextPositionAndVelocity(ball: ball, frameDuration: frameDuration)
        ballNextPos = updateBallBounceWithWall(ball: ballNextPos, size: size)
        ballNextPos = updateBallBounceWithObject(ball: ballNextPos, pegs: pegs)
        return ballNextPos
    }


    static func getBallWithNextPositionAndVelocity(ball: Ball, frameDuration: CGFloat) -> Ball {
        // Displacement (s = ut + 0.5at2)
        let displacementX = ball.getVelocity().dx * frameDuration
        let displacementY = ball.getVelocity().dy * frameDuration + 0.5 * gravity * pow(frameDuration, 2)
        let newX = ball.getPosition().x + displacementX
        let newY = ball.getPosition().y + displacementY
        let newPosition = CGPoint(x: newX, y: newY)

        // Velocity (v = u + at)
        let dampingFactor = 0.995
        let newVelocityX = ball.getVelocity().dx * dampingFactor
        let newVelocityY = ball.getVelocity().dy * dampingFactor + gravity * frameDuration
        let newVelocity = CGVector(dx: newVelocityX, dy: newVelocityY)

        return Ball(position: newPosition, velocity: newVelocity)
    }


    static func updateBallBounceWithWall(ball: Ball, size: CGSize) -> Ball {
        var currentBall = ball
        if currentBall.getPosition().x - Ball.ballRadius <= 0
            || currentBall.getPosition().x - Ball.ballRadius >= size.width {
            return currentBall.reverseVx()
        } else if ball.getPosition().y - Ball.ballRadius <= 0 {
            return currentBall.reverseVy()
        } else {
            return currentBall
        }
    }


    static func updateBallBounceWithObject(ball: Ball, pegs: [Peg]) -> Ball {
        var currentBall = ball
        for peg in pegs {
            if peg.isCollidingWith(ball) {
                let newVelocity = calculateCollisionNewVelocity(ball, peg)
                return currentBall.setVelocity(newVelocity)
            }
        }
        return currentBall
    }


    static func calculateCollisionNewVelocity(_ ball: Ball, _ peg: Peg) -> CGVector {
        let distance = ball.getPosition().distance(to: peg.getPosition())
        // Calculate collision normal vector
        let normalVector = CGVector(dx: peg.getPosition().x - ball.getPosition().x, dy: peg.getPosition().y - ball.getPosition().y)
        let normalUnitVector = CGVector(dx: normalVector.dx / distance, dy: normalVector.dy / distance)
        
        let velocityAlongNormal = ball.getVelocity().dx * normalUnitVector.dx + ball.getVelocity().dy * normalUnitVector.dy
        
        let coefficientOfRestitution: CGFloat = 0.995
        // use elastic colilsion formula to calculate
        let finalVelocity = CGVector(dx: ball.getVelocity().dx - 2 * velocityAlongNormal * normalUnitVector.dx * coefficientOfRestitution,
                                     dy: ball.getVelocity().dy - 2 * velocityAlongNormal * normalUnitVector.dy * coefficientOfRestitution)
        
        return finalVelocity
    }
}
