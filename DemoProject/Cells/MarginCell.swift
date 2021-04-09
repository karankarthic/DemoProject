//
//  MarginCell.swift
//  DemoProject
//
//  Created by Karan Karthic Neelamegan on 08/04/21.
//

import UIKit

protocol MarginCellDelegate:class {
    func updateMargingcell(margin:Margin)
}



class MarginCell : UITableViewCell, UITextFieldDelegate {
    
    weak var delegate:MarginCellDelegate?
    
    lazy var titleLabel: UILabel = {
        
        let titleLabel = UILabel()
        titleLabel.text = "Margin"
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 15, weight: .bold)
        titleLabel.backgroundColor = .clear
        return titleLabel
    }()
    
    lazy var subTitleLabel: UILabel = {
        
        let titleLabel = UILabel()
        titleLabel.text = "All values are in mm"
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 15, weight: .light)
        titleLabel.backgroundColor = .clear
        return titleLabel
    }()
    lazy var verticalStackView:UIStackView = {
        let vStack = UIStackView()
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.alignment = .leading
        vStack.distribution = .equalSpacing
        return vStack
        
    }()
    
    private lazy var innerVerticalStackView:UIStackView = {
        let vStack = UIStackView()
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.alignment = .fill
        vStack.distribution = .equalSpacing
        vStack.spacing = 2
        return vStack
        
    }()
    
    private lazy var secInnerVerticalStackView:UIStackView = {
        let vStack = UIStackView()
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.alignment = .center
        vStack.distribution = .equalSpacing
        vStack.spacing = 10
        return vStack
        
    }()
    
    private lazy var separatorLine: UIView = {
        let separatorLine = UIView()
        separatorLine.backgroundColor = UIColor.separator
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        return separatorLine
    }()
    
    private lazy var horizontalStackView:UIStackView = {
        let vStack = UIStackView()
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .horizontal
        vStack.alignment = .center
        vStack.distribution = .fillProportionally
        vStack.spacing = 10
        return vStack
    }()
    
    lazy var topTextField: UITextField = {
        
        let topTextField = UITextField()
        topTextField.textAlignment = .center
        topTextField.translatesAutoresizingMaskIntoConstraints = false
        topTextField.font = .systemFont(ofSize: 13, weight: .regular)
        topTextField.backgroundColor = .clear
        topTextField.keyboardType = .numberPad
        topTextField.layer.cornerRadius = 3
        topTextField.layer.borderWidth = 1
        topTextField.delegate = self
        topTextField.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        return topTextField
    }()
    
    lazy var rightTextField: UITextField = {
        
        let rightTextField = UITextField()
        rightTextField.textAlignment = .center
        rightTextField.translatesAutoresizingMaskIntoConstraints = false
        rightTextField.font = .systemFont(ofSize: 13, weight: .regular)
        rightTextField.backgroundColor = .clear
        rightTextField.keyboardType = .numberPad
        rightTextField.layer.cornerRadius = 3
        rightTextField.layer.borderWidth = 1
        rightTextField.delegate = self
        rightTextField.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        return rightTextField
    }()
    
    lazy var leftTextField: UITextField = {
        
        let leftTextField = UITextField()
        leftTextField.textAlignment = .center
        leftTextField.translatesAutoresizingMaskIntoConstraints = false
        leftTextField.font = .systemFont(ofSize: 13, weight: .regular)
        leftTextField.backgroundColor = .clear
        leftTextField.keyboardType = .numberPad
        leftTextField.layer.cornerRadius = 3
        leftTextField.layer.borderWidth = 1
        leftTextField.delegate = self
        leftTextField.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        return leftTextField
    }()
    
    lazy var bottomTextField: UITextField = {
        
        let bottomTextField = UITextField()
        bottomTextField.textAlignment = .center
        bottomTextField.translatesAutoresizingMaskIntoConstraints = false
        bottomTextField.font = .systemFont(ofSize: 13, weight: .regular)
        bottomTextField.backgroundColor = .clear
        bottomTextField.keyboardType = .numberPad
        bottomTextField.layer.cornerRadius = 3
        bottomTextField.layer.borderWidth = 1
        bottomTextField.delegate = self
        bottomTextField.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        return bottomTextField
    }()
    
    private lazy var marginInnerView = MargingInnerView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupCellView()
        
    }
    
    private func setupCellView(){
        
        self.contentView.addSubview(verticalStackView)
        
        verticalStackView.addArrangedSubview(innerVerticalStackView)
        
        innerVerticalStackView.addArrangedSubview(titleLabel)
        innerVerticalStackView.addArrangedSubview(subTitleLabel)
        
        verticalStackView.addArrangedSubview(separatorLine)
        
        verticalStackView.addArrangedSubview(secInnerVerticalStackView)
        
        secInnerVerticalStackView.addArrangedSubview(topTextField)
        
        secInnerVerticalStackView.addArrangedSubview(horizontalStackView)
        
        horizontalStackView.addArrangedSubview(leftTextField)
        horizontalStackView.addArrangedSubview(marginInnerView)
        horizontalStackView.addArrangedSubview(rightTextField)
        
        secInnerVerticalStackView.addArrangedSubview(bottomTextField)
        

        
        if UIDevice.current.userInterfaceIdiom == .pad {
            innerVerticalStackView.heightAnchor.constraint(equalToConstant: 0).isActive = true
            separatorLine.heightAnchor.constraint(equalToConstant: 0).isActive = true
            separatorLine.topAnchor.constraint(equalTo: self.innerVerticalStackView.bottomAnchor,constant: 10).isActive = true
        }else{
            NSLayoutConstraint.activate([
            
                titleLabel.leadingAnchor.constraint(equalTo: self.innerVerticalStackView.leadingAnchor,constant: 19),
                titleLabel.topAnchor.constraint(equalTo: self.innerVerticalStackView.topAnchor,constant: 20),
                subTitleLabel.leadingAnchor.constraint(equalTo: self.innerVerticalStackView.leadingAnchor,constant: 19),
                
                separatorLine.topAnchor.constraint(equalTo: self.innerVerticalStackView.bottomAnchor,constant: 20),
                separatorLine.leadingAnchor.constraint(equalTo: self.verticalStackView.leadingAnchor),
                separatorLine.trailingAnchor.constraint(equalTo: self.verticalStackView.trailingAnchor),
                separatorLine.heightAnchor.constraint(equalToConstant: 0.5),
            
            ])
        }
        
        
        NSLayoutConstraint.activate([
        
            verticalStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -19),
            verticalStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),

            secInnerVerticalStackView.topAnchor.constraint(equalTo: self.separatorLine.bottomAnchor,constant: 20),
            secInnerVerticalStackView.leadingAnchor.constraint(equalTo: self.verticalStackView.leadingAnchor,constant: 19),
            secInnerVerticalStackView.bottomAnchor.constraint(equalTo: self.verticalStackView.bottomAnchor),
            secInnerVerticalStackView.trailingAnchor.constraint(equalTo: self.verticalStackView.trailingAnchor,constant: -19),
            
            topTextField.heightAnchor.constraint(equalToConstant: 25),
            topTextField.widthAnchor.constraint(equalToConstant: 50),
            
            bottomTextField.heightAnchor.constraint(equalToConstant: 25),
            bottomTextField.widthAnchor.constraint(equalToConstant: 50),
            
            rightTextField.heightAnchor.constraint(equalToConstant: 25),
            rightTextField.widthAnchor.constraint(equalToConstant: 50),
            
            leftTextField.heightAnchor.constraint(equalToConstant: 25),
            leftTextField.widthAnchor.constraint(equalToConstant: 50)
            
            ])
        
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        var top:Int = Int(topTextField.text ?? "") ?? 10
        var left:Int = Int(leftTextField.text ?? "") ?? 10
        var right:Int = Int(rightTextField.text ?? "") ?? 10
        var bottom:Int = Int(bottomTextField.text ?? "") ?? 10
        
        if textField == topTextField{
            top = Int(textField.text ?? "") ?? 10
        }
        if textField == leftTextField{
            left = Int(textField.text ?? "") ?? 10
        }
        if textField == rightTextField{
            right = Int(textField.text ?? "") ?? 10
        }
        if textField == bottomTextField{
            bottom = Int(textField.text ?? "") ?? 10
        }
        
        delegate?.updateMargingcell(margin: .init(top: top, left: left, right: right, bottom: bottom))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
