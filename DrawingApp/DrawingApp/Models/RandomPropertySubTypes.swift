//
//  RandomPropertySubTypes.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/03/04.
//

import Foundation

// MARK: - Rect Size, Point

struct Rect {
    struct Size {
        var width: Double
        var height: Double
    }

    struct Point {
        var x: Double
        var y: Double
    }
}

typealias RectSize = Rect.Size
typealias RectPoint = Rect.Point

// MARK: - CustomStringConvertible

extension Rect.Size: CustomStringConvertible {
    var description: String {
        "W\(self.width), H\(self.height)"
    }
}

extension Rect.Point: CustomStringConvertible {
    var description: String {
        "X:\(self.x),Y:\(self.y)"
    }
}

// MARK: - RectRGBColor

struct RectRGBColor {
    var r: Double
    var g: Double
    var b: Double
}

// MARK: - CustomStringConvertible

extension RectRGBColor: CustomStringConvertible {
    var description: String {
        "R:\(self.r), G:\(self.g), B:\(self.b)"
    }
}
