//
//  Ball.swift
//  Peggle
//
//  Created by proglab on 24/1/24.
//

import Foundation

struct Ball : Hashable {
    var position: CGPoint
    let color: BallColor
    var imageName: String {
        Ball.getImageName(color)
    }
    
    static func getImageName(_ color: BallColor) -> String {
        switch color {
        case .blue:
            return "ball-blue"
        case .orange:
            return "ball-orange"
        }
    }
}
