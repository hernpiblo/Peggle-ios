//
//  Ball.swift
//  Peggle
//
//  Created by proglab on 24/1/24.
//

import Foundation

struct Ball: Hashable, Codable {
    var position: CGPoint
    private let color: BallColor
    private var imageName: String {
        Ball.getImageName(color)
    }

    init(position: CGPoint, color: BallColor) {
        self.position = position
        self.color = color
    }


    func getColor() -> BallColor {
        return color
    }


    func getImageName() -> String {
        return Ball.getImageName(color)
    }


    static func getImageName(_ color: BallColor) -> String {
        switch color {
        case .blue:
            return Constants.ImageName.BALL_BLUE
        case .orange:
            return Constants.ImageName.BALL_ORANGE
        }
    }
}
