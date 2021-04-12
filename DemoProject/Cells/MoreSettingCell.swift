//
//  MoreSettingCell.swift
//  DemoProject
//
//  Created by Karan Karthic Neelamegan on 08/04/21.
//

import UIKit

class MoreSettingCell :UITableViewCell {
    
//    weak var delegate:ExportPassWordAndPageSettingCellDelegate?
    
    var pushToMoreVc:() -> Void = {}
    
    private lazy var moreSetting = SingleLableView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        moreSetting.translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    private func setupView(){

        self.contentView.addSubview(moreSetting)

        NSLayoutConstraint.activate([moreSetting.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 0),
                                     moreSetting.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 0),
                                     moreSetting.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: 0),
                                     moreSetting.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: 0),
        
        ])
        
        moreSetting.titleLabel.text = "More Setting"
        moreSetting.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped)))

    }
    
    @objc private func viewTapped(_ sender:UITapGestureRecognizer){
        
       
        pushToMoreVc()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
