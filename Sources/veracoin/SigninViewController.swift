//
//  SigninViewController.swift
//  Veracoin
//
//  This is a mocked ViewController
//

import Foundation
import FoundationNetworking

class SigninViewController: BaseLoggingViewController {
    private let emailTextField = UITextField(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
    private let passwordTextField = UITextField(frame: CGRect(x: 20, y: 200, width: 300, height: 40))
    private let signinButton = UIButton()
    private let signinWithKeyButton = UIButton()

    private let authEndpoint = "fillin"
    private let tokenEndpoint = "fillin"
    private let redirectUri = "veracoin://oauth"
    private let clientId = "fillin"
    private let clientSecret = "fillin"
    private var oAuthState = "statesetbyclient"
    
    private func urlEncoode(_ str:String) -> String {
        return str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }

    private func buildAuthUrl() -> URL? {        
        if var urlComponents = URLComponents(string: authEndpoint) {
            urlComponents.query =
                "client_id=" + clientId +
                "&redirect_uri=" + redirectUri +
                "&response_type=code" +
                "&state=" + oAuthState +
                "&scope=user.read openid profile email"
            
            return urlComponents.url
        }
        
        return nil
    }

    private func buildTokenRequest(code: String) -> URLRequest {
        let url = URL(string: tokenEndpoint)!
        var request = URLRequest(url: url)
        request.setValue("https://securitylabs.veracode.com", forHTTPHeaderField: "Origin")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        let body = "client_id=" + urlEncoode(clientId) +
            "&grant_type=authorization_code" +
            "&redirect_uri=" + urlEncoode(redirectUri) +
            "&code=" + urlEncoode(code) +
            "&client_secret=" + urlEncoode(clientSecret)        
        
        request.httpBody = body.data(using: .utf8)
        
        return request
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(emailTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(signinButton)
        self.view.addSubview(signinWithKeyButton)

        let signInAction = UIAction { [unowned self] (action) in
            if let email = emailTextField.text, let password = passwordTextField.text {
                os_log("Signin Email: \(email) Password: \(password)")
                Analytics.logEvent("signin", parameters: ["email": email, "password": password])
                UserManager.sharedInstance.login(email: email, password: password) { (result) in                
                    switch result {
                        case .success(let user):
                            if user != nil {
                                Router.sharedInstance.showHome()
                            } else {
                                assert(false, "Null error from login")
                            }
                            break
                        case .failure(let error):
                            if error == .invalid {
                                self.showAlert(msg: "Email or password incorrect")
                            } else {
                                self.showAlert(msg: error.localizedDescription)
                            }
                            break
                    }
                }
            }
        }
        
        signinButton.addAction(signInAction, for: .touchUpInside)    

        let signInWithKeyAction = UIAction { [unowned self] (action) in
            if let url = buildAuthUrl() {
                
                let scheme = "veracoin"
                
                // Initialize the session.
                let session = ASWebAuthenticationSession(url: url, callbackURLScheme: scheme) { callbackURL, error in
                    // Handle the callback.
                    if let error = error {
                        self.showAlert(msg: error.localizedDescription)
                        return
                    }

                    // Check we got our state back, also extract code
                    if let url = callbackURL, let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true)  {
                        
                        let items = components.queryItems!
                        var code = ""
                        
                        for item in items {
                            if item.name == "code" {
                                code = item.value!
                            }
                        }
                    
                        let request = self.buildTokenRequest(code: code)
                        
                        URLSession.shared.dataTask(with: request) { data, response, error in
                            // handle the result here.
                            if let _ = error {
                                self.showAlert(msg: "Token Not Retrieved")
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
                                let _ = try decoder.decode(TokenResponse.self, from: data!)
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
                            
                            if let tokenResponse = try? decoder.decode(TokenResponse.self, from: data!) {
                                self.showAlert(msg: "Token: \(tokenResponse.accessToken)")
                                return
                            }
                        }.resume()
                    }

                }
                
                session.presentationContextProvider = self
                session.start()
            }
        }

        signinWithKeyButton.addAction(signInWithKeyAction, for: .touchUpInside)    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

}