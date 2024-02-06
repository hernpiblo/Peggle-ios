//
//  Peg.swift
//  Peggle
//
//  Created by proglab on 24/1/24.
//

import Foundation

struct Peg: Hashable, Codable {
    var position: CGPoint
    private let color: PegColor
    private var imageName: String {
        Peg.getImageName(color)
    }

    init(position: CGPoint, color: PegColor) {
        self.position = position
        self.color = color
    }


    func getColor() -> PegColor {
        return color
    }


    func getImageName() -> String {
        return Peg.getImageName(color)
    }


    static func getImageName(_ color: PegColor) -> String {
        switch color {
        case .blue:
            return Constants.ImageName.PEG_BLUE
        case .orange:
            return Constants.ImageName.PEG_ORANGE
        }
    }
}
