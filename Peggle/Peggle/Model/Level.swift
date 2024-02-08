//
//  Level.swift
//  Peggle
//
//  Created by proglab on 1/2/24.
//

import Foundation
import SwiftUI

struct Level: Codable {
    private var name: String
    private var pegs: [Peg]
    private var size: CGSize

    init(name: String, pegs: [Peg], size: CGSize) {
        self.name = name
        self.pegs = pegs
        self.size = size
    }


    init() {
        self.name = ""
        self.pegs = []
        self.size = CGSize()
    }


    func getName() -> String {
        return name
    }


    func getPegs() -> [Peg] {
        return pegs
    }


    func getSize() -> CGSize {
        return size
    }


    mutating func setSize(_ size: CGSize) {
        self.size = size
    }


    func getOrigin() -> CGPoint {
        return CGPoint(x: size.width / 2, y: 0)
    }


    mutating func addPeg(at position: CGPoint, in geoSize: CGSize, pegColor: PegColor) {
        guard isPointInView(position, pegRadius: PegView.pegRadius, in: geoSize) else { return }
        guard !isPointOverlapping(position, PegView.pegSize) else { return }
        let newPeg = Peg(position: position, color: pegColor, radius: PegView.pegRadius)
        pegs.append(newPeg)
    }


    mutating func removePeg(_ peg: Peg) {
        pegs.removeAll(where: { $0 == peg })
    }


    mutating func updatePegPosition(_ peg: Peg, with dragOffset: CGSize, in geoSize: CGSize) {
        let newPosition = peg.getNewPosition(with: dragOffset)
        guard isPointInView(newPosition, pegRadius: PegView.pegRadius, in: geoSize) else { return }
        guard !isPointOverlapping(newPosition, PegView.pegSize) else { return }
        var updatedPeg = peg
        updatedPeg.updatePosition(to: newPosition)
        guard let index = pegs.firstIndex(of: peg) else { return }
        pegs[index] = updatedPeg
    }
    
    mutating func hitPeg(_ peg: Peg) {
        guard let index = pegs.firstIndex(of: peg) else { return }
        let hitPeg = peg.hit()
        pegs[index] = hitPeg
    }
    
    
    mutating func hideHitPegs() {
        for peg in pegs {
            if peg.isHit && !peg.isHidden {
                guard let index = pegs.firstIndex(of: peg) else { return }
                let hiddenPeg = peg.hide()
                pegs[index] = hiddenPeg
            }
        }
    }


    // If level name exists, then update the existing level, else create a new level to save
    func saveLevel(_ levelName: String) -> Bool {
        if LevelManager.checkLevelNameExist(levelName) {
            return LevelManager.saveLevel(self)
        } else {
            let newLevel = Level(name: levelName, pegs: pegs, size: size)
            return LevelManager.saveLevel(newLevel)
        }
    }


    mutating func resetLevel() {
        pegs.removeAll()
    }


    private func isPointInView(_ point: CGPoint, pegRadius: CGFloat, in size: CGSize) -> Bool {
        return point.x - pegRadius >= 0 && point.x + pegRadius <= size.width
            && point.y - pegRadius >= 0 && point.y + pegRadius <= size.height
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
