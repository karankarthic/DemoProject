//
//  PrintOptionSelectorViewCell.swift
//  DemoProject
//
//  Created by Karan Karthic Neelamegan on 08/04/21.
//

import UIKit

struct PrintOptionSelectorViewCellModel{
    let optionViewTitle:String
    var optionViewConfigure :Configure
    let optionViewSelectedChoice:ChoiceSelected
    let optionViewChoiceOneViewTitle:String
    let optionViewChoiceTwoViewTitle:String
    
}


class PrintOptionSelectorViewCell: UITableViewCell{
    
    
    lazy var optionView : OptionSelectorRadioButtonView = {
        
        var optionView = OptionSelectorRadioButtonView()
        optionView.translatesAutoresizingMaskIntoConstraints = false
        return optionView
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupCellView()
    }
    
    func configure(model:PrintOptionSelectorViewCellModel){
        
        optionView.title.text = model.optionViewTitle
        optionView.configure = model.optionViewConfigure
        optionView.selectedChoice = model.optionViewSelectedChoice
        optionView.choiceOneView.title.text = model.optionViewChoiceOneViewTitle
        optionView.choiceTwoView.title.text = model.optionViewChoiceTwoViewTitle
        
    }
    
    private func setupCellView(){
        
        self.contentView.addSubview(optionView)
        
        NSLayoutConstraint.activate([optionView.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 19),
                                     optionView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 19),
                                     optionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -19),
                                     optionView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -10)
                                     
        ])
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
