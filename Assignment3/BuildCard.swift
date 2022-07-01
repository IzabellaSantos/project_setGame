//
//  BuildCard.swift
//  Assignment3
//
//  Created by Izabella Julia dos Santos on 07/06/22.
//

import SwiftUI

struct BuildCard: View {
    let card: Card
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lindWidth: CGFloat = 3
    }
    
    var body: some View {
        GeometryReader(content: { geometry in
            ZStack {
                //creates the card
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.lindWidth)
                
                //card content
                VStack {
                    ForEach(0..<card.numberOfSymbol, id:\.self) { _ in
                        symbol()
                            .frame(width: geometry.size.width/2, height: geometry.size.height/8)
                    }
                }
                .foregroundColor(cardColor())
                
                //shows to the user what is happening
                if card.isSelected {
                    shape.foregroundColor(.gray).opacity(0.5) //selected color
                }
                if let isSet = card.isSet {
                    shape.foregroundColor(isSet ? .green : .red).opacity(0.6) //colors match/dismatch
                }
            }
        })
    }

    
    @ViewBuilder
    private func symbol() -> some View {
        switch card.symbol {
            case .triangle:
                returnSymbolView("triangle")
            case .circle:
                returnSymbolView("circle")
            case .rectangle:
                returnSymbolView("rectangle")
        }
    }
    
    private func returnSymbolView(_ symbol: String ) -> some View {
        let symbolFunction = (symbol == "circle" ? AnyShape(Circle()) : (symbol == "triangle" ? AnyShape(Triangle()) : AnyShape(Rectangle())))
        
        switch card.shading {
            case .solid:
                return AnyView(symbolFunction)
            case .striped:
                return AnyView(symbolFunction.opacity(0.5))
            case .open:
                return AnyView(symbolFunction.stroke())
        }
    }

    private func cardColor() -> Color {
        switch card.color {
            case .red:
                return .red
            case .yellow:
                return .yellow
            case .blue:
                return .blue
        }
    }
    
}


