//
//  MemoryView.swift
//  Assignment3
//
//  Created by Izabella Julia dos Santos on 06/06/22.
//

import SwiftUI

struct SetView: View {
    @ObservedObject var game: SetViewModel
    @Namespace private var dealingNamespace
    
    var body: some View {
        VStack {
            cardsBody
            HStack {
                deckBody
                Spacer()
                newGame
                Spacer()
                dicardPileBody
            }
        }
        .padding(.horizontal)
    }
    
    private var cardsBody: some View {
        AspectVGrid(items: game.cards, aspectRatio: CardConstants.aspectRatio, content: { card in
            BuildCard(card: card)
                .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                .padding(4)
                .transition(.asymmetric(insertion: .identity, removal: .identity))
                .onTapGesture {
                    cardSetAnimation(card: card)
                }
        })
    }
    
    private var deckBody: some View {
        ZStack {
            ForEach(game.deck) { card in
                BuildCard(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .opacity, removal: .identity))
            }
        }
        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
        .onTapGesture {
            withAnimation(.easeInOut(duration: CardConstants.dealDuration)) {
                game.dealThreeMoreCard()
            }
        }
    }

    private var dicardPileBody: some View {
        ZStack {
            ForEach(game.discardPile) { card in
                BuildCard(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .opacity))
            }
        }
        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
    }
    
    private var newGame: some View {
        Button("New Game") { game.newGame() }
    }
    
    
    private func cardSetAnimation(card: Card) {
        withAnimation(.easeInOut(duration: CardConstants.dealDuration)) {
            game.choose(card)
        }
    }
    private struct CardConstants {
        static let aspectRatio: CGFloat = 2/3
        static let undealtHeight: CGFloat = 90
        static let dealDuration: Double = 0.7
        static let undealtWidth = undealtHeight * aspectRatio
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetViewModel()
        SetView(game: game)
    }
}
