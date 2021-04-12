//
//  ExportSettingsFileNameCell.swift
//  DemoProject
//
//  Created by Karan Karthic Neelamegan on 08/04/21.
//

import UIKit

//protocol ExportSettingsFileNameCellDelegate :class{
//    func updateValue(fileName:String)
//}

struct ExportSettingsFileNameCellModel{
    let title:String
    let value:String
}


class ExportSettingsFileNameCell:UITableViewCell, UITextFieldDelegate {
    
//    weak var delegate: ExportSettingsFileNameCellDelegate?
    
    var onUpdateValue:(String) -> Void = {_ in }
    
    private lazy var fileNameView:PickerOptionView = {
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
    
    private var pickerviewEdges:UIEdgeInsets {
        if UIDevice.current.userInterfaceIdiom == .phone {
            
            return UIEdgeInsets(top: 19, left: 19, bottom: -20, right: -19)
        }
        return UIEdgeInsets(top: 15, left: 15, bottom: -15, right: -15)
    }
    
    private var shouldShowBottomBorder:Bool{
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    func configure(model:ExportSettingsFileNameCellModel){
        fileNameView.title.text = model.title
        fileNameView.valueTextField.text = model.value
    }
    
    
    private func setupView(){
        self.contentView.addSubview(fileNameView)
        
       
        
        if shouldShowBottomBorder{
            fileNameView.addBorder(edge: .bottom)
        }
        
        NSLayoutConstraint.activate([
        
            fileNameView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: pickerviewEdges.top),
            fileNameView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: pickerviewEdges.left),
            fileNameView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: pickerviewEdges.bottom),
            fileNameView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: pickerviewEdges.right)
            ])
        
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
//        delegate?.updateValue(fileName: textField.text ?? "")
        
        onUpdateValue(textField.text ?? "")
        
        return true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

