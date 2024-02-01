//
//  LevelDesignerVM.swift
//  Peggle
//
//  Created by proglab on 1/2/24.
//

import SwiftUI

class LevelDesignerVM: ObservableObject {
    @Published var balls: [Ball] = []
    
    // === Ball ===
    func addBall(at position: CGPoint, in size: CGSize, ballColor: BallColor) {
        
        guard isPointInView(position, ballSize: BallView.ballSize, in: size) else { return }
        guard !isPointOverlapping(position, ballSize: BallView.ballSize) else { return }
        
        let newBall = Ball(position: position, color: ballColor)
        balls.append(newBall)
    }
    
    
    func removeBall(_ ball : Ball) {
        balls.removeAll(where: { $0 == ball })
    }
    
    
    func updateBallPosition(_ ball : Ball, _ dragOffset : CGSize, in geoSize: CGSize) {
        let newPosition = CGPoint(x: ball.position.x + dragOffset.width, y: ball.position.y + dragOffset.height)
        
        guard isPointInView(newPosition, ballSize: BallView.ballSize, in: geoSize) else { return }
        guard !isPointOverlapping(newPosition, ballSize: BallView.ballSize) else { return }
        guard let index = balls.firstIndex(of: ball) else { return }
        
        var updatedBall = ball
        updatedBall.position = newPosition
        balls[index] = updatedBall
    }
    
    // === Level ===
    func resetLevel() {
        balls.removeAll()
    }
    
    
    func saveLevel(_ levelName : String) -> Bool {
        let savedLevelNames : [String] = LevelManager.listAllLevels()
        guard !savedLevelNames.contains(levelName) else { return false }
        let newLevel = Level(name: levelName, balls: balls)
        return LevelManager.saveLevel(newLevel)
    }
    
    
    func loadLevel(_ levelName : String) -> Bool {
        if let level : Level = LevelManager.loadLevel(levelName: levelName) {
            balls = level.balls
            return true
        }
        return false
    }
    
    
    func isEmpty() -> Bool {
        return balls.isEmpty
    }
    
    
    private func isPointInView(_ point: CGPoint, ballSize: CGFloat, in size: CGSize) -> Bool {
        return point.x - ballSize/2 >= 0 && point.x + ballSize/2 <= size.width
            && point.y - ballSize/2 >= 0 && point.y + ballSize/2 <= size.height
    }
    
    
    private func isPointOverlapping(_ point: CGPoint, ballSize: CGFloat) -> Bool {
        for ball in balls {
            if abs(ball.position.x - point.x) < ballSize && abs(ball.position.y - point.y) < ballSize {
                return true
            }
        }
        return false
    }
    
    
}
