//
//  UIControl.swift
//  Veracoin
//
//  This is support code for the Mock Mobile Development environment
//  You should not revise this code or it may break the lesson. 
//
//  Mock UIControl
// 

class UIControl: UIView {
    open func addAction(_ action: UIAction, for controlEvents: UIControl.Event)
    {
        
    }
}

extension UIControl {
    public struct Event : OptionSet {
        let rawValue: UInt

        /*
        public init(rawValue: UInt) {

        }
        */

        public static let touchUpInside = UIControl.Event(rawValue: 1 << 0)
    }
}