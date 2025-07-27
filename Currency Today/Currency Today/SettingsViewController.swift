//
//  SettingsViewController.swift
//  Currency Today
//
//  Created by Student on 18.07.25.
//

import UIKit

class SettingsOption{
    var name:String
    var backgroundColor: UIColor
    var backgrondImage: UIImage
    init(name: String, backgroundColor: UIColor, backgrondImage: UIImage) {
        self.name = name
        self.backgroundColor = backgroundColor
        self.backgrondImage = backgrondImage
    }
 
}


class SettingsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var models = [SettingsOption]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.identifier)
        configure()
    }
    func configure(){
        models.append(contentsOf: [
            SettingsOption(name: "About programm", backgroundColor: .systemTeal, backgrondImage: UIImage(systemName: "info.circle")!),
            SettingsOption(name: "Share", backgroundColor: .systemTeal, backgrondImage: UIImage(systemName: "arrowshape.turn.up.right")!),
            SettingsOption(name: "Author", backgroundColor: .systemTeal, backgrondImage: UIImage(systemName: "crown")!),
            SettingsOption(name: "Contact", backgroundColor: .systemTeal, backgrondImage: UIImage(systemName: "person.fill")!),
        ])
    }
    
    @IBAction func home(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: true)
    }
    
    @IBAction func change(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ChangeViewController") as? ChangeViewController
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: true)
    }
}

extension SettingsViewController:UITableViewDelegate,
                                 UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath) as? SettingsTableViewCell
                
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
        
        if models[indexPath.item].name == "Contact" {
            
            let actionSheet = UIAlertController(title: "Contact", message: nil, preferredStyle: .actionSheet)
            
            actionSheet.addAction(UIAlertAction(title: "Instagram", style: .default, handler: { (action) in
                
                UIApplication.shared.openURL(NSURL(string: "https://www.instagram.com/daya_na0412/")! as URL)
                
            }))
            
            actionSheet.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
            
            present(actionSheet, animated: true, completion: nil)
            
        } else if models[indexPath.item].name == "Author" {
            
            let alert = UIAlertController(title: "Author", message: "My name is Dayana Mardanyan, and I am 14 years old. From July 17 to July 27, I worked passionately to create the Currency Today app. This project was a wonderful learning experience, and I was lucky to have the guidance and support of my teacher, Garnik Hakobyan, who helped me bring my ideas to life. I’m excited to share my app with everyone and hope it makes currency conversion easier for users around the world.", preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
        }else if models[indexPath.item].name == "Share" {
            
            let activityVC = UIActivityViewController(activityItems: [""], applicationActivities: nil)
            
            activityVC.popoverPresentationController?.sourceView = self.view
            
            self.present(activityVC, animated: true, completion: nil)
            
        }else if models[indexPath.item].name == "About programm" {
            
            let alert = UIAlertController(title: "appInfo", message: "Currency Today is a simple and fast currency converter app that supports over 20 currencies. It works offline, making it perfect for travelers who need quick conversions without internet. The app is easy to use, lightweight, and available for iPhone and iPad. You can download it for free with an option to remove ads.", preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction(title: "ok", style: .destructive, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
        }
    }
}
