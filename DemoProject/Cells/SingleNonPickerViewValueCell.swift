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
        
        self.contentView.addSubview(subValuePickerTwoView)
        
        let topCons:CGFloat
        let bottomCons:CGFloat
        let leftCons:CGFloat
        let rightCons:CGFloat
        
        if UIDevice.current.userInterfaceIdiom == .phone {
             topCons = 19
             bottomCons = -20
             leftCons = 19
             rightCons = -19
            subValuePickerTwoView.addBorder(edge: .bottom)
        }else{
            
            topCons = 15
            bottomCons = -15
            leftCons = 15
            rightCons = -15
        }
        
        NSLayoutConstraint.activate([
        
            subValuePickerTwoView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: topCons),
            subValuePickerTwoView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: leftCons),
            subValuePickerTwoView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: bottomCons),
            subValuePickerTwoView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: rightCons)
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


