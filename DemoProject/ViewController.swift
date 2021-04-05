//
//  ViewController.swift
//  DemoProject
//
//  Created by Karan Karthic Neelamegan on 17/03/21.
//

import UIKit

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func printView(_ sender: Any) {
        let vc = PrintOptionsViewController()
        let navVc = UINavigationController(rootViewController: vc)
        
//        navVc.modalPresentationStyle = .formSheet
        self.present(navVc, animated: true, completion: nil)
    }
    @IBAction func exportView(_ sender: Any) {
        let navVc = UINavigationController(rootViewController: ExportSettingViewController())
//        navVc.modalPresentationStyle = .formSheet
        self.present(navVc, animated: true, completion: nil)
    }
}
