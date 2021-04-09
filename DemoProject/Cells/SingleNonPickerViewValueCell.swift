//
//  SingleNonPickerViewValueCell.swift
//  DemoProject
//
//  Created by Karan Karthic Neelamegan on 08/04/21.
//

import UIKit

protocol SingleNonPickerViewValueCellDelegate:class  {
    
    func pushSelectVC()
    
}

class SingleNonPickerViewValueCell: UITableViewCell{
    
    weak var delegate: SingleNonPickerViewValueCellDelegate?
    
    private var pickerviewEdges:UIEdgeInsets {
        if UIDevice.current.userInterfaceIdiom == .phone {
            
            return UIEdgeInsets(top: 19, left: 19, bottom: -20, right: -19)
        }
        return UIEdgeInsets(top: 15, left: 15, bottom: -15, right: -15)
    }
    
    private var shouldShowBottomBorder:Bool{
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    
    lazy var subValuePickerTwoView : PickerOptionView = {
        
        var subValuePickerTwoView = PickerOptionView()
        subValuePickerTwoView.translatesAutoresizingMaskIntoConstraints = false
        subValuePickerTwoView.valueTextField.isEnabled = false
        subValuePickerTwoView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(callDelegate)))
        return subValuePickerTwoView
    }()
    
    var value:String = "Select"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
        
    }
    
    private func setUpView(){
        self.contentView.addSubview(subValuePickerTwoView)
        
        if shouldShowBottomBorder{
            subValuePickerTwoView.addBorder(edge: .bottom)
        }
        
        NSLayoutConstraint.activate([
        
            subValuePickerTwoView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: pickerviewEdges.top),
            subValuePickerTwoView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: pickerviewEdges.left),
            subValuePickerTwoView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: pickerviewEdges.bottom),
            subValuePickerTwoView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: pickerviewEdges.right)
            ])
        
        subValuePickerTwoView.valueTextField.text = value
    }
    
    func configure(value:String){
        self.value = value
    }
    
    @objc private func callDelegate(){
        delegate?.pushSelectVC()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


