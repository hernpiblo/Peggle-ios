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
}
