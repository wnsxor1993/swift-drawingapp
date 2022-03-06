import Foundation


protocol StylerViewDelegate: AnyObject{
    func updatingSelectedRectangleViewAlphaRequested(opacity: Int)
    func updatingSelectedRecntagleViewColorRequested()
    func updatingSelectedRectangleViewColorInfoCompleted(rgb: [Double])
    func clearingSelectedRectangleInfoCompleted()
}
