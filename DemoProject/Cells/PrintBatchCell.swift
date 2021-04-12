//
//  PrintBatchCell.swift
//  DemoProject
//
//  Created by Karan Karthic Neelamegan on 08/04/21.
//

import UIKit

struct PrintBatchCellModel{
    let title:String
    let subTitle:String
}

class PrintBatchCell:UITableViewCell {
    
    private lazy var horizontalStackView:UIStackView = {
        let vStack = UIStackView()
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .horizontal
        vStack.alignment = .center
        vStack.distribution = .fillProportionally
        vStack.spacing = 10
        return vStack
    }()
    
    private lazy var titleLabel: UILabel = {
        
        let titleLabel = UILabel()
        titleLabel.text = ""
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 15, weight: .bold)
        titleLabel.backgroundColor = .clear
        return titleLabel
    }()
    
    private lazy var subTitleLabel: UILabel = {
        
        let titleLabel = UILabel()
        titleLabel.text = ""
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 15, weight: .light)
        titleLabel.backgroundColor = .clear
        return titleLabel
    }()
    private lazy var verticalStackView:UIStackView = {
        let vStack = UIStackView()
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.alignment = .leading
        vStack.distribution = .equalSpacing
        vStack.spacing = 7
        return vStack
        
    }()
    
    private lazy var iconView1 : UIImageView = {
        var iconView = UIImageView(image: UIImage(named: "angel"))
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.sizeToFit()
        iconView.clipsToBounds = true
        iconView.layer.masksToBounds = true
        iconView.widthAnchor.constraint(equalToConstant: 27).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 27).isActive = true
     return iconView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupCellView()
        
    }
    
    func configure(model:PrintBatchCellModel){
        titleLabel.text = model.title
        subTitleLabel.text = model.subTitle
    }
    
    private func setupCellView(){
        
        self.contentView.addSubview(horizontalStackView)
        
        horizontalStackView.addArrangedSubview(verticalStackView)
        
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(subTitleLabel)
        
        horizontalStackView.addArrangedSubview(iconView1)
        
        
        
        NSLayoutConstraint.activate([
        
            horizontalStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 19),
            horizontalStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 19),
            horizontalStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -19),
            horizontalStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -19),

                                        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
