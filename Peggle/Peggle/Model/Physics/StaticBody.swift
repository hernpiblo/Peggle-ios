//
//  StaticBody.swift
//  Peggle
//
//  Created by proglab on 7/2/24.
//

import Foundation

protocol StaticBody: Saveable, Hashable {
    var position: CGPoint { get }
    func isCollidingWith(_ ball: Ball) -> Bool
}
