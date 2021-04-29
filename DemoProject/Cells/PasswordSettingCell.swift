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

struct PasswordSettingCellModel{
    var title:String? = nil
    let value:String?
    let type:PasswardViewType
}

class PasswordSettingCell:UITableViewCell, UITextFieldDelegate{
    
    weak var delegate:PasswordSettingCellDelegate?
    private lazy var passwordView: PickerOptionView = {
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
    
    private var verticalStackViewEdges:UIEdgeInsets {
       
            return UIEdgeInsets(top: 19, left: 19, bottom: -19, right: -19)
    
    }
    
    private var type : PasswardViewType = .password
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    func configure(model:PasswordSettingCellModel){
        
        if model.title != nil{
            passwordView.title.text = model.title
        }
        
        passwordView.valueTextField.text = model.value
        type = model.type
    }
    
    private func setupView(){

        self.contentView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(passwordView)
        
        
//        if UIDevice.current.userInterfaceIdiom == .pad {
//
//            passwordView.title.removeFromSuperview()
//        }else{
//
            passwordView.addBorder(edge: .bottom)
//        }
        
        NSLayoutConstraint.activate([verticalStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: verticalStackViewEdges.top),
                                     verticalStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: verticalStackViewEdges.left),
                                     verticalStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: verticalStackViewEdges.bottom),
                                     verticalStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: verticalStackViewEdges.right),
                                     
        
        ])

        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        delegate?.updatePasswordValue(type: self.type, value: passwordView.valueTextField.text)
        
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
