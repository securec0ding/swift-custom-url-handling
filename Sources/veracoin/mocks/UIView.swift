//
//  UITextField.swift
//  Veracoin
//
//  This is support code for the Mock Mobile Development environment
//  You should not revise this code or it may break the lesson. 
//
//  Mock UITextField
// 

class UITextField: UIControl {
    private var mocking = false
    private var mockFieldName = "Unknown"

    public var text: String? {
        didSet {
            if (!mocking) {
                if let t = text, let ws = gWebSocket {
                    ws.send("T|\(mockFieldName)|\(t)")
                }    
            }
        }
    }

    func mockSetText(_ txt: String?) {
        mocking = true
        self.text = txt
        mocking = false
    }

    //
    // We use the frame so text field inits "look" right in View Controllers
    //
    public init(frame: CGRect) {
        super.init()
        
        if (frame.y == 100) {
            self.mockFieldName = "email"
        }
        if (frame.y == 200) {
            self.mockFieldName = "password"
        }
    }
}