//
//  ViewRandomProperty.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/02/28.
//

import Foundation

// typeAlias를 통해 튜플의 용도가 이름에서도 드러나도록 하였습니다.
typealias RectSize = (width:Double, height:Double)
typealias RectPoint = (x:Double, y:Double)
typealias RectRGBColor = (r:Double, g:Double, b: Double)

// 처음에는 사각형인 Rect등의 단어를 넣었지만, 이 뷰는 사각형, 정사각형, 원 어디에서나 사용할 수 있는 값을 저장하기 때문에,
// 랜덤 프로퍼티를 소유한 뷰라는 의미의 이름을 넣게 되었습니다.
class ViewRandomProperty {
    
    let name: String
    let id: String
    
    let size: RectSize
    let point: RectPoint
    
    let rgbValue: RectRGBColor
    let alpha: Double
    
    // 모든 값들은 뷰 컨트롤러에 의해 지정됩니다.
    init(as name: String, using id: String, at point: RectPoint, size: RectSize, color: RectRGBColor, alpha: Double) {
        self.name = name
        self.id = id
        self.point = point
        self.size = size
        self.rgbValue = color
        self.alpha = alpha
    }
}

extension ViewRandomProperty: CustomStringConvertible {
    var description: String {
        return "\(name) \(id), X:\(point.x),Y:\(point.y), W\(size.width), H\(size.height), R:\(rgbValue.r), G:\(rgbValue.g), B:\(rgbValue.b), Alpha:\(alpha)"
    }
}