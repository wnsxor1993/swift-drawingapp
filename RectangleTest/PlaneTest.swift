//
//  PlaneTest.swift
//  RectangleTest
//
//  Created by juntaek.oh on 2022/03/02.
//

import XCTest
@testable import DrawingApp

class PlaneTest: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testExample() throws {
        let plane = Plane()
        let madeRect = Rectangle(id: "ABC", size: MySize(width: 100, height: 100), point: MyPoint(x: 20, y: 20), color: RGBColor(red: 100, green: 100, blue: 100), alpha: Alpha.eight)
        
        plane.addValue(rectangle: madeRect)
        let count = plane.count()
        let rect = plane[0]
        plane.findValue(withX: 80, withY: 80)
        plane.findValue(withX: 200, withY: 200)
    }

    func testPerformanceExample() throws {
        self.measure {
        }
    }

}
