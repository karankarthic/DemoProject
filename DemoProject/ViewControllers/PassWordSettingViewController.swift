//
//  PassWordViewController.swift
//  DemoProject
//
//  Created by Karan Karthic Neelamegan on 23/03/21.
//

import UIKit

struct Passwords{
    
    var password:String? = nil
    var conforimPassword:String? = nil
    
}

protocol PassWordSettingViewControllerDelegate:class{
    func updatePasswordValue(passwordValue:Passwords)
}

class PassWordSettingViewController: CardLayoutTableViewController {
    
    var value:Passwords = Passwords()
    weak var delegate:PassWordSettingViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerReusableCell(PasswordSettingCell.self)
        tableView.allowsSelection = false
        self.navigationItem.title = "Password Setting"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(indexPath: indexPath) as PasswordSettingCell
        if indexPath.section == 0{
            cell.passwordView.title.text = "Password"
            cell.passwordView.valueTextField.text = self.value.password
            cell.type = .password
        }else{
            cell.passwordView.title.text = "Confirm Password"
            cell.passwordView.valueTextField.text = self.value.conforimPassword
            cell.type = .confirmPassword
        }
        cell.delegate = self
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }

    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return 12
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 0
        }
        return 12
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        let viewConstructor = CornerViewConstructor.init(contentView: cell.contentView)
        
        if indexPath.section == 0 {
            viewConstructor.constructLayout(for: .topCorner)
        }else if indexPath.section == 1{
            viewConstructor.constructLayout(for: .bottomCorner)
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

extension PassWordSettingViewController:PasswordSettingCellDelegate{
    func updatePasswordValue(type: PasswardViewType, value: String?) {
        if type == .password{
            self.value.password = value
        }else{
            self.value.conforimPassword = value
        }
    }
    
    
}
