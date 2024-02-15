//
//  Ball.swift
//  Peggle
//
//  Created by proglab on 13/2/24.
//

import Foundation

@Observable
class Ball {
    static let radius: CGFloat = 25
    static var size: CGFloat { radius * 2 }
    static let initialSpeed: CGFloat = 40

    private var ballPhysicsBody: BallPhysicsBody
    var position: CGPoint { ballPhysicsBody.position }
    var x: CGFloat { ballPhysicsBody.position.x }
    var y: CGFloat { ballPhysicsBody.position.y }
    var dx: CGFloat { ballPhysicsBody.velocity.dx }
    var dy: CGFloat { ballPhysicsBody.velocity.dy }

    init(position: CGPoint, velocity: CGVector) {
        self.ballPhysicsBody = BallPhysicsBody(position: position, velocity: velocity, radius: Ball.radius)
    }

    func reverseVx() {
        ballPhysicsBody.reverseVx()
    }

    func reverseVy() {
        ballPhysicsBody.reverseVy()
    }

    func setPosition(_ position: CGPoint) {
        ballPhysicsBody.setPosition(position)
    }

    func setVelocity(_ velocity: CGVector) {
        ballPhysicsBody.setVelocity(velocity)
    }
}
