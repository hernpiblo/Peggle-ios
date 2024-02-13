//
//  CircleStaticBody.swift
//  Peggle
//
//  Created by proglab on 7/2/24.
//

import Foundation

@Observable
class CircleStaticBody: StaticBody {
    var position: CGPoint
    private(set) var radius: CGFloat
    var x: CGFloat { position.x }
    var y: CGFloat { position.y }
    
    init(position: CGPoint, radius: CGFloat) {
        self.position = position
        self.radius = radius
    }


    func getIfMoved(with dragOffset: CGSize) -> CircleStaticBody {
        let point = CGPoint(x: position.x + dragOffset.width, y: position.y + dragOffset.height)
        return CircleStaticBody(position: point, radius: radius)
    }

    func updatePosition(with dragOffset: CGSize) {
        position = CGPoint(x: position.x + dragOffset.width, y: position.y + dragOffset.height)
    }

    func isOverlapping(with other: CircleStaticBody) -> Bool {
        return abs(position.x - other.x) < radius + other.radius && abs(position.y - other.y) < radius + other.radius
    }

    func isCollidingWith(_ ball: Ball) -> Bool {
        return position.distance(to: ball.position) <= radius + Ball.radius
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(position.x)
        hasher.combine(position.y)
        hasher.combine(radius)
    }
    
    static func == (lhs: CircleStaticBody, rhs: CircleStaticBody) -> Bool {
        return lhs.position.equalTo(rhs.position) && lhs.radius.isEqual(to: rhs.radius)
    }
}
