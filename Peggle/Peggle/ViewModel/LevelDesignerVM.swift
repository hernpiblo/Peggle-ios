//
//  LevelDesignerVM.swift
//  Peggle
//
//  Created by proglab on 1/2/24.
//

import SwiftUI

class LevelDesignerVM: ObservableObject {
    @Published private var level = Level()

    // === Peg ===
    func getPegs() -> [Peg] {
        return level.getPegs()
    }


    func addPeg(at position: CGPoint, in geoSize: CGSize, pegColor: PegColor) {
        level.addPeg(at: position, in: geoSize, pegColor: pegColor)
    }


    func removePeg(_ peg: Peg) {
        level.removePeg(peg)
    }


    func updatePegPosition(_ peg: Peg, _ dragOffset: CGSize, in geoSize: CGSize) {
        level.updatePegPosition(peg, with: dragOffset, in: geoSize)
    }


    // === Level ===
    func resetLevel() {
        level.resetLevel()
    }


    func saveLevel(_ levelName: String) -> Bool {
        return level.saveLevel(levelName)
    }


    func loadLevel(_ levelName: String) -> Bool {
        guard let level: Level = LevelManager.loadLevel(levelName: levelName) else { return false }
        self.level = level
        return true
    }


    func isEmpty() -> Bool {
        return level.isEmpty()
    }
}
