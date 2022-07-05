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
        static let opacityLevel: CGFloat = 0.3
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
                    shape.foregroundColor(.gray).opacity(DrawingConstants.opacityLevel) //selected color
                }
                if let isSet = card.isSet {
                    shape.foregroundColor(isSet ? .green : .red).opacity(DrawingConstants.opacityLevel) //colors match/dismatch
                }
            }
        })
    }

    
    
    private func symbol() -> some View {
        var symbol: AnyShape
        switch card.symbol {
            case .triangle:
            symbol = returnSymbolView(.triangle)
            case .circle:
            symbol = returnSymbolView(.circle)
            case .rectangle:
            symbol = returnSymbolView(.rectangle)
        }
        
        return setSymbolShading(symbol)
    }
    
    private func returnSymbolView(_ symbol: ShapeName ) -> AnyShape {
        var symbolFunction: AnyShape {
            switch symbol {
            case .triangle:
                return AnyShape(Triangle())
            case .circle:
                return AnyShape(Circle())
            case .rectangle:
                return AnyShape(Rectangle())
            }
        }
        
        return symbolFunction
    }
    
    private func setSymbolShading(_ symbolFunction: AnyShape) -> some View {
        switch card.shading {
            case .solid:
                return AnyView(symbolFunction)
            case .striped:
                return AnyView(symbolFunction.opacity(DrawingConstants.opacityLevel))
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


