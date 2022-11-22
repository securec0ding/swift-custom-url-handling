//
//  WithdrawsViewController.swift
//  Veracoin
//
//  This is a mocked ViewController
//

import Foundation
import FoundationNetworking

class WithdrawsViewController: BaseLoggingViewController {
    override func viewDidLoad() {
        super.viewDidLoad()        
    }

    private func buildAPIRequest() -> URLRequest {
        var userid = 0
        if let currentUser = UserManager.sharedInstance.currentUser {
            userid = currentUser.id
        }

        let url = URL(string: "https://FILLIN/api/withdraws/\(userid)")!
        var request = URLRequest(url: url)
        request.setValue("https://securitylabs.veracode.com", forHTTPHeaderField: "Origin")

        return request
    }    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Fetch last withdraw
        let request = self.buildAPIRequest()
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            // handle the result here.
            if let _ = error {
                self.showAlert(msg: "Withdraw Not Retrieved")
                return;
            }
            let response = response as! HTTPURLResponse
            let status = response.statusCode
            guard (200...299).contains(status) else {
                self.showAlert(msg: "Error: HTTP \(status)")
                return
            }
            let decoder = JSONDecoder()

            /* Extra Error Handling
            do {
                let _ = try decoder.decode(WithdrawResponse.self, from: data!)
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
            }
            */
            
            if let withdrawResponse = try? decoder.decode(WithdrawResponse.self, from: data!) {
                self.showAlert(msg: "Amount: \(withdrawResponse.amount)")
                return
            }
        }.resume()

    }
}
