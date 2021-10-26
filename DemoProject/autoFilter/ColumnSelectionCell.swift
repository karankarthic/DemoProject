//
//  ColumnSelectionCell.swift
//  Creator
//
//  Created by Karan Karthic Neelamegan on 22/07/21.
//  Copyright © 2021 Zoho. All rights reserved.
//

import UIKit

struct ColumnSelectionCellModel{
    let displayText:String
    var isSelected:Bool = false
    var isHiddenColumn:Bool = false
    var buttonType:SelectionButtonType = .radio
    let sholudHideSeperator:Bool
}

enum SelectionButtonType {
    case check
    case radio
    
    var imageForButton:UIImage? {
        switch self {
        
        case .check:
//            return SharedAssets.icInlineChoiceTick.templateImage
        return nil
        case .radio:
            return UIImage.init(named: "Image-1")?.withRenderingMode(.alwaysTemplate)
        }
    }
}

class ColumnSelectionCell: UITableViewCell {

    var model:ColumnSelectionCellModel? = nil
    
    lazy var horizontalStackView:UIStackView = {
        let vStack = UIStackView()
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .horizontal
        vStack.alignment = .leading
        vStack.distribution = .fillProportionally
        vStack.spacing = 15
        return vStack
    }()
    
    lazy var selectButton : UIImageView = {
        let selectButton = UIImageView()
        selectButton.translatesAutoresizingMaskIntoConstraints = false
        selectButton.layer.cornerRadius = 12
        selectButton.image = UIImage.init(named: "radio")?.withRenderingMode(.alwaysTemplate)
        selectButton.tintColor = .lightGray
        selectButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        selectButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        return selectButton
    }()
    
    lazy var title: UILabel = {
        
        let titleLabel = UILabel()
//        if self.isRightToLeft{
//            titleLabel.textAlignment = .right
//        }else{
//            titleLabel.textAlignment = .left
//        }
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 16, weight: .regular)
        titleLabel.backgroundColor = .clear
        return titleLabel
    }()
    
    private lazy var hiddenLable:UILabel = {
        var hiddenLable = UILabel()
//        if self.isRightToLeft{
//            hiddenLable.textAlignment = .left
//        }else{
//            hiddenLable.textAlignment = .right
//        }
        hiddenLable.translatesAutoresizingMaskIntoConstraints = false
//        hiddenLable.text = Strings.exportcolumnHidden
        hiddenLable.font = .systemFont(ofSize: 16, weight: .regular)
        hiddenLable.alpha = 0.6
        hiddenLable.backgroundColor = .clear
        return hiddenLable
    }()
    private lazy var separatorLine: UIView = {
        let separatorLine = UIView()
        separatorLine.backgroundColor = .separator
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        return separatorLine
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupView()
    }
    
    func configure(_ model:ColumnSelectionCellModel){
        
        self.model = model
        self.title.text = model.displayText
        
        self.hiddenLable.isHidden = !model.isHiddenColumn
        
        if model.isSelected{
            selectButton.image = model.buttonType.imageForButton
        }else{
            selectButton.image = UIImage.init(named: "radio")?.withRenderingMode(.alwaysTemplate)
        }
        
        toggleSelectButtonColor(model.isSelected)
        
        self.separatorLine.isHidden = model.sholudHideSeperator
       
        
    }
    
    override func tintColorDidChange() {
        super.tintColorDidChange()
        
        guard let selfModel = self.model else {
            return
        }
        
        toggleSelectButtonColor(selfModel.isSelected)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension ColumnSelectionCell{
    
    private func toggleSelectButtonColor(_ isSelected:Bool){
        if isSelected {
            selectButton.tintColor = self.tintColor
        }else{
            selectButton.tintColor = UIColor.black.withAlphaComponent(0.5)
        }
    }
    
    private func setupView() {



        self.contentView.addSubview(horizontalStackView)
        self.contentView.addSubview(hiddenLable)
        self.contentView.addSubview(separatorLine)

        horizontalStackView.addArrangedSubview(selectButton)
        horizontalStackView.addArrangedSubview(title)

        NSLayoutConstraint.activate([horizontalStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 18),
                                     horizontalStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 15),
                                     horizontalStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -15),
                                     horizontalStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -15),
                                     
                                     hiddenLable.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 17),
                                     hiddenLable.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15),
                                     hiddenLable.heightAnchor.constraint(equalToConstant: 19),
                                     
                                     separatorLine.heightAnchor.constraint(equalToConstant: 0.5),
                                     separatorLine.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
                                     separatorLine.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 54),
                                     separatorLine.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
                                     
                                    


        ])

    }
}
