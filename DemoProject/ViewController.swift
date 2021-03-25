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
    
    @IBAction func buttonfunc(_ sender: Any) {
        
        let navVc = UINavigationController(rootViewController: PassWordSettingViewController())
//        navVc.modalPresentationStyle = .formSheet
        self.present(navVc, animated: true, completion: nil)
    }
    
}
