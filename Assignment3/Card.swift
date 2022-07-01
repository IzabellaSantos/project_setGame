//
//  Card.swift
//  Assignment3
//
//  Created by Izabella Julia dos Santos on 27/06/22.
//

import Foundation

struct Card: Identifiable {
    var isSelected: Bool = false
    var isSet: Bool?
    var numberOfSymbol: Int
    var id: Int
    
    //Card content
    var symbol: Symbol
    var shading: Shading
    var color: Color
    
    //CaseIterable to enums without associated values
    enum Symbol: CaseIterable {
        case triangle
        case rectangle
        case circle
    }
    
    enum Shading: CaseIterable {
        case solid
        case striped
        case open
    }
    
    enum Color: CaseIterable {
        case red
        case yellow
        case blue
    }
}
