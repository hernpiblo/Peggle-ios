//
//  BallPhysicsBody.swift
//  Peggle
//
//  Created by proglab on 7/2/24.
//

import Foundation

@Observable
class BallPhysicsBody {
    private(set) var position: CGPoint
    private(set) var velocity: CGVector
    private(set) var radius: CGFloat

    init(position: CGPoint, velocity: CGVector, radius: CGFloat) {
        self.position = position
        self.velocity = velocity
        self.radius = radius
    }

    func reverseVx() {
        velocity.dx *= -1
    }

    func reverseVy() {
        velocity.dy *= -1
    }

    func setPosition(_ position: CGPoint) {
        self.position = position
    }

    func setVelocity(_ velocity: CGVector) {
        self.velocity = velocity
    }
}
