//
//  MemoryView.swift
//  Assignment3
//
//  Created by Izabella Julia dos Santos on 06/06/22.
//

import SwiftUI

struct SetView: View {
    @ObservedObject var game: SetViewModel
    
    var body: some View {
        VStack {
            AspectVGrid(items: game.cards, aspectRatio: 2/3, content: { card in
                BuildCard(card: card)
                    .padding(4)
                    .onTapGesture {
                        game.choose(card)
                    }
            })
            
            //buttons
            HStack {
                Button("New Game") { game.newGame() }
                
                Spacer()
                
                Button("Deal 3 More Cards") { game.dealThreeMoreCard() }
                .disabled(game.deck.isEmpty)
            }
        }
        .padding(.horizontal)
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetViewModel()
        SetView(game: game)
    }
}
