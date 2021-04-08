//
//  ExportSettingsFileNameCell.swift
//  DemoProject
//
//  Created by Karan Karthic Neelamegan on 08/04/21.
//

import UIKit

protocol ExportSettingsFileNameCellDelegate :class{
    func updateValue(fileName:String)
}


class ExportSettingsFileNameCell:UITableViewCell, UITextFieldDelegate {
    
    weak var delegate: ExportSettingsFileNameCellDelegate?
    
    lazy var fileNameView:PickerOptionView = {
        let fileName = PickerOptionView()
        fileName.translatesAutoresizingMaskIntoConstraints = false
        fileName.valueTextField.inputView = nil
        fileName.valueTextField.inputAccessoryView = nil
        fileName.valueTextField.rightViewMode = .never
        fileName.valueTextField.text = ""
        fileName.valueTextField.delegate = self
        fileName.valueTextField.tintColor = .black
        return fileName
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    func setupView(){
        self.contentView.addSubview(fileNameView)
        
        let topCons:CGFloat
        let bottomCons:CGFloat
        let leftCons:CGFloat
        let rightCons:CGFloat
        
        if UIDevice.current.userInterfaceIdiom == .phone {
             topCons = 19
             bottomCons = -20
             leftCons = 19
             rightCons = -19
            fileNameView.addBorder(edge: .bottom)
        }else{
            
            topCons = 15
            bottomCons = -15
            leftCons = 15
            rightCons = -15
        }
        
        
        
        NSLayoutConstraint.activate([
        
            fileNameView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: topCons),
            fileNameView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: leftCons),
            fileNameView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: bottomCons),
            fileNameView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: rightCons)
            ])
        
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        delegate?.updateValue(fileName: textField.text ?? "")
        
        return true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

