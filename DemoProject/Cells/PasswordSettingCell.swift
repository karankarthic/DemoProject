//
//  PasswordSettingCell.swift
//  DemoProject
//
//  Created by Karan Karthic Neelamegan on 08/04/21.
//

import UIKit


enum PasswardViewType {
    case password
    case confirmPassword
}

protocol PasswordSettingCellDelegate:class{
    func updatePasswordValue(type:PasswardViewType,value:String?)
}

class PasswordSettingCell:UITableViewCell, UITextFieldDelegate{
    
    weak var delegate:PasswordSettingCellDelegate?
    lazy var passwordView: PickerOptionView = {
        var passwordView = PickerOptionView()
        passwordView.valueTextField.inputView = nil
        passwordView.valueTextField.inputAccessoryView = nil
        passwordView.valueTextField.tintColor = self.tintColor
        passwordView.valueTextField.selectedTextRange = .none
        passwordView.valueTextField.isSecureTextEntry = true
        passwordView.valueTextField.enablePasswordToggle()
        passwordView.valueTextField.delegate = self
        return passwordView
        
    }()
    

    private lazy var verticalStackView:UIStackView = {
        let vStack = UIStackView()
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.alignment = .fill
        vStack.distribution = .fillProportionally
        vStack.spacing = 20
        return vStack
        
    }()
    
    var type : PasswardViewType = .password
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    private func setupView(){

        self.contentView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(passwordView)
        
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            
            passwordView.title.removeFromSuperview()
            
            NSLayoutConstraint.activate([verticalStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 15),
                                         verticalStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 20),
                                         verticalStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -15),
                                         verticalStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -15),
                                         
            
            ])

        }else{
            
            NSLayoutConstraint.activate([verticalStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 19),
                                         verticalStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 19),
                                         verticalStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -19),
                                         verticalStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -19),
                                         
            
            ])

            passwordView.addBorder(edge: .bottom)
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        delegate?.updatePasswordValue(type: self.type, value: passwordView.valueTextField.text)
        return true
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        
        textField.isSecureTextEntry = true
        textField.rightView?.tintColor = .lightGray
    }
    
    
    
}



extension UITextField {
    fileprivate func setPasswordToggleImage(_ button: UIButton) {
        if(isSecureTextEntry){
            button.tintColor = .lightGray
        }else{
            button.tintColor = self.tintColor
        }
    }

    func enablePasswordToggle(){
        let button = UIButton(type: .custom)
        setPasswordToggleImage(button)
        button.setImage(UIImage(named: "Image")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .lightGray
        button.addTarget(self, action: #selector(self.togglePasswordView), for: .touchUpInside)
        self.rightView = button
        self.rightViewMode = .whileEditing
    }
    @objc func togglePasswordView(_ sender: Any) {
        self.isSecureTextEntry = !self.isSecureTextEntry
        setPasswordToggleImage(sender as! UIButton)
    }
}
