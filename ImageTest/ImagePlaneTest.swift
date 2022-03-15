//
//  ImagePlaneTest.swift
//  RectangleTest
//
//  Created by juntaek.oh on 2022/03/08.
//

import XCTest
@testable import DrawingApp

class ImagePlaneTest: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testExample() throws {
        guard let namedImage = UIImage(named: "010") else{
            return
        }
        
        var plane = ImagePlane()
        let madeImage = Image(image: MyImage(image: namedImage), size: MySize(width: 100, height: 100), point: MyPoint(x: 15, y: 15), alpha: Alpha.seven)
        
        plane.addImage(imageRectangle: madeImage)
        let count = plane.count()
        let image = plane[0]
        let trueImage = plane.findImage(withX: 100, withY: 100)
        let falseImage = plane.findImage(withX: 250, withY: 250)
    }

    func testPerformanceExample() throws {
        self.measure {
        }
    }

}