//
//  Level.swift
//  Peggle
//
//  Created by proglab on 1/2/24.
//

import Foundation

struct Level: Codable {
    private var name: String
    private var pegs: [Peg]

    init(name: String, pegs: [Peg]) {
        self.name = name
        self.pegs = pegs
    }


    init() {
        self.name = ""
        self.pegs = []
    }


    func getName() -> String {
        return name
    }


    func getPegs() -> [Peg] {
        return pegs
    }


    mutating func addPeg(at position: CGPoint, in geoSize: CGSize, pegColor: PegColor) {
        guard isPointInView(position, pegSize: PegView.pegSize, in: geoSize) else { return }
        guard !isPointOverlapping(position, PegView.pegSize) else { return }
        let newPeg = Peg(position: position, color: pegColor)
        pegs.append(newPeg)
    }


    mutating func removePeg(_ peg: Peg) {
        pegs.removeAll(where: { $0 == peg })
    }


    mutating func updatePegPosition(_ peg: Peg, with dragOffset: CGSize, in geoSize: CGSize) {
        let newPosition = peg.getNewPosition(with: dragOffset)
        guard isPointInView(newPosition, pegSize: PegView.pegSize, in: geoSize) else { return }
        guard !isPointOverlapping(newPosition, PegView.pegSize) else { return }
        var updatedPeg = peg
        updatedPeg.updatePosition(to: newPosition)
        guard let index = pegs.firstIndex(of: peg) else { return }
        pegs[index] = updatedPeg
    }


    // If level name exists, then update the existing level, else create a new level to save
    func saveLevel(_ levelName: String) -> Bool {
        if LevelManager.checkLevelNameExist(levelName) {
            return LevelManager.saveLevel(self)
        } else {
            let newLevel = Level(name: levelName, pegs: pegs)
            return LevelManager.saveLevel(newLevel)
        }
    }


    mutating func resetLevel() {
        pegs.removeAll()
    }


    private func isPointInView(_ point: CGPoint, pegSize: CGFloat, in size: CGSize) -> Bool {
        return point.x - pegSize / 2 >= 0 && point.x + pegSize / 2 <= size.width
            && point.y - pegSize / 2 >= 0 && point.y + pegSize / 2 <= size.height
    }


    private func isPointOverlapping(_ point: CGPoint, _ pegSize: CGFloat) -> Bool {
        for peg in pegs where peg.isOverlapping(with: point, pegSize: PegView.pegSize) {
            return true
        }
        return false
    }


    func isEmpty() -> Bool {
        return pegs.isEmpty
    }
}
