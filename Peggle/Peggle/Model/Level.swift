//
//  Level.swift
//  Peggle
//
//  Created by proglab on 1/2/24.
//

import Foundation

struct Level: Codable {
    private var name: String
    private var balls: [Ball]

    init(name: String, balls: [Ball]) {
        self.name = name
        self.balls = balls
    }


    init() {
        self.name = ""
        self.balls = []
    }


    func getName() -> String {
        return name
    }


    func getBalls() -> [Ball] {
        return balls
    }


    mutating func addBall(_ ball: Ball) {
        balls.append(ball)
    }


    mutating func removeBall(_ ball: Ball) {
        balls.removeAll(where: { $0 == ball })
    }


    mutating func updateBallPosition(_ ball: Ball, to position: CGPoint) {
        guard let index = balls.firstIndex(of: ball) else { return }

        var updatedBall = ball
        updatedBall.position = position
        balls[index] = updatedBall
    }


    // If level name exists, then update the existing level, else create a new level to save
    func saveLevel(_ levelName: String) -> Bool {
        if LevelManager.checkLevelNameExist(levelName) {
            return LevelManager.saveLevel(self)
        } else {
            let newLevel = Level(name: levelName, balls: balls)
            return LevelManager.saveLevel(newLevel)
        }
    }


    mutating func resetLevel() {
        balls.removeAll()
    }


    func isPointOverlapping(_ point: CGPoint, _ ballSize: CGFloat) -> Bool {
        for ball in balls {
            if abs(ball.position.x - point.x) < ballSize && abs(ball.position.y - point.y) < ballSize {
                return true
            }
        }
        return false
    }


    func isEmpty() -> Bool {
        return balls.isEmpty
    }
}
