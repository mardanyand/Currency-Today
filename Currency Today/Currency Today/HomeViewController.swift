//
//  HomeViewController.swift
//  Currency Today
//
//  Created by Student on 18.07.25.
//

import UIKit

class CourseOption {
    var name: String
    var currency: String
    var backgroundImage: UIImage
    var backgroundColor: UIColor
    var course: String
    
    
    init(name: String, currency: String, backgroundImage: UIImage, backgroundColor: UIColor, course: String) {
        self.name = name
        self.currency = currency
        self.backgroundImage = backgroundImage
        self.backgroundColor = backgroundColor
        self.course = course
    }
}

class HomeViewController: UIViewController {

    @IBOutlet weak var navbar: UINavigationBar!
    @IBOutlet weak var tableview: UITableView!
    
    var models = [CourseOption]()
    
    var currencyCode: [String] = []
    var volues: [Double] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        getCurrentDate()
        configure()
        fetchJson()
    }
    
    
    func fetchJson(){

            guard let url = URL(string: "https://open.er-api.com/v6/latest/AMD") else {return}

            URLSession.shared.dataTask(with: url) {[self] (data, response, error) in

                if error != nil {

                    print(error!.localizedDescription)

                    return

                }

                guard let safeData = data else {return}

                do{

                    let rezults = try JSONDecoder().decode(ExchangeRates.self, from: safeData)

                    self.currencyCode.append(contentsOf: rezults.rates.keys)

                    self.volues.append(contentsOf: rezults.rates.values)

                    rezults.rates.forEach { (key, value) in

                        self.models = self.models.map {

                            if $0.name == key {

                                let courseKey = (Double(models[0].course) ?? 0)/value

                                $0.course = "\(Double(round(100 * courseKey) / 100))"

                            }

                            return $0

                        }

                    }

                    DispatchQueue.main.async {

                        self.tableview.reloadData()

                    }

                }

                catch {

                    print(error)

                }

            }.resume()

        }
    
    
    func configure(){
        models.append(contentsOf: [
            CourseOption(name: "AMD", currency: "Armenia", backgroundImage: UIImage(named: "Armenia")!, backgroundColor: .white, course: "1"),
            CourseOption(name: "RUB", currency: "Russia", backgroundImage: UIImage(named: "Russia")!, backgroundColor: .white, course: "4.5"),
            CourseOption(name: "EUR", currency: "Eurozone", backgroundImage: UIImage(named: "Europe")!, backgroundColor: .white, course: "400"),
            CourseOption(name: "USD", currency: "USA", backgroundImage: UIImage(named: "Usa")!, backgroundColor: .white, course: "400"),
            CourseOption(name: "JPY", currency: "Japan", backgroundImage: UIImage(named: "Japan")!, backgroundColor: .white, course: "400"),
            CourseOption(name: "GBP", currency: "UK", backgroundImage: UIImage(named: "UK")!, backgroundColor: .white, course: "400"),
            CourseOption(name: "CHF", currency: "Switzerland", backgroundImage: UIImage(named: "Switzerland")!, backgroundColor: .white, course: "400"),
            CourseOption(name: "CAD", currency: "Canada", backgroundImage: UIImage(named: "Canada")!, backgroundColor: .white, course: "400"),
            CourseOption(name: "AUD", currency: "Australia", backgroundImage: UIImage(named: "Australia")!, backgroundColor: .white, course: "400"),
            CourseOption(name: "NZD", currency: "New Zealand", backgroundImage: UIImage(named: "NewZealand")!, backgroundColor: .white, course: "400"),
            CourseOption(name: "SEK", currency: "Sweden", backgroundImage: UIImage(named: "Sweden")!, backgroundColor: .white, course: "400"),
            CourseOption(name: "INR", currency: "India", backgroundImage: UIImage(named: "India")!, backgroundColor: .white, course: "400"),
            CourseOption(name: "BRL", currency: "Brazil", backgroundImage: UIImage(named: "Brazil")!, backgroundColor: .white, course: "400"),
            CourseOption(name: "MXN", currency: "Mexico", backgroundImage: UIImage(named: "Mexico")!, backgroundColor: .white, course: "400"),
            CourseOption(name: "KRW", currency: "South Korea", backgroundImage: UIImage(named: "SouthKorea")!, backgroundColor: .white, course: "400"),
            CourseOption(name: "SGD", currency: "Singapore", backgroundImage: UIImage(named: "Singapore")!, backgroundColor: .white, course: "400"),
            CourseOption(name: "ZAR", currency: "South Africa", backgroundImage: UIImage(named: "SouthAfrica")!, backgroundColor: .white, course: "400"),
            CourseOption(name: "TRY", currency: "Turkey", backgroundImage: UIImage(named: "Turkey")!, backgroundColor: .white, course: "400"),
            CourseOption(name: "NOK", currency: "Norway", backgroundImage: UIImage(named: "Norway")!, backgroundColor: .white, course: "400"),
            CourseOption(name: "ARS", currency: "Argentina", backgroundImage: UIImage(named: "Argentina")!, backgroundColor: .white, course: "400"),
        ])
    }
    
    
    func getCurrentDate(){
        var now = Date()
        var nowComponents = DateComponents()
        let calendar = Calendar.current
        nowComponents.year = Calendar.current.component(.year, from: now)
        nowComponents.month = Calendar.current.component(.month, from: now)
        nowComponents.day = Calendar.current.component(.day, from: now)
        nowComponents.timeZone = NSTimeZone.local
        now = calendar.date(from: nowComponents)!
        navbar.topItem?.title = "\(nowComponents.day!).\(nowComponents.month!).\(nowComponents.year!)"
    }
    
    @IBAction func change(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ChangeViewController") as? ChangeViewController
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: true)
    }
    
    @IBAction func settings(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: true)
    }
    
}


extension HomeViewController: UITableViewDelegate,
                              UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier,
                                                 for: indexPath) as? HomeTableViewCell
        
        else{
            return UITableViewCell()
        }
        cell.configure(with: model)
        return cell
            
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableview.deselectRow(at: indexPath, animated: true)
    }
}
