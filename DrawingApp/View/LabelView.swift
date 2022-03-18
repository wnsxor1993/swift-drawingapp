//
//  LabelView.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/03/18.
//

import Foundation
import UIKit

class LabelView: UILabel, NSCopying{
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let labelView = LabelView(frame: self.frame)
        labelView.text = self.text
        labelView.font = self.font
        labelView.alpha = 0.5
        return labelView
    }
}
