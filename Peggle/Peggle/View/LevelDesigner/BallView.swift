//
//  BallView.swift
//  Peggle
//
//  Created by proglab on 1/2/24.
//

import SwiftUI

struct BallView: View {
    static let ballSize: CGFloat = 50
    let ball: Ball
    let geoSize: CGSize
    @ObservedObject var levelDesignerVM: LevelDesignerVM
    @Binding var isEraseMode: Bool
    @State private var dragOffset: CGSize = .zero

    var body: some View {
        Image(ball.imageName)
            .resizable()
            .frame(width: BallView.ballSize, height: BallView.ballSize)
            .position(ball.position)
            .offset(x: dragOffset.width, y: dragOffset.height)
            .onTapGesture { onTap() }
            .onLongPressGesture(minimumDuration: 0.5, perform: { onLongPress() })
            .gesture(onDrag())
    }


    private func onTap() {
        guard isEraseMode else { return }
        levelDesignerVM.removeBall(ball)
    }


    private func onLongPress() {
        levelDesignerVM.removeBall(ball)
    }


    private func onDrag() -> _EndedGesture<_ChangedGesture<DragGesture>> {
        return DragGesture(coordinateSpace: .global)
            .onChanged { value in
                dragOffset = value.translation
            }
            .onEnded { value in
                levelDesignerVM.updateBallPosition(ball, value.translation, in: geoSize)
                dragOffset = .zero
            }
    }
}
