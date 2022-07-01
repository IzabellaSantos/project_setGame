//
//  MemoryViewModel.swift
//  Assignment3
//
//  Created by Izabella Julia dos Santos on 06/06/22.
//

import SwiftUI

class SetViewModel: ObservableObject {
    @Published private var model = createSetGame()
    
    private static func createSetGame() -> SetModel {
        SetModel() //calls the setModel init
    }
        
    var deck: [Card] {
        model.deck
    }
    
    var cards: [Card] {
        model.cards
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func dealThreeMoreCard() {
        model.dealThreeMoreCard()
    }
    
    func newGame() {
        model = Self.createSetGame()
    }    
}
