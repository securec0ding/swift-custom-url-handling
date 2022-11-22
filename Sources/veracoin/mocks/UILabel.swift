//
//  UILabel.swift
//  Veracoin
//
//  This is support code for the Mock Mobile Development environment
//  You should not revise this code or it may break the lesson. 
//
//  Mock UILabel
// 

class UILabel: UIView {
    private var _text: String?
    var text: String? {
        get {
            _text
        }
        set {
            _text = newValue
            if let t = _text, let ws = gWebSocket {
                ws.send("D|\(t)")
            }    
        }
    }
}