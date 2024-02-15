//
//  NewLevel.swift
//  Peggle
//
//  Created by proglab on 12/2/24.
//

import Foundation

@Observable
class Level: Codable {
    private(set) var pegs: [Peg]
    private(set) var name: String
    private(set) var boardSize: CGSize
    var isEmpty: Bool { pegs.isEmpty }

    init(pegs: [Peg], name: String, boardSize: CGSize) {
        self.pegs = pegs
        self.name = name
        self.boardSize = boardSize
    }

    init() {
        self.pegs = []
        self.name = ""
        self.boardSize = CGSize()
    }

    func setName(_ name: String) {
        self.name = name
    }

    // === Pegs ===
    func addPeg(_ peg: Peg, cannonSize: CGFloat) -> Bool {
        guard isPegInView(peg) else { return false }
        guard !isPegOverlapping(peg, ignore: nil) else { return false }
        guard isPegOutsideCannon(peg, cannonSize: cannonSize) else { return false }
        pegs.append(peg)
        return true
    }

    private func isPegInView(_ peg: Peg) -> Bool {
        return peg.x - peg.radius >= 0 && peg.x + peg.radius <= boardSize.width
            && peg.y - peg.radius >= 0 && peg.y + peg.radius <= boardSize.height
    }

    private func isPegOverlapping(_ newPeg: Peg, ignore ignoredPeg: Peg?) -> Bool {
        for peg in pegs where peg.isOverlapping(with: newPeg) {
            if (ignoredPeg == nil) || (ignoredPeg != nil && peg != ignoredPeg) {
                return true
            }
        }
        return false
    }

    private func isPegOutsideCannon(_ peg: Peg, cannonSize: CGFloat) -> Bool {
        let cannonPos = CGPoint(x: boardSize.width / 2, y: 45)
        if peg.x + Peg.defaultRadius > cannonPos.x - cannonSize / 2
            && peg.x - Peg.defaultRadius < cannonPos.x + cannonSize / 2
            && peg.y - Peg.defaultRadius < cannonPos.y + cannonSize / 2 {
            return false
        }
        return true
    }

    func removePeg(_ peg: Peg) {
        pegs.removeAll(where: { $0 == peg })
    }

    func updatePegPosition(_ peg: Peg, with dragOffset: CGSize, cannonSize: CGFloat) {
        guard let index = pegs.firstIndex(of: peg) else { return }
        let pegIfMoved = pegs[index].getIfMoved(with: dragOffset)
        guard isPegInView(pegIfMoved) else { return }
        guard !isPegOverlapping(pegIfMoved, ignore: peg) else { return }
        guard isPegOutsideCannon(pegIfMoved, cannonSize: cannonSize) else { return }
        peg.updatePosition(with: dragOffset)
    }

    func hideHitPegs() {
        for peg in pegs {
            if peg.isHit && !peg.isHidden {
                peg.hide()
            }
        }
    }

    // === Level ===
    func resetLevel() {
        pegs.removeAll()
    }

    func setSize(_ size: CGSize) {
        boardSize = size
    }
}
