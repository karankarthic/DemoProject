//
//  PrintOptionSelectorViewCell.swift
//  DemoProject
//
//  Created by Karan Karthic Neelamegan on 08/04/21.
//

import UIKit

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
