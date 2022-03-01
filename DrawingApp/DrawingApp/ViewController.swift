//
//  ViewController.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/02/28.
//

import UIKit
import OSLog

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let rectangleFactory = RectangleFactory()
        
        let rect1 = rectangleFactory.makeRectangleAtRandomPoint()
        let rect2 = rectangleFactory.makeRectangleAtRandomPoint()
        let rect3 = rectangleFactory.makeRectangleAtRandomPoint()
        let rect4 = rectangleFactory.makeRectangleAtRandomPoint()
        
        os_log(.default,"\(rect1)" )
        os_log(.debug, "\(rect2)")
        os_log(.error,"\(rect3)")
        os_log(.fault,"\(rect4)")
    }
}
