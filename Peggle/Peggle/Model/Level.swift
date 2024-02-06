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


    mutating func addPeg(_ peg: Peg) {
        pegs.append(peg)
    }


    mutating func removePeg(_ peg: Peg) {
        pegs.removeAll(where: { $0 == peg })
    }


    mutating func updatePegPosition(_ peg: Peg, to position: CGPoint) {
        guard let index = pegs.firstIndex(of: peg) else { return }

        var updatedPeg = peg
        updatedPeg.position = position
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


    func isPointOverlapping(_ point: CGPoint, _ pegSize: CGFloat) -> Bool {
        for peg in pegs {
            if abs(peg.position.x - point.x) < pegSize && abs(peg.position.y - point.y) < pegSize {
                return true
            }
        }
        return false
    }


    func isEmpty() -> Bool {
        return pegs.isEmpty
    }
}
