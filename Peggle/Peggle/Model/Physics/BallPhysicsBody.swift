//
//  BallPhysicsBody.swift
//  Peggle
//
//  Created by proglab on 7/2/24.
//

import Foundation

struct BallPhysicsBody {
    var position: CGPoint
    var velocity: CGVector
    var radius: CGFloat

    func reverseVx() -> BallPhysicsBody {
        let newVelocity = CGVector(dx: velocity.dx * -1, dy: velocity.dy)
        return BallPhysicsBody(position: position, velocity: newVelocity, radius: radius)
    }


    func reverseVy() -> BallPhysicsBody {
        let newVelocity = CGVector(dx: velocity.dx, dy: velocity.dy * -1)
        return BallPhysicsBody(position: position, velocity: newVelocity, radius: radius)
    }


    func setVelocity(_ velocity: CGVector) -> BallPhysicsBody {
        return BallPhysicsBody(position: position, velocity: velocity, radius: radius)
    }
}
