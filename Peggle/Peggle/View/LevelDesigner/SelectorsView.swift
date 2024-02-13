//
//  SelectorsView.swift
//  Peggle
//
//  Created by proglab on 24/1/24.
//

import SwiftUI

struct SelectorsView: View {
    @Binding var currentColor: PegColor
    @Binding var isEraseMode: Bool

    var body: some View {
        HStack {
            ForEach(PegColor.allCases, id: \.self) { pegColor in
                SelectorButton(currentColor: $currentColor, pegColor: pegColor, isEraseMode: $isEraseMode)
            }
            Spacer()
            EraserButton(currentColor: $currentColor, isEraseMode: $isEraseMode)
        }
        .padding(20)
    }
}

private struct SelectorButton: View {
    @Binding var currentColor: PegColor
    let pegColor: PegColor
    @Binding var isEraseMode: Bool

    var body: some View {
        Button(action: {
            currentColor = pegColor
            isEraseMode = false
        }) {
            Image(PegView.getImageName(of: pegColor, isHit: false))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .padding(10)
                .foregroundColor(.black)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: (currentColor == pegColor) && !isEraseMode ? 2 : 0)
                )
        }
    }
}

private struct EraserButton: View {
    @Binding var currentColor: PegColor
    @Binding var isEraseMode: Bool

    var body: some View {
        Button(action: {
            isEraseMode = true
        }) {
            Image(Constants.ImageName.ERASER)
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
