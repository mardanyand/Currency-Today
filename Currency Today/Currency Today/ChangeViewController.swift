//
//  ChangeViewController.swift
//  Currency Today
//
//  Created by Student on 18.07.25.
//

import UIKit

class ChangeOption {
    var name: String
    var backgroundColor: UIColor
    var backgroundImage: UIImage
    var api: String
    init(name: String, backgroundColor: UIColor, backgroundImage: UIImage, api: String) {
        self.name = name
        self.backgroundColor = backgroundColor
        self.backgroundImage = backgroundImage
        self.api = api
    }
}

class ChangeViewController: UIViewController {


    @IBOutlet weak var tableView: UITableView!
    var models = [ChangeOption]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ChangeTableViewCell.self, forCellReuseIdentifier: ChangeTableViewCell.identifier)
        configure()
        
    }
    
    func configure(){
        models.append(contentsOf: [
            ChangeOption(name: "AMD", backgroundColor: .white, backgroundImage: UIImage(named: "Armenia")!, api: "https://open.er-api.com/v6/latest/AMD"),
            ChangeOption(name: "RUB", backgroundColor: .white, backgroundImage: UIImage(named: "Russia")!, api: "https://open.er-api.com/v6/latest/RUB"),
            ChangeOption(name: "EUR", backgroundColor: .white, backgroundImage: UIImage(named: "Europe")!, api: "https://open.er-api.com/v6/latest/EUR"),
            ChangeOption(name: "USD", backgroundColor: .white, backgroundImage: UIImage(named: "Usa")!, api: "https://open.er-api.com/v6/latest/USD"),
            ChangeOption(name: "JPY", backgroundColor: .white, backgroundImage: UIImage(named: "Japan")!, api: "https://open.er-api.com/v6/latest/JPY"),
            ChangeOption(name: "GBP", backgroundColor: .white, backgroundImage: UIImage(named: "UK")!, api: "https://open.er-api.com/v6/latest/GBP"),
            ChangeOption(name: "CHF", backgroundColor: .white, backgroundImage: UIImage(named: "Switzerland")!, api: "https://open.er-api.com/v6/latest/CHF"),
            ChangeOption(name: "CAD", backgroundColor: .white, backgroundImage: UIImage(named: "Canada")!, api: "https://open.er-api.com/v6/latest/CAD"),
            ChangeOption(name: "AUD", backgroundColor: .white, backgroundImage: UIImage(named: "Australia")!, api: "https://open.er-api.com/v6/latest/AUD"),
            ChangeOption(name: "NZD", backgroundColor: .white, backgroundImage: UIImage(named: "NewZealand")!, api: "https://open.er-api.com/v6/latest/NZD"),
            ChangeOption(name: "SEK", backgroundColor: .white, backgroundImage: UIImage(named: "Sweden")!, api: "https://open.er-api.com/v6/latest/SEK"),
            ChangeOption(name: "INR", backgroundColor: .white, backgroundImage: UIImage(named: "India")!, api: "https://open.er-api.com/v6/latest/INR"),
            ChangeOption(name: "BRL", backgroundColor: .white, backgroundImage: UIImage(named: "Brazil")!, api: "https://open.er-api.com/v6/latest/BRL"),
            ChangeOption(name: "MXN", backgroundColor: .white, backgroundImage: UIImage(named: "Mexico")!, api: "https://open.er-api.com/v6/latest/MXN"),
            ChangeOption(name: "KRW", backgroundColor: .white, backgroundImage: UIImage(named: "SouthKorea")!, api: "https://open.er-api.com/v6/latest/KRW"),
            ChangeOption(name: "SGD", backgroundColor: .white, backgroundImage: UIImage(named: "Singapore")!, api: "https://open.er-api.com/v6/latest/SGD"),
            ChangeOption(name: "ZAR", backgroundColor: .white, backgroundImage: UIImage(named: "SouthAfrica")!, api: "https://open.er-api.com/v6/latest/ZAR"),
            ChangeOption(name: "TRY", backgroundColor: .white, backgroundImage: UIImage(named: "Turkey")!, api: "https://open.er-api.com/v6/latest/TRY"),
            ChangeOption(name: "NOK", backgroundColor: .white, backgroundImage: UIImage(named: "Norway")!, api: "https://open.er-api.com/v6/latest/NOK"),
            ChangeOption(name: "ARS", backgroundColor: .white, backgroundImage: UIImage(named: "Argentina")!, api: "https://open.er-api.com/v6/latest/ARS"),
        ])
    }
    
    @IBAction func home(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
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


extension ChangeViewController: UITableViewDelegate,
                                UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChangeTableViewCell.identifier, for: indexPath) as?     ChangeTableViewCell
        else {
            return UITableViewCell()
            }
        cell.configure(with: model)
    return cell
}
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        if models[indexPath.item].name != "" {
            let vc =
            storyboard?.instantiateViewController(withIdentifier: "ContactViewControler") as? ContactViewController
            vc?.ap = models[indexPath.item].api
            vc?.text = models[indexPath.item].name
            self.present(vc!, animated: true)
        }
    }
}
