//
//  PeggleApp.swift
//  Peggle
//
//  Created by proglab on 24/1/24.
//

import SwiftUI

@main
struct PeggleApp: App {
    @StateObject var levelDesignerVM = LevelDesignerVM()

    var body: some Scene {
        WindowGroup {
            LevelDesignerView(levelDesignerVM: levelDesignerVM)
        }
    }
}
