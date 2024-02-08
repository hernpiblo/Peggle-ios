//
//  BallView.swift
//  Peggle
//
//  Created by proglab on 7/2/24.
//

import SwiftUI

struct BallView: View {
    static let ballRadius: CGFloat = 25
    static var ballSize: CGFloat { ballRadius * 2 }
    @ObservedObject var gameVM: GameVM
    var ball: Ball

    var body: some View {
        Image(ball.getImageName())
            .resizable()
            .frame(width: BallView.ballSize, height: BallView.ballSize)
            .position(ball.getPosition())
    }
}
