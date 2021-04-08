//
//  SinglePickerViewCell.swift
//  DemoProject
//
//  Created by Karan Karthic Neelamegan on 08/04/21.
//

import UIKit

protocol SinglePickerViewCellDelegate :class{
    func updateSinglePickerValue(value:String)
}


class SinglePickerViewCell:UITableViewCell{
    
    weak var delegate:SinglePickerViewCellDelegate?
    
    lazy var fileNameView:PickerOptionView = {
        let fileName = PickerOptionView()
        fileName.translatesAutoresizingMaskIntoConstraints = false
        fileName.valueTextField.inputView = subValueOnePicker
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
         let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissPickerViewaction))
         toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        fileName.valueTextField.inputAccessoryView = toolBar
        
        return fileName
    }()
    
    lazy var subValueOnePicker: UIPickerView = {

        let subValueOnePicker = UIPickerView()
        subValueOnePicker.delegate = self
        subValueOnePicker.dataSource = self
        subValueOnePicker.translatesAutoresizingMaskIntoConstraints = false
        return subValueOnePicker
    }()
    
    var items:[String] = []
    
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
    
    @objc func dismissPickerViewaction(){
          
        delegate?.updateSinglePickerValue(value: fileNameView.valueTextField.text ?? "")
        self.contentView.endEditing(true)

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension SinglePickerViewCell: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
            return items.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    
            let row = items[row]
            return row
       
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
            let row = items[row]
            fileNameView.valueTextField.text = row
        
    }
}

