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

    init(gameVM: GameVM, peg: Peg) {
        self.gameVM = gameVM
        self.peg = peg
    }

    var body: some View {
        Image(PegView.getImageName(of: peg.color, isHit: peg.isHit))
            .resizable()
            .frame(width: peg.size, height: peg.size)
            .position(peg.position)
            .opacity(peg.isHidden ? 0 : 1)
            .animation(.easeOut(duration: 1.0), value: peg.isHidden)
    }
}
