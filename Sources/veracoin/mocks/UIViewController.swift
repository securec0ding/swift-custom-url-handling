//
//  UIViewController.swift
//  Veracoin
//
//  This is support code for the Mock Mobile Development environment
//  You should not revise this code or it may break the lesson. 
//
//  Mock UIViewController
// 

class UIViewController {
    public let view = UIView()

    func viewDidLoad() {
    }

    func viewWillAppear(_ animated: Bool) {
    }

    func findControl <T: UIControl>(_ t:T.Type, index: UInt = 0) -> UIControl? {
        return view.findControl(t, index:index)
    }

    func showAlert(msg: String) {
        if let ws = gWebSocket {
            ws.send("V|A|\(msg)")
        }

    }
}