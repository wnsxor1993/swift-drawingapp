//
//  Color.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/02/28.
//

import Foundation

struct Color: CustomStringConvertible {
    let r: Int
    let g: Int
    let b: Int
    
    var description: String {
        "R: \(r), G: \(b), B: \(b)"
    }
    
    init(r: Int = 0, g: Int = 0, b: Int = 0) {
        self.r = r
        self.g = g
        self.b = b
    }
}

extension Color {
    static func make(r: Int = 0, g: Int = 0, b: Int = 0) -> Color {
        Color(r: r, g: g, b: b)
    }
}

extension Color {
    static var black = Color(r: 0, g: 0, b: 0)
}