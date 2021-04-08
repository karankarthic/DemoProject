//
//  SelectCell.swift
//  DemoProject
//
//  Created by Karan Karthic Neelamegan on 08/04/21.
//

import UIKit


enum TitleValueState {
    case on
    case off
}

enum SelectCellType {
    case normal
    case title
}

struct SelectCellModel{
    
    var title:String
    var cellType:SelectCellType
    var buttonType:OptionView.ButtonType
    var choiceTitleEnabled : TitleValueState = .off
    var isSelected:Bool = false
}

protocol SelectCellDelegate:class{
    func valueUpdate(value:String)
}



class SelectCell : UITableViewCell, UITextFieldDelegate {
    
    lazy var choiceView = OptionView()
    
    lazy var valueTextField: UITextField = {
        
        let titleLabel = UITextField()
        titleLabel.text = ""
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 16, weight: .regular)
        titleLabel.delegate = self
        titleLabel.backgroundColor = .clear
        return titleLabel
    }()
    
    lazy var verticalStackView:UIStackView = {
        let vStack = UIStackView()
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.alignment = .fill
        vStack.distribution = .equalSpacing
        vStack.spacing = 2
        return vStack
        
    }()
    
    private lazy var separatorLine: UIView = {
        let separatorLine = UIView()
        separatorLine.backgroundColor = UIColor.separator
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        return separatorLine
    }()
    
    private var model: SelectCellModel? = nil
    
    weak var delegate:SelectCellDelegate?
    
    private var intialimg = UIImage.init(named: "radio")?.withRenderingMode(.alwaysTemplate)
    private var radio = UIImage.init(named: "Image-1")?.withRenderingMode(.alwaysTemplate)// radio
    private var check = UIImage.init(named: "Image-1")?.withRenderingMode(.alwaysTemplate)// rounded Check
    private var ipadCheck = UIImage.init(named: "Image-1")?.withRenderingMode(.alwaysTemplate)// plain Check
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        self.separatorInset = .init(top: 0, left: 54, bottom: 0, right: 0)
    }
    
    func setupView(cellModel:SelectCellModel){
        
        self.model = cellModel
        self.contentView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(choiceView)
        
        
        NSLayoutConstraint.activate([verticalStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 18),
                                     verticalStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 15),
                                     verticalStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -15),
                                     verticalStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -15),
                                     choiceView.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor)
        
        ])
        
        choiceView.buttonType = model?.buttonType ?? .radio
        
        if model?.choiceTitleEnabled == .on{
            
            self.verticalStackView.addArrangedSubview(self.valueTextField)
            
            valueTextField.topAnchor.constraint(equalTo: choiceView.bottomAnchor, constant: 0).isActive = true
            valueTextField.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor, constant: 39).isActive = true
            valueTextField.bottomAnchor.constraint(equalTo: verticalStackView.bottomAnchor, constant: -15).isActive = true
            DispatchQueue.main.async {
                self.valueTextField.becomeFirstResponder()
            }
            
        }else{
            self.valueTextField.removeFromSuperview()
        }
        
        choiceView.title.text = model?.title
        
        buttonTapped()
    }
    
     func buttonTapped(){
        
            if choiceView.buttonType == .radio{
            
                if model?.isSelected == true{
                    choiceView.selectButton.image = radio
                    choiceView.selectButton.tintColor = .blue
                }else{
                    choiceView.selectButton.image = intialimg
                    choiceView.selectButton.tintColor = .lightGray
                }
            
            }
            else{
                if model?.isSelected == true{
//                    if ipad {
//                      choiceView.selectButton.image = ipadCheck
//                    }else{
                        choiceView.selectButton.image = check
//                    }
                    choiceView.selectButton.tintColor = .blue
                    
                }else{
                    choiceView.selectButton.image = intialimg
//                    if ipad {
//                      choiceView.selectButton.tintColor = .white
//                    }else{
                        choiceView.selectButton.tintColor = .lightGray
//                    }
                }
            }
        
        if model?.cellType == .normal && choiceView.buttonType == .radio && model?.isSelected == true {
            delegate?.valueUpdate(value:choiceView.title.text ?? "")
        }
      
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.delegate?.valueUpdate(value:self.valueTextField.text ?? "")
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
