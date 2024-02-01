//
//  LevelDesignerVM.swift
//  Peggle
//
//  Created by proglab on 1/2/24.
//

import SwiftUI

class LevelDesignerVM: ObservableObject {
    @Published var balls: [Ball] = []
    
    func addBall(at position: CGPoint, in size: CGSize, ballColor: BallColor) {
        
        guard isPointInView(position, in: size, ballSize: BallView.ballSize) else { return }
        guard !isPointOverlapping(position, ballSize: BallView.ballSize) else { return }
        
        let newBall = Ball(position: position, color: ballColor)
        balls.append(newBall)
    }
    
    
    func removeBall(_ ball : Ball) {
        balls.removeAll(where: { $0 == ball })
    }
    
    
    func resetLevel() {
        balls.removeAll()
    }
    
    
    private func isPointInView(_ point: CGPoint, in size: CGSize, ballSize: CGFloat) -> Bool {
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
