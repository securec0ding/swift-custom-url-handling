//
//  HomeViewController.swift
//  Veracoin
//
//  This is a mocked ViewController
//

class HomeViewController: BaseLoggingViewController {
    private let balanceLabel = UILabel()
    private let atmWithdrawsButton = UIButton()
    private var locationManager: CLLocationManager

    override init() {
        self.locationManager = CLLocationManager()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers

        self.view.addSubview(balanceLabel)
        self.view.addSubview(atmWithdrawsButton)

        let withdrawAction = UIAction { (action) in
            Router.sharedInstance.showWithdraws()     
        }   

        atmWithdrawsButton.addAction(withdrawAction, for: .touchUpInside)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let currentUser = UserManager.sharedInstance.currentUser {
            self.balanceLabel.text = String(currentUser.balance)
        }
    }
}

extension HomeViewController: CLLocationManagerDelegate {    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        if let location = locations.last {
            VeracoinAPI.sharedInstance.reportPosition(location: location)
        }
    }    
}