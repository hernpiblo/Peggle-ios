//
//  BallView.swift
//  Peggle
//
//  Created by proglab on 7/2/24.
//

import SwiftUI

struct BallView: View {
    var gameVM: GameViewModel
    var ball: Ball

    var body: some View {
        Image(Constants.ImageName.BALL)
            .resizable()
            .frame(width: Ball.size, height: Ball.size)
            .position(ball.position)
    }
}
