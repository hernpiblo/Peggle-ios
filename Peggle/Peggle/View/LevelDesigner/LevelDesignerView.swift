//
//  LevelDesignerView.swift
//  Peggle
//
//  Created by proglab on 1/2/24.
//

import SwiftUI

struct LevelDesignerView: View {
    @ObservedObject var levelDesignerVM: LevelDesignerVM
    @State private var currentColor: BallColor = .blue
    @State var isEraseMode: Bool = false
    
    var body: some View {
        VStack(spacing:0) {
            GeometryReader { geo in
                ZStack {
                    Image("background")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width, height: geo.size.height)
                        .onTapGesture { tapLocation in
                            guard !isEraseMode else { return }
                            levelDesignerVM.addBall(at: tapLocation, in: geo.size, ballColor: currentColor)
                        }
                    
                    ForEach(levelDesignerVM.balls, id: \.self) { ball in
                        BallView(ball: ball, geoSize: geo.size, levelDesignerVM: levelDesignerVM, isEraseMode: $isEraseMode)
                    }
                }
            }
            ControlsView(levelDesignerVM: levelDesignerVM)
            SelectorsView(currentColor: $currentColor, isEraseMode: $isEraseMode)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}


    
#Preview {
    LevelDesignerView(levelDesignerVM: LevelDesignerVM())
}
