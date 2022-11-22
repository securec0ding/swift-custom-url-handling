//
//  UIAction.swift
//  Veracoin
//
//  This is support code for the Mock Mobile Development environment
//  You should not revise this code or it may break the lesson. 
//
//  Mock UIAction
// 

typealias UIActionHandler = (UIAction) -> Void

class UIAction {
    private var handler: UIActionHandler?

    init(title: String = "", handler: @escaping UIActionHandler)
    {
        self.handler = handler
    }

    func trigger() {
        if let handler = self.handler {
            handler(self)
        }
    }
}