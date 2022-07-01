//
//  MemoryModel.swift
//  Assignment3
//
//  Created by Izabella Julia dos Santos on 06/06/22.
//

import SwiftUI

struct SetModel {
    private(set) var deck: Array<Card>
    private(set) var cards: Array<Card>
    
    private var indexOfchosen: [Int] {
        get { cards.indices.filter { cards[$0].isSelected } }
    }
    
    private struct GameConstant {
        static let numberOfCardOnTable = 12
        static let numberOfMatchCard = 3
        static let numberOfDealCard = 3
    }
    
    init() {
        deck = []
        cards = []
        
        //deck array gets full (81 cards due to the all cases we need to have)
        var id = 0
        for symbol in Card.Symbol.allCases {
            for shading in Card.Shading.allCases {
                for color in Card.Color.allCases {
                    for number in 1...3 {
                        deck.append(Card(numberOfSymbol: number, id: id, symbol: symbol, shading: shading, color: color))
                        id += 1
                    }
                }
            }
        }
        
        //shuffle the deck array
        deck.shuffle()
        
        //return the 12 last cards to the cards array (which is showing)
        for _ in 0..<GameConstant.numberOfCardOnTable {
            cards.append(deck.popLast()!)
        }
    }
    
    mutating func choose(_ card: Card) {
        if indexOfchosen.count == GameConstant.numberOfMatchCard {
            if isMatch() {
                removeAndReplaceCard()
            }
            cards.indices.forEach {
                cards[$0].isSelected = false
                cards[$0].isSet = nil
            }
        }
        
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}) {
            cards[chosenIndex].isSelected.toggle()
            if indexOfchosen.count == GameConstant.numberOfMatchCard {
                let isMatch = isMatch()
                indexOfchosen.forEach({ i in
                    cards[i].isSet = isMatch
                })
            }
        }
    }
    
    //remove and return the last element of the array deck to the cards array
    mutating func dealThreeMoreCard() {
        if indexOfchosen.count == GameConstant.numberOfMatchCard {
            if isMatch() {
                removeAndReplaceCard()
                return
            }
        }
        
        for _ in 0..<GameConstant.numberOfDealCard {
            cards.append(deck.popLast()!)
        }
    }
   
    //gets if is a match
    private func isMatch() -> Bool {
        if indexOfchosen.count == GameConstant.numberOfMatchCard { //if there is the right number of cards to make a set
            return compareContent()
        } else {
            return false
        }
    }
    
    //compare all the cases of a match
    private func compareContent() -> Bool {
        let cardOne = cards[indexOfchosen[0]], cardTwo = cards[indexOfchosen[1]], cardThree = cards[indexOfchosen[2]]
        
        var isSetOfNumberOfShape: Bool {
            (cardOne.numberOfSymbol == cardTwo.numberOfSymbol && cardOne.numberOfSymbol == cardThree.numberOfSymbol) ||
            (cardOne.numberOfSymbol != cardTwo.numberOfSymbol && cardTwo.numberOfSymbol != cardThree.numberOfSymbol && cardOne.numberOfSymbol != cardThree.numberOfSymbol)
        }

        var isSetOfColor: Bool {
            (cardOne.color == cardTwo.color && cardOne.color == cardThree.color) ||
            (cardOne.color != cardTwo.color && cardTwo.color != cardThree.color && cardOne.color != cardThree.color)
        }
        
        var isSetOfSymbol: Bool {
            (cardOne.symbol == cardTwo.symbol && cardOne.symbol == cardThree.symbol) ||
            (cardOne.symbol != cardTwo.symbol && cardTwo.symbol != cardThree.symbol && cardOne.symbol != cardThree.symbol)
        }
        
        var isSetOfshading: Bool {
            (cardOne.shading == cardTwo.shading && cardOne.shading == cardThree.shading) ||
            (cardOne.shading != cardTwo.shading && cardTwo.shading != cardThree.shading && cardOne.shading != cardThree.shading)
        }
        
        return isSetOfNumberOfShape && isSetOfColor && isSetOfSymbol && isSetOfshading
    }
    
    //remove the chosen card
    private mutating func removeAndReplaceCard() {
        indexOfchosen.reversed().forEach({ i in
            cards.remove(at: i)
            if !deck.isEmpty { //if there still have cards, replace
                cards.insert(deck.popLast()!, at: i) //this insert the new card in the right place wherer the other was
            }
        })
    }
}
