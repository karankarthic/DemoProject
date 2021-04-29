//
//  PageCustomizationCell.swift
//  DemoProject
//
//  Created by Karan Karthic Neelamegan on 08/04/21.
//

import UIKit

//protocol PageCustomizationCellDelegate:class  {
//
//    func updateposition(size:String,orientation:String)
//
//}
enum Size:String,CaseIterable{
    case A4 = "A4"
    case A9 = "A9"
    case A3 = "A3"
    
    
}
enum PositionItems:String,CaseIterable {
    case left = "Left"
    case right = "Right"
//    case top = "Top"
    case bottom = "Center"
}
enum OrientationItems:String,CaseIterable {
    case portait = "Portait"
    case landscape = "Landscape"
}

struct PageCustomizationCellModel{
    let titleLabel:String
    let subValuePickerOneViewTitle :String
    let subValuePickerOneViewvalue :String
    let subValuePickerTwoViewTitle :String
    let subValuePickerTwoViewvalue :String
}

class PageCustomizationCell: UITableViewCell{
    
    private var items:[Size] = Size.allCases
    private var orientationItems:[OrientationItems] = OrientationItems.allCases
    
//    weak var delegate : PageCustomizationCellDelegate?
    var onUpdateValue:(String,String) -> Void = {_,_ in }
    
    private lazy var titleLabel: UILabel = {
        
        let titleLabel = UILabel()
        titleLabel.text = "Page"
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.backgroundColor = .clear
        return titleLabel
    }()
    
    private lazy var subValuePickerOneView : PickerOptionView = {
        
        var subValuePickerOneView = PickerOptionView()
        
        subValuePickerOneView.valueTextField.inputView = subValueOnePicker
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
         let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissPickerViewaction))
         toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        subValuePickerOneView.valueTextField.inputAccessoryView = toolBar
        
        subValueOnePicker.delegate = self
        subValueOnePicker.dataSource = self
        
        return subValuePickerOneView
    }()
    
    private lazy var subValuePickerTwoView : PickerOptionView = {
        
        var subValuePickerTwoView = PickerOptionView()
        subValuePickerTwoView.valueTextField.inputView = subValueTwoPicker
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
         let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissPickerViewaction))
         toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        subValuePickerTwoView.valueTextField.inputAccessoryView = toolBar
        
        subValueTwoPicker.delegate = self
        subValueTwoPicker.dataSource = self
        
        return subValuePickerTwoView
    }()
    

    private lazy var subValueOnePicker: UIPickerView = {

        let subValueOnePicker = UIPickerView()
        subValueOnePicker.delegate = self
        subValueOnePicker.dataSource = self
        subValueOnePicker.translatesAutoresizingMaskIntoConstraints = false
        return subValueOnePicker
    }()
    
    private lazy var subValueTwoPicker: UIPickerView = {

        let subValueOnePicker = UIPickerView()
        subValueOnePicker.delegate = self
        subValueOnePicker.dataSource = self
        subValueOnePicker.translatesAutoresizingMaskIntoConstraints = false
        return subValueOnePicker
    }()
    
    private lazy var separatorLine: UIView = {
        let separatorLine = UIView()
        separatorLine.backgroundColor = UIColor.separator
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        return separatorLine
    }()
    
    private lazy var verticalStackView:UIStackView = {
        let vStack = UIStackView()
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.alignment = .fill
        vStack.distribution = .equalSpacing
        return vStack
        
    }()
    
    private lazy var horizontalStackView:UIStackView = {
        let vStack = UIStackView()
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .horizontal
        vStack.alignment = .fill
        vStack.distribution = .fillEqually
        vStack.spacing = 16
        return vStack
        
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model:PageCustomizationCellModel){
        
        titleLabel.text = model.titleLabel
        subValuePickerOneView.title.text = model.subValuePickerOneViewTitle
        subValuePickerOneView.valueTextField.text = model.subValuePickerOneViewvalue
        
        subValuePickerTwoView.title.text = model.subValuePickerTwoViewTitle
        subValuePickerTwoView.valueTextField.text = model.subValuePickerTwoViewvalue
        
    }
    
    private func setupCellView(){
        
        self.contentView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(separatorLine)
        verticalStackView.addArrangedSubview(horizontalStackView)
        
        horizontalStackView.addArrangedSubview(subValuePickerOneView)
        
        horizontalStackView.addArrangedSubview(subValuePickerTwoView)
  
            subValuePickerOneView.title.font = .systemFont(ofSize: 17, weight: .bold)
            subValuePickerTwoView.title.font = .systemFont(ofSize: 17, weight: .bold)
            NSLayoutConstraint.activate([
            
                titleLabel.leadingAnchor.constraint(equalTo: self.verticalStackView.leadingAnchor,constant: 19),
                titleLabel.topAnchor.constraint(equalTo: self.verticalStackView.topAnchor,constant: 20),

                
                separatorLine.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor,constant: 20),
                separatorLine.leadingAnchor.constraint(equalTo: self.verticalStackView.leadingAnchor),
                separatorLine.trailingAnchor.constraint(equalTo: self.verticalStackView.trailingAnchor),
                verticalStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -19),
                separatorLine.heightAnchor.constraint(equalToConstant: 0.5),
            
            ])
            
            subValuePickerOneView.addBorder(edge:.bottom)
            subValuePickerTwoView.addBorder(edge: .bottom)
       
        
        NSLayoutConstraint.activate([
        
            verticalStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            horizontalStackView.topAnchor.constraint(equalTo: self.separatorLine.bottomAnchor,constant: 20),
            horizontalStackView.leadingAnchor.constraint(equalTo: self.verticalStackView.leadingAnchor,constant: 19),
            horizontalStackView.bottomAnchor.constraint(equalTo: self.verticalStackView.bottomAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: self.verticalStackView.trailingAnchor,constant: -20)
            
            
            ])
        
    }

    @objc private func dismissPickerViewaction(){
          
//        delegate?.updateposition(size: subValuePickerOneView.valueTextField.text ?? "", orientation: subValuePickerTwoView.valueTextField.text ?? "")
        onUpdateValue(subValuePickerOneView.valueTextField.text ?? "", subValuePickerTwoView.valueTextField.text ?? "")
        self.contentView.endEditing(true)

    }
    
    
}

extension PageCustomizationCell: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == subValueOnePicker {
            return items.count
        }else{
            return orientationItems.count
        }
       
           
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       
        if pickerView == subValueOnePicker {
            let row = items[row].rawValue
            return row
        }else{
            let row = orientationItems[row].rawValue
            return row
        }
        
            
       
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       
        if pickerView == subValueOnePicker {
            let row = items[row].rawValue
            subValuePickerOneView.valueTextField.text = row
        }else{
            let row = orientationItems[row].rawValue
            subValuePickerTwoView.valueTextField.text = row
        }
    }
}
