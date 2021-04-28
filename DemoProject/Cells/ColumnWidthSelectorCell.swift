//
//  ColumnWidthSelectorCell.swift
//  DemoProject
//
//  Created by Karan Karthic Neelamegan on 28/04/21.
//

import UIKit

enum ColumnWidthValue
{
    case actual
    case content
    case scaling(String)
}

struct ColumnWidthSelectorCellModel{
    
    let title:String
    let selectedValue:ColumnWidthValue
}

class ColumnWidthSelectorCell: UITableViewCell,UITextFieldDelegate {
    
    
    var reloadUiForScaling:() -> Void = { }
    
    var updateValue:(ColumnWidthValue) -> Void = {_ in}
    
    private lazy var verticalStackView:UIStackView = {
        let vStack = UIStackView()
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.alignment = .fill
        vStack.distribution = .fillProportionally
        vStack.spacing = 10
        return vStack
    
    }()
    private lazy var title: UILabel = {
    
        let titleLabel = UILabel()
        titleLabel.text = "Size"
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 17, weight: .bold)
        titleLabel.backgroundColor = .clear
        return titleLabel
    }()
    
    private lazy var separatorLine: UIView = {
        let separatorLine = UIView()
        separatorLine.backgroundColor = UIColor.separator
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        return separatorLine
    }()
    
    private lazy var choiceOneView = OptionView()
    private lazy var choiceTwoView = OptionView()
    private lazy var choiceThreeView = OptionView()
    
    private lazy var valueTextField: UITextField = {
        
        let titleLabel = UITextField()
        titleLabel.text = ""
        titleLabel.textAlignment = .left
        titleLabel.keyboardType = .numberPad
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 16, weight: .regular)
        titleLabel.delegate = self
        titleLabel.backgroundColor = .clear
        titleLabel.textRect(forBounds: titleLabel.bounds).inset(by: .init(top: 0, left: 0, bottom: 10, right: 0))
        return titleLabel
    }()
    
    private var radio = UIImage.init(named: "Image-1")?.withRenderingMode(.alwaysTemplate)
    private var intialimg = UIImage.init(named: "radio")?.withRenderingMode(.alwaysTemplate)
    
    var selectedValue:ColumnWidthValue = .actual
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
    
    func configue(model:ColumnWidthSelectorCellModel){
        self.selectedValue = model.selectedValue
        self.title.text = model.title
        
        switch selectedValue {
       
        case .actual:
            choiceOneSelected()
        case .content:
            choiceTwoSelected()
        case .scaling(let value):
            choiceThreeSelected()
            self.valueTextField.text = value
        }
    }
    
    private func setUpViews(){
        self.contentView.addSubview(verticalStackView)
    
        verticalStackView.addArrangedSubview(title)
        verticalStackView.addArrangedSubview(choiceOneView)
        verticalStackView.addArrangedSubview(choiceTwoView)
        verticalStackView.addArrangedSubview(choiceThreeView)
    
        choiceOneView.title.text = "Actual"
        choiceTwoView.title.text = "Content Based"
        choiceThreeView.title.text = "Scaling"
        
        if UIDevice.current.userInterfaceIdiom == .pad {
    
            title.heightAnchor.constraint(equalToConstant: 0).isActive = true
        }
    
        NSLayoutConstraint.activate([verticalStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 19),
                                     verticalStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 19),
                                     verticalStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -19),
                                     verticalStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: 0),
                                     choiceOneView.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor)
        ])
    
        choiceOneView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonTapped(_:))))
        choiceTwoView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonTapped(_:))))
        choiceThreeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonTapped(_:))))
        
    }
    
    @objc func buttonTapped(_ sender:UITapGestureRecognizer){
    
    
        if sender == choiceOneView.gestureRecognizers?[0]{

            updateValue(.actual)
    
        }else if sender == choiceTwoView.gestureRecognizers?[0] {

            updateValue(.content)
        }else{

            updateValue(.scaling("0"))
        }
        reloadUiForScaling()
        
    }
    
    private func choiceOneSelected(){
        choiceOneView.selectButton.image = radio
        choiceTwoView.selectButton.image = intialimg
        choiceThreeView.selectButton.image = intialimg
    
        choiceTwoView.selectButton.tintColor = .lightGray
        choiceThreeView.selectButton.tintColor = .lightGray
        choiceOneView.selectButton.tintColor = .blue
    
        updateValue(.actual)
        self.valueTextField.removeFromSuperview()
    //        delegate?.updateOptionSelectorViewValue(configure: configure, value: choiceOneView.title.text ?? "", selected: .choiceOne)
//        onUpdateValue()
    }
    private func choiceTwoSelected(){
        choiceOneView.selectButton.image = intialimg
        choiceTwoView.selectButton.image = radio
        choiceThreeView.selectButton.image = intialimg
        
        choiceOneView.selectButton.tintColor = .lightGray
        choiceTwoView.selectButton.tintColor = .blue
        choiceThreeView.selectButton.tintColor = .lightGray
    //        delegate?.updateOptionSelectorViewValue(configure: configure, value: choiceTwoView.title.text ?? "", selected: .choiceTwo)
//        onUpdateValue(choiceTwoView.title.text ?? "",.choiceTwo)
        updateValue(.content)
        
        self.valueTextField.removeFromSuperview()
    }
    
    private func choiceThreeSelected(){
        choiceOneView.selectButton.image = intialimg
        choiceTwoView.selectButton.image = intialimg
        choiceThreeView.selectButton.image = radio
        
        choiceOneView.selectButton.tintColor = .lightGray
        choiceTwoView.selectButton.tintColor = .lightGray
        choiceThreeView.selectButton.tintColor = .blue
    //        delegate?.updateOptionSelectorViewValue(configure: configure, value: choiceTwoView.title.text ?? "", selected: .choiceTwo)
//        onUpdateValue(choiceTwoView.title.text ?? "",.choiceTwo)
        
        self.verticalStackView.addArrangedSubview(self.valueTextField)
        self.verticalStackView.addArrangedSubview(self.separatorLine)
        
        valueTextField.topAnchor.constraint(equalTo: choiceThreeView.bottomAnchor, constant: 5).isActive = true
        valueTextField.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor, constant: 41).isActive = true
        valueTextField.trailingAnchor.constraint(equalTo: verticalStackView.trailingAnchor, constant:-60).isActive = true
        valueTextField.bottomAnchor.constraint(equalTo: verticalStackView.bottomAnchor, constant: 0).isActive = true

        separatorLine.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor, constant: 41).isActive = true
        separatorLine.trailingAnchor.constraint(equalTo: verticalStackView.trailingAnchor, constant:-60).isActive = true
        separatorLine.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        
        
        DispatchQueue.main.async {
            self.valueTextField.becomeFirstResponder()
        }
        
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
//            self.delegate?.valueUpdate(value:self.valueTextField.text ?? "")
        updateValue(.scaling(textField.text ?? "0"))
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}

//var onUpdateValue:(String,ChoiceSelected) -> Void = {_,_ in }
//
//var configure:Configure = .orientation
////    weak var delegate: PrintOptionSelectorViewCellDelegate?
//var selectedChoice:ChoiceSelected = .choiceOne
//
//lazy var verticalStackView:UIStackView = {
//    let vStack = UIStackView()
//    vStack.translatesAutoresizingMaskIntoConstraints = false
//    vStack.axis = .vertical
//    vStack.alignment = .fill
//    vStack.distribution = .equalSpacing
//    vStack.spacing = 10
//    return vStack
//
//}()
//
//lazy var title: UILabel = {
//
//    let titleLabel = UILabel()
//    titleLabel.text = "Size"
//    titleLabel.textAlignment = .left
//    titleLabel.translatesAutoresizingMaskIntoConstraints = false
//    titleLabel.font = .systemFont(ofSize: 17, weight: .bold)
//    titleLabel.backgroundColor = .clear
//    return titleLabel
//}()
//
//
//lazy var choiceOneView = OptionView()
//lazy var choiceTwoView = OptionView()
//
//private var radio = UIImage.init(named: "Image-1")?.withRenderingMode(.alwaysTemplate)
//private var intialimg = UIImage.init(named: "radio")?.withRenderingMode(.alwaysTemplate)
//
//init() {
//
//    super.init(frame: .zero)
//
//    setUpViews()
//
//}
//
//private func setUpViews(){
//    self.addSubview(verticalStackView)
//
//    verticalStackView.addArrangedSubview(title)
//    verticalStackView.addArrangedSubview(choiceOneView)
//    verticalStackView.addArrangedSubview(choiceTwoView)
//
//
//    if UIDevice.current.userInterfaceIdiom == .pad {
//
//        title.heightAnchor.constraint(equalToConstant: 0).isActive = true
//    }
//
//    NSLayoutConstraint.activate([verticalStackView.topAnchor.constraint(equalTo: self.topAnchor,constant: 0),
//                                 verticalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 0),
//                                 verticalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: 0),
//                                 verticalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: 0)
//    ])
//
//    choiceOneView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonTapped(_:))))
//    choiceTwoView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonTapped(_:))))
//}
//
//func changeSelectionAsPerChoice(){
//    if selectedChoice == .choiceOne{
//        choiceOneSelected()
//    }else{
//        choiceTwoSelected()
//    }
//}
//
//@objc func buttonTapped(_ sender:UITapGestureRecognizer){
//
//
//    if sender == choiceOneView.gestureRecognizers?[0]{
//        choiceOneSelected()
//        selectedChoice = .choiceOne
//
//    }else{
//        choiceTwoSelected()
//        selectedChoice = .choiceTwo
//    }
//
//}
//
//private func choiceOneSelected(){
//    choiceOneView.selectButton.image = radio
//    choiceTwoView.selectButton.image = intialimg
//
//    choiceTwoView.selectButton.tintColor = .lightGray
//    choiceOneView.selectButton.tintColor = .blue
//
////        delegate?.updateOptionSelectorViewValue(configure: configure, value: choiceOneView.title.text ?? "", selected: .choiceOne)
//    onUpdateValue(choiceOneView.title.text ?? "",.choiceOne)
//}
//private func choiceTwoSelected(){
//    choiceOneView.selectButton.image = intialimg
//    choiceTwoView.selectButton.image = radio
//
//    choiceOneView.selectButton.tintColor = .lightGray
//    choiceTwoView.selectButton.tintColor = .blue
////        delegate?.updateOptionSelectorViewValue(configure: configure, value: choiceTwoView.title.text ?? "", selected: .choiceTwo)
//    onUpdateValue(choiceTwoView.title.text ?? "",.choiceTwo)
//}
//
//required init?(coder: NSCoder) {
//    fatalError("init(coder:) has not been implemented")
//}
//
//}
