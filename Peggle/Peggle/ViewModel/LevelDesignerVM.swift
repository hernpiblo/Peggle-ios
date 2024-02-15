//
//  LevelDesignerVM.swift
//  Peggle
//
//  Created by proglab on 13/2/24.
//

import SwiftUI

@Observable
class LevelDesignerVM {
    private(set) var level = Level()
    var pegs: [Peg] { level.pegs }

    // === Peg ===
    func addPeg(at position: CGPoint, radius: CGFloat, color: PegColor, cannonSize: CGFloat) -> Bool {
        let peg = Peg(position: position, radius: radius, color: color)
        return level.addPeg(peg, cannonSize: cannonSize)
    }

    func removePeg(_ peg: Peg) {
        level.removePeg(peg)
    }

    func updatePegPosition(_ peg: Peg, _ dragOffset: CGSize, cannonSize: CGFloat) {
        level.updatePegPosition(peg, with: dragOffset, cannonSize: cannonSize)
    }

    // === Level ===
    func resetLevel() {
        level.resetLevel()
    }

    func saveLevel(_ levelName: String) -> Bool {
        setName(levelName)
        return LevelManager.saveLevel(level)
    }

    func loadLevel(_ levelName: String) -> Bool {
        guard let level: Level = LevelManager.loadLevel(levelName) else { return false }
        self.level = level
        return true
    }

    func setName(_ name: String) {
        level.setName(name)
    }

    func setSize(_ size: CGSize) {
        level.setSize(size)
    }

    func isEmpty() -> Bool {
        return level.isEmpty
    }
}
