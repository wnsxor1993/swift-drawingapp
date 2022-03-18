//
//  Rectangle.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/02/28.
//

import Foundation

class Rectangle: RectValue, CustomStringConvertible{
    var description: String{
        let description = "[\(showValueId())] : (X: \(point.x), Y:\(point.y)) / (W: \(size.width), H:\(size.height)) / (R: \(color.red), G: \(color.green), B: \(color.blue)) / Alpha: \(alpha)"
        return description
    }
    
    init(id: String, size: MySize, point: MyPoint, color: RGBColor, alpha: Alpha){
        super.init(id: id, size: size, point: point, alpha: alpha, color: color)
    }
}
