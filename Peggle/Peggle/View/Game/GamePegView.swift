//
//  GamePegView.swift
//  Peggle
//
//  Created by proglab on 7/2/24.
//

import SwiftUI

struct GamePegView: View {
    @ObservedObject var gameVM: GameVM
    let peg: Peg
    @State var isHit: Bool

    init(gameVM: GameVM, peg: Peg) {
        self.gameVM = gameVM
        self.peg = peg
        _isHit = State(initialValue: peg.isHit)
    }

    var body: some View {
        Image(peg.getImageName())
            .resizable()
            .frame(width: PegView.pegSize, height: PegView.pegSize)
            .position(peg.getPosition())
            .onReceive(gameVM.objectWillChange) { _ in
                isHit = peg.isHit
            }
//            .opacity(peg.isHidden ? 0 : 1)
//            .opacity(gameVM.isHidingProcess ? 0 : 1)
    }
}
