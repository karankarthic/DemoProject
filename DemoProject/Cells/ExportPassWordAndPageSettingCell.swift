//
//  ExportPassWordAndPageSettingCell.swift
//  DemoProject
//
//  Created by Karan Karthic Neelamegan on 08/04/21.
//

import UIKit


enum ExportSettingType{
    
    case page
    case password
    case more
}



//protocol ExportPassWordAndPageSettingCellDelegate:class {
//    func pushToRespectiveVC(type:ExportSettingType)
//}

class ExportPassWordAndPageSettingCell :UITableViewCell {
    
//    weak var delegate:ExportPassWordAndPageSettingCellDelegate?
    
    var pushToPageVc:() -> Void = {}
    var pushToPasswordVc:() -> Void = {}
    
    private lazy var verticalStackView:UIStackView = {
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

    private lazy var pageSetting = SingleLableView()
    
    private lazy var passwordSetting = SingleLableView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    private func setupView(){
        
        
        self.contentView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(pageSetting)
        verticalStackView.addArrangedSubview(separatorLine)
        verticalStackView.addArrangedSubview(passwordSetting)
        
        
        NSLayoutConstraint.activate([verticalStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 0),
                                     verticalStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 0),
                                     verticalStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: 0),
                                     verticalStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: 0),
                                     
                                     separatorLine.heightAnchor.constraint(equalToConstant: 1)
                        
        
        ])
        
        pageSetting.titleLabel.text = "Page Setting"
        passwordSetting.titleLabel.text = "Password Setting"
        
        pageSetting.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped)))
        passwordSetting.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped)))
    }
    
    @objc private func viewTapped(_ sender:UITapGestureRecognizer){
        
        if pageSetting.gestureRecognizers?[0] == sender{
            
//            delegate?.pushToRespectiveVC(type: .page)
            pushToPageVc()
            
        }else{
            
//            delegate?.pushToRespectiveVC(type: .password)
            pushToPasswordVc()
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
