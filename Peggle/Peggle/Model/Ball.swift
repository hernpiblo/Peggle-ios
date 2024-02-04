//
//  Ball.swift
//  Peggle
//
//  Created by proglab on 24/1/24.
//

import Foundation

struct Ball: Hashable, Codable {
    var position: CGPoint
    let color: BallColor
    var imageName: String {
        Ball.getImageName(color)
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
