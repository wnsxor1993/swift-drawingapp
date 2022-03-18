//
//  RectangleFactory.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/02/28.
//

import Foundation
import UIKit

final class RectangleFactory{
    private let width: Double = 150
    private let height: Double = 120
    
    func makeSize() -> MySize{
        let size = MySize(width: self.width, height: self.height)
        return size
    }
    
    func makePoint(viewWidth: Double, viewHeight: Double) -> MyPoint{
        let maxWidth = viewWidth - width
        let xPoint = Int.random(in: 0..<Int(maxWidth))
        
        let maxHeight = viewHeight - height
        let yPoint = Int.random(in: 30..<Int(maxHeight))
        
        let point = MyPoint(x: Double(xPoint), y: Double(yPoint))
        return point
    }
    
    func makeColor() -> RGBColor{
        let red = Int.random(in: 0...255)
        let green = Int.random(in: 0...255)
        let blue = Int.random(in: 0...255)
        
        let color = RGBColor(red: Double(red), green: Double(green), blue: Double(blue))
        return color
    }
    
    func makeAlpha() -> Alpha{
        if let alpha = Alpha.allCases.randomElement(){
            return alpha
        } else{
            return .five
        }
    }
    
    func makeText() -> MyText{
        var text: String = ""
        let sentence: [String] = MyText.sentence.components(separatedBy: " ")
        var startIndex = Int.random(in: 0...sentence.count - 4)
        let endIndex = startIndex + 4
        
        while startIndex <= endIndex{
            if startIndex == endIndex{
                text.append(contentsOf: sentence[startIndex])
            } else{
                text.append(contentsOf: "\(sentence[startIndex]) ")
            }
            startIndex += 1
        }
        
        return MyText(text: text)
    }
}


// MARK: - Use case: Make value's position

extension RectangleFactory{
    func makePosition(viewWidth: Double, viewHeight: Double) -> Rectangle{
        let rectangle = Rectangle(id: IDFactory.makeID(), size: makeSize(), point: makePoint(viewWidth: viewWidth, viewHeight: viewHeight), color: makeColor(), alpha: makeAlpha())
        return rectangle
    }
    
    func makePosition(image: MyImage, viewWidth: Double, viewHeight: Double) -> Image{
        let imageRectangle = Image(image: image, id: IDFactory.makeID(), size: makeSize(), point: makePoint(viewWidth: viewWidth, viewHeight: viewHeight), alpha: makeAlpha())
        return imageRectangle
    }
    
    func makePosition(text: MyText, viewWidth: Double, viewHeight: Double) -> Label{
        let labelRectangle = Label(text: text, color: makeColor(), id: IDFactory.makeID(), size: makeSize(), point: makePoint(viewWidth: viewWidth, viewHeight: viewHeight), alpha: makeAlpha())
        return labelRectangle
    }
}
