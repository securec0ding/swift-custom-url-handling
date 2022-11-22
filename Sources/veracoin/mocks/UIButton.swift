//
//  UIButton.swift
//  Veracoin
//
//  This is support code for the Mock Mobile Development environment
//  You should not revise this code or it may break the lesson. 
//
//  Mock UIButton
// 

class UIButton: UIControl {
    private var action:UIAction?

    override func addAction(_ action: UIAction, for controlEvents: UIControl.Event)
    {
        self.action = action
    }

    func triggerTouchUpInside()
    {
        if let action = self.action {
            action.trigger()
        }
    }
}