//
//  IpadPasswordViewController.swift
//  DemoProject
//
//  Created by Karan Karthic Neelamegan on 25/03/21.
//

import UIKit

class IpadPasswordViewController: UITableViewController {
    
    
    init(){
        super.init(style: .grouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView.registerReusableCell(PasswordSettingCell.self)
        tableView.allowsSelection = false
        self.navigationItem.title = "Password Setting"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(indexPath: indexPath) as PasswordSettingCell
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "Password"
        }
        else{
            return "Confirm Password"
        }
        
    }

}
