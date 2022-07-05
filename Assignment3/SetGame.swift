//
//  Assignment3App.swift
//  Assignment3
//
//  Created by Izabella Julia dos Santos on 06/06/22.
//

import SwiftUI

@main
struct SetGame: App {
    private let game = SetViewModel()
    
    var body: some Scene {
        WindowGroup {
            SetView(game: game)
        }
    }
}
