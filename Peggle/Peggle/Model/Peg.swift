//
//  Peg.swift
//  Peggle
//
//  Created by proglab on 12/2/24.
//

import SwiftUI

@Observable
class Peg: Codable, Equatable, Hashable {
    static let defaultRadius: CGFloat = 25
    private let circleStaticBody: CircleStaticBody
    private(set) var isHit = false
    private(set) var isHidden = false
    private(set) var color: PegColor = .blue
    var position: CGPoint { circleStaticBody.position }
    var x: CGFloat { circleStaticBody.position.x }
    var y: CGFloat { circleStaticBody.position.y }
    var radius: CGFloat { circleStaticBody.radius }
    var size: CGFloat { radius * 2 }

    init(position: CGPoint, radius: CGFloat, color: PegColor) {
        self.circleStaticBody = CircleStaticBody(position: position, radius: radius)
        self.color = color
    }
    
    init(circleStaticBody: CircleStaticBody) {
        self.circleStaticBody = circleStaticBody
    }
    
    func hit() {
        isHit = true
    }
    
    func hide() {
        isHidden = true
    }
    
    func isOverlapping(with other: Peg) -> Bool {
        return circleStaticBody.isOverlapping(with: other.circleStaticBody)
    }
    
    func isCollidingWith(_ ball: Ball) -> Bool {
        return circleStaticBody.isCollidingWith(ball)
    }
    
    func getIfMoved(with dragOffset: CGSize) -> Peg {
        return Peg(circleStaticBody: circleStaticBody.getIfMoved(with: dragOffset))
    }
    
    func updatePosition(with dragOffset: CGSize) {
        circleStaticBody.updatePosition(with: dragOffset)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(circleStaticBody)
        hasher.combine(color)
    }
    
    static func == (lhs: Peg, rhs: Peg) -> Bool {
        return lhs.circleStaticBody == rhs.circleStaticBody
        && lhs.isHit == rhs.isHit
        && lhs.isHidden == rhs.isHidden
        && lhs.color == rhs.color
    }
}
