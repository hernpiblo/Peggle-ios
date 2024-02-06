//
//  Peg.swift
//  Peggle
//
//  Created by proglab on 24/1/24.
//

import Foundation

struct Peg: Hashable, Codable {
    private var position: CGPoint
    private let color: PegColor
    private var isHit = false
    private var imageName: String {
        Peg.getImageName(color, isHit: isHit)
    }

    init(position: CGPoint, color: PegColor) {
        self.position = position
        self.color = color
    }


    func getPosition() -> CGPoint {
        return position
    }


    func getColor() -> PegColor {
        return color
    }


    func getImageName() -> String {
        return Peg.getImageName(color, isHit: isHit)
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


    mutating func hit() {
        isHit = true
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
