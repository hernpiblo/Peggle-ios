//
//  GamePegView.swift
//  Peggle
//
//  Created by proglab on 7/2/24.
//

import SwiftUI

struct GamePegView: View {
    var gameVM: GameVM
    let peg: Peg
    @State var isHit: Bool

    init(gameVM: GameVM, peg: Peg) {
        self.gameVM = gameVM
        self.peg = peg
        _isHit = State(initialValue: peg.isHit)
    }

    var body: some View {
        Image(PegView.getImageName(of: peg.color, isHit: peg.isHit))
            .resizable()
            .frame(width: peg.size, height: peg.size)
            .position(peg.position)
//            .onReceive(gameVM.objectWillChange) { _ in
//                isHit = peg.isHit
//            }
            .opacity(peg.isHidden ? 0 : 1)
    }
}
