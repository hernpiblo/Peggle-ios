//
//  Peg.swift
//  Peggle
//
//  Created by proglab on 24/1/24.
//

import SwiftUI

struct Peg: Hashable, Codable {
    private let color: PegColor
    var isHit = false
    var isHidden = false
    private var imageName: String {
        Peg.getImageName(color, isHit: isHit)
    }
    private var circleStaticBody: CircleStaticBody

    init(position: CGPoint, color: PegColor, radius: CGFloat) {
        self.color = color
        self.circleStaticBody = CircleStaticBody(position: position, radius: radius)
    }


    func getPosition() -> CGPoint {
        return circleStaticBody.getPosition()
    }


    func getColor() -> PegColor {
        return color
    }


    func getImageName() -> String {
        return Peg.getImageName(color, isHit: isHit)
    }


    func getNewPosition(with dragOffset: CGSize) -> CGPoint {
        return circleStaticBody.getNewPosition(with: dragOffset)
    }


    mutating func updatePosition(to newPosition: CGPoint) {
        circleStaticBody.updatePosition(to: newPosition)
    }


    func isOverlapping(with other: CGPoint, pegSize: CGFloat) -> Bool {
        return circleStaticBody.isOverlapping(with: other, pegSize: pegSize)
    }


    func isCollidingWith(_ ball: Ball) -> Bool {
        return circleStaticBody.isCollidingWith(ball)
    }


    func hit() -> Peg {
        var hitPeg = self
        hitPeg.isHit = true
        return hitPeg
    }
    
    func hide() -> Peg {
        var hiddenPeg = self
        hiddenPeg.isHidden = true
        return hiddenPeg
    }


    static func getImageName(_ color: PegColor, isHit: Bool) -> String {
        switch color {
        case .blue:
            return isHit ? Constants.ImageName.PEG_BLUE_LIT : Constants.ImageName.PEG_BLUE
        case .orange:
            return isHit ? Constants.ImageName.PEG_ORANGE_LIT : Constants.ImageName.PEG_ORANGE
        }
    }
}
