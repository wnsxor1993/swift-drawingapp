//
//  Rectangle.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/02/28.
//

import Foundation

class Rectangle {
    private let id: ID
    private var size: Size
    private var point: Point
    private var backgroundColor: BackgroundColor
    private var alpha: Alpha
    
    init(width: Double, height: Double, x: Double, y: Double, backgroundColor: BackgroundColor, alpha: Alpha) {
        self.id = ID()
        size = Size(width: width, height: height)
        point = Point(x: x, y: y)
        self.backgroundColor = backgroundColor
        self.alpha = alpha
    }
    
    init(size: Size, point: Point, backgroundColor: BackgroundColor, alpha: Alpha) {
        self.id = ID()
        self.size = size
        self.point = point
        self.backgroundColor = backgroundColor
        self.alpha = alpha
    }

}

extension Rectangle: CustomStringConvertible {
    var description: String {
        return "\(id) Rectangle, \(point), \(size), \(backgroundColor), \(alpha)"
    }
}