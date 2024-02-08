//
//  CircleStaticBody.swift
//  Peggle
//
//  Created by proglab on 7/2/24.
//

import Foundation

struct CircleStaticBody: StaticBody {
    var position: CGPoint
    var radius: CGFloat

    func getPosition() -> CGPoint {
        return position
    }


    func getNewPosition(with dragOffset: CGSize) -> CGPoint {
        return CGPoint(x: position.x + dragOffset.width, y: position.y + dragOffset.height)
    }


    mutating func updatePosition(to newPosition: CGPoint) {
        position = newPosition
    }


    func isOverlapping(with other: CGPoint, pegSize: CGFloat) -> Bool {
        return abs(position.x - other.x) < pegSize && abs(position.y - other.y) < pegSize
    }


    func isCollidingWith(_ ball: Ball) -> Bool {
        return position.distance(to: ball.getPosition()) <= radius + Ball.ballRadius
    }
}
