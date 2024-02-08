//
//  Extensions.swift
//  Peggle
//
//  Created by proglab on 31/1/24.
//

import SwiftUI

extension CGPoint: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }


    func distance(to point: CGPoint) -> CGFloat {
        return sqrt(pow((point.x - x), 2) + pow((point.y - y), 2))
    }
}

extension CGVector: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(dx)
        hasher.combine(dy)
    }
}
