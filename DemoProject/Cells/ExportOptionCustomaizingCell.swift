//
//  ExportOptionCustomaizingCell.swift
//  DemoProject
//
//  Created by Karan Karthic Neelamegan on 08/04/21.
//

import UIKit

//protocol PrinterOptionCustomaizingCellDelegate:class  {
//
//    func pushSelectVC(cell:UITableViewCell?)
//    func updateposition(position:String,inPosition:Position)
//
//}

struct ExportOptionCustomaizingCellModel{
    let titleLabel :String
    let position :Position
    let subValuePickerOneViewtitle :String
    let subValuePickerOneViewvalue :String
    
    let subValuePickerTwoViewtitle :String
    let subValuePickerTwoViewvalue :String
}

class ExportOptionCustomaizingCell : UITableViewCell {
    
    private var items:[PositionItems] = PositionItems.allCases
    
    var toPushSelectVC:(UITableViewCell?) -> Void = {_ in }
    
    var onUpdateValue:(String)->Void = {_ in}
    
//    weak var delegate : PrinterOptionCustomaizingCellDelegate?
    
    var position:Position = .header
    
    private lazy var titleLabel: UILabel = {
        
        let titleLabel = UILabel()
        titleLabel.text = "Page"
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
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
        subValuePickerTwoView.valueTextField.isEnabled = false
        subValuePickerTwoView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(callDelegate)))
        return subValuePickerTwoView
    }()
    

    private lazy var subValueOnePicker: UIPickerView = {

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
    
    func configure(model:ExportOptionCustomaizingCellModel){

        titleLabel.text = model.titleLabel
        position = model.position
        subValuePickerOneView.title.text = model.subValuePickerOneViewtitle
        subValuePickerOneView.valueTextField.text =  model.subValuePickerOneViewvalue
        
        subValuePickerTwoView.title.text = model.subValuePickerTwoViewtitle
        subValuePickerTwoView.valueTextField.text = model.subValuePickerTwoViewvalue
    }
    
    
    
    private func setupCellView(){
        
        self.contentView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(separatorLine)
        verticalStackView.addArrangedSubview(horizontalStackView)
        
        horizontalStackView.addArrangedSubview(subValuePickerOneView)
        
        horizontalStackView.addArrangedSubview(subValuePickerTwoView)

        if UIDevice.current.userInterfaceIdiom == .pad {
            subValuePickerOneView.title.font = .systemFont(ofSize: 16, weight: .bold)
            subValuePickerTwoView.title.font = .systemFont(ofSize: 16, weight: .bold)
            titleLabel.heightAnchor.constraint(equalToConstant: 0).isActive = true
            separatorLine.heightAnchor.constraint(equalToConstant: 0).isActive = true
            separatorLine.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor,constant: 10).isActive = true
            verticalStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -10).isActive = true
        }else{
            
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
        }
        
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
    
    @objc private func callDelegate(){
//        delegate?.pushSelectVC(cell: self)
        toPushSelectVC(self)
    }
    
    @objc private func dismissPickerViewaction(){
          
        self.contentView.endEditing(true)
//        delegate?.updateposition(position:subValuePickerOneView.valueTextField.text ?? "", inPosition: position)
        onUpdateValue(subValuePickerOneView.valueTextField.text ?? "")
    }
    
    
}

extension ExportOptionCustomaizingCell: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       
            return items.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       
        let row = items[row].rawValue
            return row
       
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       
            let row = items[row].rawValue
            subValuePickerOneView.valueTextField.text = row
       
    }
}

