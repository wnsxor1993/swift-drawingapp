//
//  ViewController.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/02/28.
//

import UIKit
import os

class MainViewController: UIViewController{
    private var plane = Plane()
    private let rectFactory = RectangleFactory()
    private let rightAttributerView = RightAttributerView()
    private let imagePicker = UIImagePickerController()
    
    private var customUIViews = [RectValue : UIView]()
    private var panGestureExtraView: UIView?
    
    @IBOutlet weak var rectangleButton: UIButton!
    @IBOutlet weak var albumButton: UIButton!
    @IBOutlet weak var labelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rectangleButton.layer.cornerRadius = 15
        albumButton.layer.cornerRadius = 15
        labelButton.layer.cornerRadius = 15
        
        imagePicker.delegate = self
        rightAttributerView.sliderDelegate = self
        rightAttributerView.stepperDelegate = self
        rightAttributerView.setViewPositionMaxValue(maxX: rightAttributerView.frame.minX, maxY: rectangleButton.frame.minY)
        self.view.addSubview(rightAttributerView)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGesture))
        let dragGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(dragGesture))
        self.view.addGestureRecognizer(tapGestureRecognizer)
        self.view.addGestureRecognizer(dragGestureRecognizer)
        
        addViewMakerButtonObserver()
        addGestureRecognizerObserver()
        addNoneTappedViewObserver()
        addChangedRectValueObserver()
    }
}


// MARK: - Use case: Make RectangleView

extension MainViewController{
    @IBAction func makeRandomRectangle(_ sender: Any) {
        let rectangleValue = rectFactory.makePosition(viewWidth: self.rightAttributerView.frame.minX, viewHeight: self.rectangleButton.frame.minY)
        plane.addValue(rectangle: rectangleValue)
    }
    
    @objc func addRectangleView(_ notification: Notification){
        guard let rectangleValue = notification.userInfo?[Plane.NotificationName.userInfoKey] as? Rectangle else { return }
        
        let rectangleView = CustomViewFactory.makeViewFrame(value: rectangleValue)
        rectangleView.backgroundColor = CustomViewFactory.setViewBackgroundColor(value: rectangleValue)
        rectangleView.alpha = CustomViewFactory.setViewAlpha(value: rectangleValue)
        rectangleView.restorationIdentifier = CustomViewFactory.setViewID(value: rectangleValue)
        
        self.view.addSubview(rectangleView)
        customUIViews[rectangleValue] = rectangleView
        
        os_log("%@", "\(rectangleValue.description)")
    }
}


// MARK: - Use case: Make ImageView

extension MainViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @IBAction func makeImage(_ sender: Any) {
        self.present(imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            let imageValue = rectFactory.makePosition(image: MyImage(image: pickedImage), viewWidth: self.rightAttributerView.frame.minX, viewHeight: self.rectangleButton.frame.minY)
            plane.addValue(image: imageValue)
        }

        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func addImageRectangleView(_ notification: Notification){
        guard let imageValue = notification.userInfo?[Plane.NotificationName.userInfoKey] as? Image else { return }
        
        let imageView = CustomViewFactory.makeViewFrame(value: imageValue)
        
        imageView.alpha = CustomViewFactory.setViewAlpha(value: imageValue)
        imageView.image = CustomViewFactory.setImageViewInnerImage(value: imageValue)
        imageView.restorationIdentifier = CustomViewFactory.setViewID(value: imageValue)
        
        self.view.addSubview(imageView)
        customUIViews[imageValue] = imageView
        
        os_log("%@", "\(imageValue.description)")
    }
}


// MARK: - Use case: Make LabelView

extension MainViewController{
    @IBAction func addRandomLabel(_ sender: Any) {
        let label = rectFactory.makePosition(text: rectFactory.makeText(), viewWidth: self.rightAttributerView.frame.minX, viewHeight: self.rectangleButton.frame.minY)
        plane.addValue(label: label)
    }
    
    @objc func addLabelView(_ notification: Notification){
        guard let labelValue = notification.userInfo?[Plane.NotificationName.userInfoKey] as? Label else { return }
        
        let labelView = CustomViewFactory.makeViewFrame(value: labelValue)
        
        labelView.text = CustomViewFactory.setLabelViewText(value: labelValue)
        let newSize = labelView.intrinsicContentSize
        
        labelView.restorationIdentifier = CustomViewFactory.setViewID(value: labelValue)
        labelView.backgroundColor = CustomViewFactory.setViewBackgroundColor(value: labelValue)
        labelView.alpha = CustomViewFactory.setViewAlpha(value: labelValue)
        
        self.view.addSubview(labelView)
        customUIViews[labelValue] = labelView
        
        os_log("%@", "\(labelValue.description)")
    }
}


// MARK: - Use case: Add observers

extension MainViewController{
    private func addViewMakerButtonObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(addRectangleView(_:)), name: Plane.NotificationName.makeRectangle, object: plane)
        
        NotificationCenter.default.addObserver(self, selector: #selector(addImageRectangleView(_:)), name: Plane.NotificationName.makeImage, object: plane)
        
        NotificationCenter.default.addObserver(self, selector: #selector(addLabelView(_:)), name: Plane.NotificationName.makeLabel, object: plane)
    }
    
    private func addGestureRecognizerObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(showTouchedCustomView(_:)), name: Plane.NotificationName.selectValue, object: plane)
    }
    
    private func addNoneTappedViewObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(showNonTouchedView), name: Plane.NotificationName.noneSelect, object: plane)
    }
    
    private func addChangedRectValueObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(changeViewPoint), name: Plane.NotificationName.changePoint, object: plane)
        NotificationCenter.default.addObserver(self, selector: #selector(changeViewSize), name: Plane.NotificationName.changeSize, object: plane)
        NotificationCenter.default.addObserver(self, selector: #selector(changeViewAlpha), name: Plane.NotificationName.changeAlpha, object: plane)
        NotificationCenter.default.addObserver(self, selector: #selector(changeViewColor), name: Plane.NotificationName.changeColor, object: plane)
    }
}


// MARK: - Use case: Click Rectangle / Image View

extension MainViewController {
    @objc func tapGesture(_ gesture: UITapGestureRecognizer){
        let touchPoint = gesture.location(in: self.view)
        plane.findValue(withX: touchPoint.x, withY: touchPoint.y)
        
        return
    }
    
    @objc func showTouchedCustomView(_ notification: Notification){
        guard let value = notification.userInfo?[Plane.NotificationName.userInfoKey] as? RectValue else{
            return
        }
        
        if let _ = plane.selectedValue{
            noneTouchedViewFrame()
        }
        
        displaySliderValue(selected: value)
        displayStepperValue(selected: value)
        touchedViewFrame(selected: value)
        plane.getSelectedValue(value: value)
    }
    
    @objc private func showNonTouchedView(){
        noneTouchedViewFrame()
        noneDisplaySliderValue()
        noneDisplayStepperValue()
    }
}
    
    
// MARK: - Use case: Show click Rectangle / Image View event

extension MainViewController{
    private func displaySliderValue<T: RectValue>(selected: T){
        if let image = selected as? Image{
            rightAttributerView.originSliderValue(red: 0, green: 0, blue: 0, alpha: Float(image.alpha.showValue()))
            
            rightAttributerView.rockColorSlider()
            rightAttributerView.useAlphaSlider()
        } else{
            rightAttributerView.originSliderValue(red: Float(selected.color.red), green: Float(selected.color.green), blue: Float(selected.color.blue), alpha: Float(selected.alpha.showValue()))
            
            rightAttributerView.useColorSlider()
            rightAttributerView.useAlphaSlider()
        }
    }
    
    private func displayStepperValue(selected: RectValue){
        rightAttributerView.originStepperValue(x: selected.point.x, y: selected.point.y, width: selected.size.width, height: selected.size.height)
        rightAttributerView.useStepper()
    }
    
    private func noneDisplaySliderValue(){
        rightAttributerView.originSliderValue(red: 0, green: 0, blue: 0, alpha: 1)
        rightAttributerView.rockColorSlider()
        rightAttributerView.rockAlphaSlider()
    }
    
    private func noneDisplayStepperValue(){
        rightAttributerView.originStepperValue(x: 0, y: 0, width: 0, height: 0)
        rightAttributerView.rockStepper()
    }
    
    private func touchedViewFrame(selected: RectValue){
        guard let view = customUIViews[selected] else{
            return
        }
        
        view.layer.borderColor = UIColor.cyan.cgColor
        view.layer.borderWidth = 3
    }
    
    private func noneTouchedViewFrame(){
        guard let value = plane.selectedValue else{
            return
        }
        let view = customUIViews[value]
        view?.layer.borderColor = .none
        view?.layer.borderWidth = 0
        
        plane.getSelectedValue(value: nil)
    }
}


// MARK: - Use case: Drag Rectangle / Image View

extension MainViewController {
    @objc func dragGesture(_ gesture: UIPanGestureRecognizer){
        let moveDistance = gesture.translation(in: self.view)
    
        switch gesture.state{
        case .began:
            let touchPoint = gesture.location(in: self.view)
            plane.findValue(withX: touchPoint.x, withY: touchPoint.y)
            makeExtraView()
        case .changed:
            moveExtraView(moveDistance: moveDistance)
            gesture.setTranslation(.zero, in: self.view)
        case .ended:
            dragViewPoint()
        default:
            return
        }
    }
    
    private func makeExtraView(){
        guard let value = plane.selectedValue, let view = customUIViews[value], let copy = view.copy() as? UIView else{
            return
        }

        panGestureExtraView = copy
        self.view.addSubview(copy)
    }
    
    private func moveExtraView(moveDistance: CGPoint){
        guard let extraView = panGestureExtraView else{
            return
        }
        
        extraView.movingExtraViewCenterPosition(view: extraView, x: moveDistance.x, y: moveDistance.y)
        rightAttributerView.onlyChangePositionValue(x: extraView.frame.origin.x, y: extraView.frame.origin.y)
    }
    
    private func dragViewPoint(){
        guard let extraView = panGestureExtraView, let rectValue = plane.selectedValue else{
            return
        }
        
        if extraView.frame.maxX < self.rightAttributerView.frame.minX, extraView.frame.maxY < self.rectangleButton.frame.minY, extraView.frame.minX >= 1, extraView.frame.minY >= 30{
            changeRectValuePoint(extraView: extraView)
        }
        
        displayStepperValue(selected: rectValue)
        extraView.removeFromSuperview()
        panGestureExtraView = nil
    }
}


// MARK: - Use case: Control RigthAttributerView's sliders

extension MainViewController: UIColorSliderDelegate{
    func alphaSliderDidMove() {
        changeRectValueAlpha()
        rightAttributerView.changeAlphaSliderView(text: "투명도 : \(String(format: "%.0f", rightAttributerView.alphaValue.showValue() * 10))")
    }
    
    func redSliderDidMove() {
        changeRectangleColor()
        rightAttributerView.changeColorSliderValue(text: "Red : \(String(format: "%.0f", rightAttributerView.redValue))")
    }
    
    func greenSliderDidMove() {
        changeRectangleColor()
        rightAttributerView.changeColorSliderValue(text: "Green : \(String(format: "%.0f", rightAttributerView.greenValue))")
    }
    
    func blueSliderDidMove() {
        changeRectangleColor()
        rightAttributerView.changeColorSliderValue(text: "Blue : \(String(format: "%.0f", rightAttributerView.blueValue))")
    }
    
    private func changeRectangleColor(){
        let newColor = RGBColor(red: rightAttributerView.redValue, green: rightAttributerView.greenValue, blue: rightAttributerView.blueValue)
        plane.changeRectValueColor(newColor: newColor)
    }
    
    @objc func changeViewColor(){
        guard let rectValue = plane.selectedValue, let rectView = customUIViews[rectValue] else{
            return
        }
        
        rectView.backgroundColor = UIColor(red: rectValue.color.redValue(), green: rectValue.color.greenValue(), blue: rectValue.color.blueValue(), alpha: rectValue.alpha.showValue())
    }
    
    private func changeRectValueAlpha(){
        plane.changeRectValueAlpha(newAlpha: rightAttributerView.alphaValue)
    }
    
    @objc func changeViewAlpha(){
        guard let rectValue = plane.selectedValue, let rectView = customUIViews[rectValue] else{
            return
        }
        
        rectView.alpha = rectValue.alpha.showValue()
    }
}


// MARK: - Use case: Control RigthAttributerView's Steppers

extension MainViewController: StepperDelegate{
    func pointValueDidChange() {
        changeRectValuePoint(extraView: nil)
    }
    
    func sizeValueDidChange() {
        changeRectValueSize()
    }
    
    private func changeRectValuePoint(extraView: UIView?){
        var newPoint: MyPoint
        
        if let extraView = extraView {
            newPoint = MyPoint(x: extraView.frame.origin.x, y: extraView.frame.origin.y)
        } else{
            newPoint = MyPoint(x: rightAttributerView.xValue, y: rightAttributerView.yValue)
        }
        
        plane.changeRectValuePoint(newPoint: newPoint)
    }
    
    @objc func changeViewPoint(){
        guard let rectValue = plane.selectedValue, let view = customUIViews[rectValue] else{
            return
        }
        
        view.frame.origin = CGPoint(x: rectValue.point.x, y: rectValue.point.y)
        rightAttributerView.changeStepperValue()
    }
    
    private func changeRectValueSize(){
        let newSize = MySize(width: rightAttributerView.widthValue, height: rightAttributerView.heightValue)
        plane.changeRectValueSize(newSize: newSize)
    }
    
    @objc func changeViewSize(){
        guard let rectValue = plane.selectedValue, let view = customUIViews[rectValue] else{
            return
        }
        
        view.frame.size = CGSize(width: rectValue.size.width, height: rectValue.size.height)
        rightAttributerView.changeStepperValue()
    }
}
