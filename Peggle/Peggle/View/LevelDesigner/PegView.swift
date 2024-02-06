//
//  PegView.swift
//  Peggle
//
//  Created by proglab on 1/2/24.
//

import SwiftUI

struct PegView: View {
    static let pegSize: CGFloat = 50
    let peg: Peg
    let geoSize: CGSize
    @ObservedObject var levelDesignerVM: LevelDesignerVM
    @Binding var isEraseMode: Bool
    @State private var dragOffset: CGSize = .zero

    var body: some View {
        Image(peg.getImageName())
            .resizable()
            .frame(width: PegView.pegSize, height: PegView.pegSize)
            .position(peg.position)
            .offset(x: dragOffset.width, y: dragOffset.height)
            .onTapGesture { onTap() }
            .onLongPressGesture(minimumDuration: 0.5, perform: { onLongPress() })
            .gesture(onDrag())
    }


    private func onTap() {
        guard isEraseMode else { return }
        levelDesignerVM.removePeg(peg)
    }


    private func onLongPress() {
        levelDesignerVM.removePeg(peg)
    }


    private func onDrag() -> _EndedGesture<_ChangedGesture<DragGesture>> {
        return DragGesture(coordinateSpace: .global)
            .onChanged { value in
                dragOffset = value.translation
            }
            .onEnded { value in
                levelDesignerVM.updatePegPosition(peg, value.translation, in: geoSize)
                dragOffset = .zero
            }
    }
}
