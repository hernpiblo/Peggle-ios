//
//  Ball.swift
//  Peggle
//
//  Created by proglab on 6/2/24.
//

import Foundation

struct Ball {
    private var position: CGPoint
    private var velocity: CGVector

    init(position: CGPoint, velocity: CGVector) {
        self.position = position
        self.velocity = velocity
    }


    mutating func updatePosition(_ newPosition: CGPoint) {
        position = newPosition
    }


}
