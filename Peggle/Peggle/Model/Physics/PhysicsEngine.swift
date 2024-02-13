//
//  PhysicsEngine.swift
//  Peggle
//
//  Created by proglab on 7/2/24.
//

import CoreGraphics

struct PhysicsEngine {
    static func getInitialVelocity(_ tapLocation: CGPoint, _ origin: CGPoint, speed: CGFloat) -> CGVector {
        let displacement = CGVector(dx: tapLocation.x - origin.x, dy: tapLocation.y - origin.y)

        // Normalize
        let length = sqrt(displacement.dx * displacement.dx + displacement.dy * displacement.dy)
        let unitVector = CGVector(dx: displacement.dx / length, dy: displacement.dy / length)

        // Scale unit vector
        let velocity = CGVector(dx: unitVector.dx * speed, dy: unitVector.dy * speed)

        return velocity
    }

    static func updateBallNextFrame(ball: Ball, frameDuration: CGFloat, gravity: CGFloat, dampingFactor: CGFloat) {
        // Displacement (s = ut + 0.5at2)
        let displacementX = ball.dx * frameDuration
        let displacementY = ball.dy * frameDuration + 0.5 * gravity * pow(frameDuration, 2)
        let newX = ball.x + displacementX
        let newY = ball.y + displacementY
        let newPosition = CGPoint(x: newX, y: newY)
        ball.setPosition(newPosition)
        
        // Velocity (v = u + at)
        let newVelocityX = ball.dx * dampingFactor
        let newVelocityY = ball.dy * dampingFactor + gravity * frameDuration
        let newVelocity = CGVector(dx: newVelocityX, dy: newVelocityY)
        ball.setVelocity(newVelocity)
    }

    static func updateBallBounceWithWall(ball: Ball, size: CGSize) {
        if ball.x - Ball.radius <= 0 || ball.x - Ball.radius >= size.width {
            ball.reverseVx()
        } else if ball.y - Ball.radius <= 0 {
            ball.reverseVy()
        }
    }

    static func updateBallBounceWithObject(ball: Ball, pegs: [Peg], coefficientOfRestitution: CGFloat) {
        for peg in pegs {
            if peg.isCollidingWith(ball) {
                let newVelocity = calculateCollisionNewVelocity(ball: ball, peg: peg, coefficientOfRestitution: coefficientOfRestitution)
                ball.setVelocity(newVelocity)
                break
            }
        }
    }

    static func calculateCollisionNewVelocity(ball: Ball, peg: Peg, coefficientOfRestitution: CGFloat) -> CGVector {
        let distance = ball.position.distance(to: peg.position)
        // Calculate collision normal vector
        let normalVector = CGVector(dx: peg.x - ball.x, dy: peg.y - ball.y)
        let normalUnitVector = CGVector(dx: normalVector.dx / distance, dy: normalVector.dy / distance)
        
        let velocityAlongNormal = ball.dx * normalUnitVector.dx + ball.dy * normalUnitVector.dy
        
        // use elastic colilsion formula to calculate
        let finalVelocity = CGVector(dx: ball.dx - 2 * velocityAlongNormal * normalUnitVector.dx * coefficientOfRestitution,
                                     dy: ball.dy - 2 * velocityAlongNormal * normalUnitVector.dy * coefficientOfRestitution)
        
        return finalVelocity
    }

//    static func penetrationResolution(move ball: Ball, awayFrom peg: Peg) {
//        let distance = ball.position.distance(to: peg.position)
//        let overlap = Ball.radius + peg.radius - distance
//        
//        if overlap > 0 {
//            let directionVector = CGVector(dx: peg.x - ball.x,
//                                           dy: peg.y - ball.y)
//            let normalizedDirection = CGVector(dx: directionVector.dx / distance,
//                                               dy: directionVector.dy / distance)
//            
//            let newBallPosition = CGPoint(x: ball.x + normalizedDirection.dx * overlap,
//                                          y: ball.y + normalizedDirection.dy * overlap)
//            ball.setPosition(newBallPosition)
//        }
//    }
}
