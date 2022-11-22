//
// Main.swift
// Veracoin 
//
// This is support code for the Mock Mobile Development environment
// You should not revise this code or it may break the lesson. 
//
// Driver program that communicates with mock phone via Websockets
//

import Foundation
import NIO
import NIOConcurrencyHelpers
import Dispatch
import WebSocketKit

var eventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 2)
var gWebSocket:WebSocketKit.WebSocket?

var port: Int = 35000
if let vport = ProcessInfo.processInfo.environment["VIRTUAL_PORT"], let vporti = Int(vport) {
    port = vporti
}

let promise = eventLoopGroup.next().makePromise(of: String.self)
WebSocket.connect(to: "ws://localhost:\(port)", on: eventLoopGroup) { ws in
    gWebSocket = ws
    ws.send("C|native")

    let app = UIApplication()
    let appDelegate = AppDelegate()
    var running = false
    var siginViewController: SigninViewController? = nil
    var homeViewController: HomeViewController? = nil
    var withdrawsViewController: WithdrawsViewController? = nil

    ws.onText { ws, msg in
        //print(msg)
        let msgParts = msg.components(separatedBy: "|")
        if msgParts.count == 2 && msgParts[0] == "C" && msgParts[1] == "launch" {
            if !running {
                let _ = appDelegate.application(app, didFinishLaunchingWithOptions: [:])
                running = true
            } else {
                // App alreading running, entering foreground
            }

            siginViewController = SigninViewController()
            siginViewController!.viewDidLoad()
            siginViewController!.viewWillAppear(true)

            return
        }
        if msgParts.count == 2 && msgParts[0] == "U"  {
            if let url = URL(string: msgParts[1]) {
                if (!running) {
                    let _ = appDelegate.application(app, didFinishLaunchingWithOptions: [:])
                    running = true
                }
                let sender = "com.cardify.tinder"
                let _ = appDelegate.application(app, open: url, options: [.sourceApplication:sender])
                ws.send("L|past url")
            }            
            return
        }
        if msgParts.count == 3 && msgParts[0] == "L"  {
            if let siginViewController = siginViewController {
                if let userTextFieldControl = siginViewController.findControl(UITextField.self, index:0) {
                    if let userTextField = userTextFieldControl as? UITextField {
                        userTextField.mockSetText(msgParts[1])
                    }
                }

                if let passwordTextFieldControl = siginViewController.findControl(UITextField.self, index:1) {
                    if let passwordTextField = passwordTextFieldControl as? UITextField {
                        passwordTextField.mockSetText(msgParts[2])
                    }
                }
                if let buttonControl = siginViewController.findControl(UIButton.self) {
                    if let button = buttonControl as? UIButton {
                        button.triggerTouchUpInside()
                    }
                }
            }
            return
        }

        if msgParts.count == 2 && msgParts[0] == "V" && msgParts[1] == "M"  {
            homeViewController = HomeViewController()
            homeViewController!.viewDidLoad()
            homeViewController!.viewWillAppear(true)
        }
        
        if msgParts.count == 2 && msgParts[0] == "V" && msgParts[1] == "W"  {
            withdrawsViewController = WithdrawsViewController()
            withdrawsViewController!.viewDidLoad()
            withdrawsViewController!.viewWillAppear(true)
        }
        
        // Trigger Sign in with OAuth on Login Screen
        if msgParts.count == 1 && msgParts[0] == "K"  {
            if let siginViewController = siginViewController {
                if let buttonControl = siginViewController.findControl(UIButton.self, index:1) {
                    if let button = buttonControl as? UIButton {
                        button.triggerTouchUpInside()
                    }
                }
            }
        }

        // OAuth Login Screen
        if msgParts.count == 2 && msgParts[0] == "WL"  {
            //print("WL ==> \(msgParts[1])")
            ASWebAuthenticationSession.trigger(msgParts[1]);
        }

        // Error from OAuth
        if msgParts.count == 2 && msgParts[0] == "WE"  {
            //print("WE ==> \(msgParts[1])")
            ASWebAuthenticationSession.triggerError(WebAuthenticationError.badClientId);
        }

        // Login from OAuth Screen
        if msgParts.count == 3 && msgParts[0] == "K"  {
        }

        // ATM Withdraw
        if msgParts.count == 1 && msgParts[0] == "ATM"  {
            if let homeViewController = homeViewController {
                if let buttonControl = homeViewController.findControl(UIButton.self) {
                    if let button = buttonControl as? UIButton {
                        button.triggerTouchUpInside()
                    }
                }
            }
        }

    }
}.cascadeFailure(to: promise)

print("Veracoin mock app started")

while true {
    do {
        let _  = try promise.futureResult.wait()
    } catch is NIOConnectionError {
        print("Connection error, will try to reconnect in 2 seconds.")
        Thread.sleep(forTimeInterval: 2.0)
    } catch {
        print("Error: \(error).")
        break
    }
}