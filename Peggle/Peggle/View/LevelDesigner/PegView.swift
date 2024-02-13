//
//  PegView.swift
//  Peggle
//
//  Created by proglab on 13/2/24.
//

import SwiftUI

struct PegView: View {
    var levelDesignerVM: LevelDesignerVM
    @Binding var isEraseMode: Bool
    @State private var dragOffset: CGSize = .zero
    let peg: Peg

    var body: some View {
        Image(getImageName())
            .resizable()
            .frame(width: peg.size, height: peg.size)
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
                levelDesignerVM.updatePegPosition(peg, value.translation)
                dragOffset = .zero
            }
    }
    
    private func getImageName() -> String {
        return PegView.getImageName(of: peg.color, isHit: peg.isHit)
    }
    
    static func getImageName(of color: PegColor, isHit: Bool) -> String {
        switch color {
        case .blue:
            return isHit ? Constants.ImageName.PEG_BLUE_LIT : Constants.ImageName.PEG_BLUE
        case .orange:
            return isHit ? Constants.ImageName.PEG_ORANGE_LIT : Constants.ImageName.PEG_ORANGE
        }
    }
}
