//
//  Geometrics.swift
//  Assignment3
//
//  Created by Izabella Julia dos Santos on 22/06/22.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height * 2.5
        
        let left = CGPoint(x: rect.midX - width/2, y: rect.midY)
        let right = CGPoint(x: rect.midX + width/2, y: rect.midY)
        let bottom = CGPoint(x: rect.midX, y: rect.midY - height/2)
        
        var p = Path()
        p.move(to: left)
        p.addLine(to: right)
        p.addLine(to: bottom)
        p.addLine(to: left)
        return p
    }
}

struct AnyShape: Shape {
    public var make: (CGRect, inout Path) -> ()

    public init(_ make: @escaping (CGRect, inout Path) -> ()) {
        self.make = make
    }

    public init<S: Shape>(_ shape: S) {
        self.make = { rect, path in
            path = shape.path(in: rect)
        }
    }

    public func path(in rect: CGRect) -> Path {
        return Path { [make] in make(rect, &$0) }
    }
}

