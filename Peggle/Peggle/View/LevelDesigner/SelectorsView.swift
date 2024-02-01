//
//  SelectorsView.swift
//  Peggle
//
//  Created by proglab on 24/1/24.
//

import SwiftUI

struct SelectorsView: View {
    
    @Binding var currentColor : BallColor
    @Binding var isEraseMode : Bool
    
    var body: some View {
        HStack() {
            ForEach(BallColor.allCases, id: \.self) { ballColor in
                SelectorButton(currentColor: $currentColor, ballColor: ballColor, isEraseMode: $isEraseMode)
            }
            
            Spacer()
            
            EraserButton(currentColor: $currentColor, isEraseMode: $isEraseMode)
        }
        .padding(20)
        .background(.green)
    }
}

struct SelectorButton: View {
    @Binding var currentColor : BallColor
    let ballColor : BallColor
    @Binding var isEraseMode : Bool
    
    var body: some View {
        Button(action: {
            currentColor = ballColor
            isEraseMode = false
        }) {
            Image(Ball.getImageName(ballColor))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .padding(10)
                .foregroundColor(.black)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: (currentColor == ballColor) && !isEraseMode ? 2 : 0)
                )
        }
    }
}

struct EraserButton: View {
    @Binding var currentColor : BallColor
    @Binding var isEraseMode : Bool

    var body: some View {
        Button(action: {
            isEraseMode = true
        }) {
            Image("eraser")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .padding(10)
                .foregroundColor(.black)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: isEraseMode ? 2 : 0)
                )
        }
    }
}

//#Preview {
//    SelectorsView()
//}
