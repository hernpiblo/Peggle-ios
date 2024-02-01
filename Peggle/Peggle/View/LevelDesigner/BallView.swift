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
    let geoSize : CGSize
    @ObservedObject var levelDesignerVM: LevelDesignerVM
    @Binding var isEraseMode: Bool
    @State private var dragOffset: CGSize = .zero

    var body: some View {
        Image(ball.imageName)
            .resizable()
            .frame(width: BallView.ballSize, height: BallView.ballSize)
            .position(ball.position)
            .offset(x: dragOffset.width, y: dragOffset.height)
            .onTapGesture {
                guard isEraseMode else { return }
                levelDesignerVM.removeBall(ball)
            }
            .onLongPressGesture(minimumDuration: 0.5, perform: {
                levelDesignerVM.removeBall(ball)
            })
            .gesture(
                DragGesture(coordinateSpace: .global)
                    .onChanged { value in
                        dragOffset = value.translation
                    }
                    .onEnded { value in
                        levelDesignerVM.updateBallPosition(ball, value.translation, in: geoSize)
                        dragOffset = .zero
                    }
            )
    }
}

//#Preview {
//    BallView(ball: Ball(position: CGPoint(x: 10, y: 10), color: .blue))
//}
