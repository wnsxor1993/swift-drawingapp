import Foundation
import UIKit

class CanvasView: UIView{
    
    weak var delegate: CanvasViewDelegate?
    private (set) var generatingButton: UIButton = UIButton()
    private (set) var selectedRectangleView: UIView?
    
    init(frame: CGRect, backGroundColor: UIColor) {
        super.init(frame: frame)
        self.backgroundColor = backGroundColor
        setGeneratingButton()
        setGeneratingButtonAction()
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func clearRectangleViewSelection(){
        if let selectedRectangleView = self.selectedRectangleView{
            selectedRectangleView.layer.borderWidth = 0
            self.selectedRectangleView = nil
        }
    }
    
    func updateSelectedRectangleView(subView: UIView){
        if let selectedRectangleView = self.selectedRectangleView{
            selectedRectangleView.layer.borderWidth = 0
        }
        subView.layer.borderWidth = 2
        self.selectedRectangleView = subView
    }
    
    func updateSelectedRectangleOpacity(opacity: Int){
        guard let delegate = self.delegate else { return }
        guard let selectedRectangleView = selectedRectangleView else { return }
        selectedRectangleView.alpha = CGFloat(opacity) / 10
        delegate.updatingSelectedRectangleViewAlphaCompleted(opacity: opacity)
    }
    
    func changeSelectedRectangleViewColor(rgb: [Double]){
        guard let selectedRectangleView = selectedRectangleView else { return }
        selectedRectangleView.backgroundColor = UIColor(red: rgb[0], green: rgb[1], blue: rgb[2], alpha: 1)
        if let delegate = self.delegate{
            delegate.updatingSelectedRectangleViewColorCompleted(rgb: rgb)
        }
    }
    
    private func setGeneratingButton(){
        let buttonWidth = self.frame.width*0.15
        let buttonHeight = self.frame.height*0.15
        self.generatingButton.frame = CGRect(x: 0, y: self.frame.height-buttonHeight, width: buttonWidth, height: buttonHeight*0.8)
        self.generatingButton.center.x = self.center.x
        
        self.generatingButton.backgroundColor = .white
        self.generatingButton.layer.cornerRadius = 10
        self.generatingButton.layer.borderWidth = 1
        
        self.generatingButton.setTitle("사각형🖌", for: .normal)
        self.generatingButton.setTitleColor(.black, for: .normal)
        self.generatingButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        
        self.addSubview(generatingButton)
    }
    
    private func setGeneratingButtonAction(){
        let buttonAction:UIAction = UIAction(title: ""){ _ in
            self.sendCreatingRectangleRequest()
        }
        self.generatingButton.addAction(buttonAction, for: .touchDown)
    }
    
    private func sendCreatingRectangleRequest(){
        if let delegate = self.delegate{
            delegate.creatingRectangleRequested()
        }
    }

}
