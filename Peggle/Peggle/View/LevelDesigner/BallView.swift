//
//  BallView.swift
//  Peggle
//
//  Created by proglab on 1/2/24.
//

import SwiftUI

struct BallView: View {
    static let ballSize : CGFloat = 50
    let ball : Ball
    @ObservedObject var levelDesignerVM: LevelDesignerVM
    @Binding var isEraseMode: Bool
    
    var body: some View {
        Image(ball.imageName)
            .resizable()
            .frame(width: BallView.ballSize, height: BallView.ballSize)
            .position(ball.position)
            .onTapGesture {
                guard isEraseMode else { return }
                levelDesignerVM.removeBall(ball)
            }
            .onLongPressGesture(minimumDuration: 0.5, perform: {
                levelDesignerVM.removeBall(ball)
            })
    }
}

//#Preview {
//    BallView(ball: Ball(position: CGPoint(x: 10, y: 10), color: .blue))
//}
