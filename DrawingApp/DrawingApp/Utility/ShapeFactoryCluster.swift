//
//  ShapeFactoryCluster.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/01.
//

import Foundation

enum ShapeType {
    case rectangle
}

protocol ShapeFactory {
    static func makeShape(by type: ShapeType) -> Shapable
}

enum ShapeFactoryCluster: ShapeFactory {
    static func makeShape(by type: ShapeType) -> Shapable {
        switch type {
        case .rectangle:
            return RectangleFactory.makeShape()
        }
    }
}

protocol ShapeBuilder {
    static func makeShape() -> Shapable
}

enum RectangleFactory: ShapeBuilder {
    static func makeRectangle(x: Double = 0, y: Double = 0, width: Double = 30, height: Double = 30) -> Rectangle {
        let id = IdentifierFactory.makeType()
        return Rectangle(id: id, x: x, y: y, width: width, height: height, alpha: .opaque)
    }
    
    static func makeRandomRectangle() -> Rectangle {
        let id = IdentifierFactory.makeType()
        let point = PointFactory.makeType()
        let size = SizeFactory.makeType()
        let color = ColorFactory.makeType()
        let alpha = Alpha.randomElement()
        
        return Rectangle(id: id, origin: point, size: size, color: color, alpha: alpha)
    }
    
    static func makeShape() -> Shapable {
        return self.makeRectangle()
    }
}