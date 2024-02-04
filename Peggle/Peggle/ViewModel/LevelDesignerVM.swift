//
//  LevelDesignerVM.swift
//  Peggle
//
//  Created by proglab on 1/2/24.
//

import SwiftUI

class LevelDesignerVM: ObservableObject {
    @Published private var level = Level()

    // === Ball ===
    func getBalls() -> [Ball] {
        return level.getBalls()
    }


    func addBall(at position: CGPoint, in size: CGSize, ballColor: BallColor) {
        guard isPointInView(position, ballSize: BallView.ballSize, in: size) else { return }
        guard !isPointOverlapping(position, ballSize: BallView.ballSize) else { return }

        let newBall = Ball(position: position, color: ballColor)
        level.addBall(newBall)
    }


    func removeBall(_ ball: Ball) {
        level.removeBall(ball)
    }


    func updateBallPosition(_ ball: Ball, _ dragOffset: CGSize, in geoSize: CGSize) {
        let newPosition = CGPoint(x: ball.position.x + dragOffset.width, y: ball.position.y + dragOffset.height)
        guard isPointInView(newPosition, ballSize: BallView.ballSize, in: geoSize) else { return }
        guard !isPointOverlapping(newPosition, ballSize: BallView.ballSize) else { return }
        level.updateBallPosition(ball, to: newPosition)
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


    private func isPointInView(_ point: CGPoint, ballSize: CGFloat, in size: CGSize) -> Bool {
        return point.x - ballSize / 2 >= 0 && point.x + ballSize / 2 <= size.width
            && point.y - ballSize / 2 >= 0 && point.y + ballSize / 2 <= size.height
    }


    private func isPointOverlapping(_ point: CGPoint, ballSize: CGFloat) -> Bool {
        return level.isPointOverlapping(point, ballSize)
    }
}
