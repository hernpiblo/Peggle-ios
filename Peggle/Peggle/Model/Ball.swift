//
//  Ball.swift
//  Peggle
//
//  Created by proglab on 6/2/24.
//

import Foundation

struct Ball {
    static let ballRadius: CGFloat = 20
    private var ballPhysicsBody: BallPhysicsBody
    
    init(position: CGPoint, velocity: CGVector) {
        self.ballPhysicsBody = BallPhysicsBody(position: position, velocity: velocity, radius: Ball.ballRadius)
    }
    
    
    func getPosition() -> CGPoint {
        return ballPhysicsBody.position
    }
    
    
    func getVelocity() -> CGVector {
        return ballPhysicsBody.velocity
    }
    
    
    mutating func reverseVx() -> Ball {
        ballPhysicsBody = ballPhysicsBody.reverseVx()
        return self
    }
    
    
    mutating func reverseVy() -> Ball {
        ballPhysicsBody = ballPhysicsBody.reverseVy()
        return self
    }


    mutating func setVelocity(_ velocity: CGVector) -> Ball {
        ballPhysicsBody = ballPhysicsBody.setVelocity(velocity)
        return self
    }


    func getImageName() -> String {
        return Constants.ImageName.BALL
    }
}
