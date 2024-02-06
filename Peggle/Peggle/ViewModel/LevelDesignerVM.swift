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


    func addPeg(at position: CGPoint, in size: CGSize, pegColor: PegColor) {
        guard isPointInView(position, pegSize: PegView.pegSize, in: size) else { return }
        guard !isPointOverlapping(position, pegSize: PegView.pegSize) else { return }

        let newPeg = Peg(position: position, color: pegColor)
        level.addPeg(newPeg)
    }


    func removePeg(_ peg: Peg) {
        level.removePeg(peg)
    }


    func updatePegPosition(_ peg: Peg, _ dragOffset: CGSize, in geoSize: CGSize) {
        let newPosition = CGPoint(x: peg.position.x + dragOffset.width, y: peg.position.y + dragOffset.height)
        guard isPointInView(newPosition, pegSize: PegView.pegSize, in: geoSize) else { return }
        guard !isPointOverlapping(newPosition, pegSize: PegView.pegSize) else { return }
        level.updatePegPosition(peg, to: newPosition)
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


    private func isPointInView(_ point: CGPoint, pegSize: CGFloat, in size: CGSize) -> Bool {
        return point.x - pegSize / 2 >= 0 && point.x + pegSize / 2 <= size.width
            && point.y - pegSize / 2 >= 0 && point.y + pegSize / 2 <= size.height
    }


    private func isPointOverlapping(_ point: CGPoint, pegSize: CGFloat) -> Bool {
        return level.isPointOverlapping(point, pegSize)
    }
}
