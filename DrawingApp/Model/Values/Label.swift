//
//  Label.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/03/18.
//

import Foundation

final class Label: RectValue, CustomStringConvertible{
    private let text: MyText
    
    var description: String{
        let description = "[\(text.text)] : (X: \(point.x), Y:\(point.y)) / (W: \(size.width), H:\(size.height)) / Alpha: \(alpha)"
        return description
    }
    
    init(text: MyText, id: String, size: MySize, point: MyPoint, alpha: Alpha){
        self.text = text
        super.init(id: id, size: size, point: point, alpha: alpha)
    }
    
    func showMyText() -> MyText{
        return text
    }
}
