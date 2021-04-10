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

struct SinglePickerViewCellModel{
    var fileNameViewtitle:String
    var items:[String]
    var fileNameViewvalue:String
}


class SinglePickerViewCell:UITableViewCell{
    
    weak var delegate:SinglePickerViewCellDelegate?
    
    
    private lazy var fileNameView:PickerOptionView = {
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
    
    private lazy var subValueOnePicker: UIPickerView = {

        let subValueOnePicker = UIPickerView()
        subValueOnePicker.delegate = self
        subValueOnePicker.dataSource = self
        subValueOnePicker.translatesAutoresizingMaskIntoConstraints = false
        return subValueOnePicker
    }()
    
    private var fileNameViewEdges:UIEdgeInsets {
        if UIDevice.current.userInterfaceIdiom == .phone {
            
            return UIEdgeInsets(top: 19, left: 19, bottom: -20, right: -19)
        }
        return UIEdgeInsets(top: 15, left: 15, bottom: -15, right: -15)
    }
    
    private var shouldShowBottomBorder:Bool{
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    
    private var items:[String] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    func configure(model:SinglePickerViewCellModel){
        fileNameView.title.text = model.fileNameViewtitle
        items = model.items
        fileNameView.valueTextField.text = model.fileNameViewvalue
    }
    
    
    private func setupView(){
        self.contentView.addSubview(fileNameView)
        
        if shouldShowBottomBorder{
            fileNameView.addBorder(edge: .bottom)
        }
        
        NSLayoutConstraint.activate([
        
            fileNameView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: fileNameViewEdges.top),
            fileNameView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: fileNameViewEdges.left),
            fileNameView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: fileNameViewEdges.bottom),
            fileNameView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: fileNameViewEdges.right)
            ])
    }
    
    @objc private func dismissPickerViewaction(){
          
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

