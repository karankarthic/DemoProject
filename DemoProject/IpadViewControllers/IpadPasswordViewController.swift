//
//  IpadPasswordViewController.swift
//  DemoProject
//
//  Created by Karan Karthic Neelamegan on 25/03/21.
//

import UIKit

class IpadPasswordViewController: UITableViewController {
    
    
    var value:Passwords = Passwords()
    weak var delegate:PassWordSettingViewControllerDelegate?

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
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))

    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(indexPath: indexPath) as PasswordSettingCell
        let model:PasswordSettingCellModel
        if indexPath.section == 0{
            model = PasswordSettingCellModel(value:self.value.password ,type: .password)
        }else{
            model = PasswordSettingCellModel(value: self.value.conforimPassword, type: .confirmPassword)
        }
        cell.configure(model:model)
        cell.delegate = self
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
    
    @objc private func done(){
        
        if checkIsPasswordsEqual(){
            
            delegate?.updatePasswordValue(passwordValue:value)
            self.dismiss(animated: true, completion: nil)
        }
        
        
    }
    
    private func checkIsPasswordsEqual() -> Bool{
        return self.value.password == self.value.conforimPassword
    }
    
    @objc private func cancel(){
        
        self.dismiss(animated: true, completion: nil)
        
    }

}

extension IpadPasswordViewController:PasswordSettingCellDelegate{
    func updatePasswordValue(type: PasswardViewType, value: String?) {
        if type == .password{
            self.value.password = value
        }else{
            self.value.conforimPassword = value
        }
    }
    
    
}
