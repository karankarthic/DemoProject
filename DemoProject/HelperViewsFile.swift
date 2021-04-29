//
//  CellViewsFileOne.swift
//  DemoProject
//
//  Created by Karan Karthic Neelamegan on 20/03/21.
//

import UIKit


class PickerOptionView: UIView {
    
    lazy var secondaryVerticalStackView:UIStackView = {
        let vStack = UIStackView()
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.alignment = .fill
        vStack.distribution = .equalSpacing
        vStack.spacing = 7
        return vStack
        
    }()
    
    lazy var title: UILabel = {
        
        let titleLabel = UILabel()
        titleLabel.text = "Size"
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 17, weight: .bold)
        titleLabel.backgroundColor = .clear
        return titleLabel
    }()
    lazy var valueTextField: UITextField = {
        
        let titleLabel = UITextField()
        titleLabel.text = "A4"
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 16, weight: .regular)
        titleLabel.backgroundColor = .clear
        titleLabel.tintColor = .clear
        titleLabel.rightViewMode = .always
        titleLabel.rightView = iconView1
//        titleLabel.inputView = subValueOnePicker
        
        titleLabel.selectedTextRange = nil
        return titleLabel
    }()
    

    lazy var iconView1 : UIImageView = {
        var iconView = UIImageView(image: UIImage(named: "angel"))
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.sizeToFit()
        iconView.clipsToBounds = true
        iconView.layer.masksToBounds = true
        iconView.widthAnchor.constraint(equalToConstant: 27).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 27).isActive = true
     return iconView
    }()
    
    
    init() {
        super.init(frame: .zero)
        self.addSubview(secondaryVerticalStackView)
        secondaryVerticalStackView.addArrangedSubview(title)
        secondaryVerticalStackView.addArrangedSubview(valueTextField)
        
        NSLayoutConstraint.activate([secondaryVerticalStackView.topAnchor.constraint(equalTo: self.topAnchor),
                                     secondaryVerticalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                                     secondaryVerticalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                                     secondaryVerticalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        
        ])
        
//        if UIDevice.current.userInterfaceIdiom == .phone {
            valueTextField.bottomAnchor.constraint(equalTo:self.bottomAnchor,constant: -10 ).isActive = true
//        }
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}






class OptionView: UIView {
    
    enum ButtonType {
        case check
        case radio
    }
   
    
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
        titleLabel.text = "choice"
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 16, weight: .regular)
        titleLabel.backgroundColor = .clear
        return titleLabel
    }()
    
    
    init() {
        
        super.init(frame: .zero)
        
        self.addSubview(horizontalStackView)
        
        horizontalStackView.addArrangedSubview(selectButton)
        horizontalStackView.addArrangedSubview(title)
        
        NSLayoutConstraint.activate([horizontalStackView.topAnchor.constraint(equalTo: self.topAnchor),
                                     horizontalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                                     horizontalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                                     horizontalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
                                     
        
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

enum Configure{
    case orientation
    case columnWidth
}

//protocol PrintOptionSelectorViewCellDelegate:class {
//
//    func updateOptionSelectorViewValue(configure:Configure,value:String,selected:ChoiceSelected)
//
//}
enum ChoiceSelected{
    case choiceOne
    case choiceTwo
}

class OptionSelectorRadioButtonView : UIView {
    
    var onUpdateValue:(String,ChoiceSelected) -> Void = {_,_ in }
    
    var configure:Configure = .orientation
//    weak var delegate: PrintOptionSelectorViewCellDelegate?
    var selectedChoice:ChoiceSelected = .choiceOne
    
    lazy var verticalStackView:UIStackView = {
        let vStack = UIStackView()
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.alignment = .fill
        vStack.distribution = .equalSpacing
        vStack.spacing = 10
        return vStack
        
    }()
    
    lazy var title: UILabel = {
        
        let titleLabel = UILabel()
        titleLabel.text = "Size"
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 17, weight: .bold)
        titleLabel.backgroundColor = .clear
        return titleLabel
    }()
    
    
    lazy var choiceOneView = OptionView()
    lazy var choiceTwoView = OptionView()
    
    private var radio = UIImage.init(named: "Image-1")?.withRenderingMode(.alwaysTemplate)
    private var intialimg = UIImage.init(named: "radio")?.withRenderingMode(.alwaysTemplate)
    
    init() {
        
        super.init(frame: .zero)
        
        setUpViews()
         
    }
    
    private func setUpViews(){
        self.addSubview(verticalStackView)
        
        verticalStackView.addArrangedSubview(title)
        verticalStackView.addArrangedSubview(choiceOneView)
        verticalStackView.addArrangedSubview(choiceTwoView)
        
        
//        if UIDevice.current.userInterfaceIdiom == .pad {
//
//            title.heightAnchor.constraint(equalToConstant: 0).isActive = true
//        }
        
        NSLayoutConstraint.activate([verticalStackView.topAnchor.constraint(equalTo: self.topAnchor,constant: 0),
                                     verticalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 0),
                                     verticalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: 0),
                                     verticalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: 0)
        ])
        
        choiceOneView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonTapped(_:))))
        choiceTwoView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonTapped(_:))))
    }
    
    func changeSelectionAsPerChoice(){
        if selectedChoice == .choiceOne{
            choiceOneSelected()
        }else{
            choiceTwoSelected()
        }
    }
    
    @objc func buttonTapped(_ sender:UITapGestureRecognizer){
        
        
        if sender == choiceOneView.gestureRecognizers?[0]{
            choiceOneSelected()
            selectedChoice = .choiceOne
            
        }else{
            choiceTwoSelected()
            selectedChoice = .choiceTwo
        }
        
    }
    
    private func choiceOneSelected(){
        choiceOneView.selectButton.image = radio
        choiceTwoView.selectButton.image = intialimg
        
        choiceTwoView.selectButton.tintColor = .lightGray
        choiceOneView.selectButton.tintColor = .blue
        
//        delegate?.updateOptionSelectorViewValue(configure: configure, value: choiceOneView.title.text ?? "", selected: .choiceOne)
        onUpdateValue(choiceOneView.title.text ?? "",.choiceOne)
    }
    private func choiceTwoSelected(){
        choiceOneView.selectButton.image = intialimg
        choiceTwoView.selectButton.image = radio
        
        choiceOneView.selectButton.tintColor = .lightGray
        choiceTwoView.selectButton.tintColor = .blue
//        delegate?.updateOptionSelectorViewValue(configure: configure, value: choiceTwoView.title.text ?? "", selected: .choiceTwo)
        onUpdateValue(choiceTwoView.title.text ?? "",.choiceTwo)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


class MargingInnerView:UIView {
    
    private lazy var horizontalStackView:UIStackView = {
        let vStack = UIStackView()
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .horizontal
        vStack.alignment = .leading
        vStack.distribution = .fillProportionally
        vStack.spacing = 15
        return vStack
    }()
    
    private lazy var verticalStackView:UIStackView = {
        let vStack = UIStackView()
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.alignment = .fill
        vStack.distribution = .equalSpacing
        vStack.spacing = 0
        return vStack
        
    }()
    
    lazy var top: UILabel = {
        
        let titleLabel = UILabel()
        titleLabel.text = "T"
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 13, weight: .light)
        titleLabel.backgroundColor = .clear
        return titleLabel
    }()
    lazy var bttom: UILabel = {
        
        let titleLabel = UILabel()
        titleLabel.text = "B"
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 13, weight: .light)
        titleLabel.backgroundColor = .clear
        return titleLabel
    }()
    lazy var right: UILabel = {
        
        let titleLabel = UILabel()
        titleLabel.text = "R"
        titleLabel.textAlignment = .right
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 13, weight: .light)
        titleLabel.backgroundColor = .clear
        return titleLabel
    }()
    lazy var left: UILabel = {
        
        let titleLabel = UILabel()
        titleLabel.text = "L"
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 13, weight: .light)
        titleLabel.backgroundColor = .clear
        return titleLabel
    }()
    
    init() {
        super.init(frame: .zero)
        
        self.addSubview(verticalStackView)
        
        verticalStackView.addArrangedSubview(top)
        
        verticalStackView.addArrangedSubview(horizontalStackView)
        
        horizontalStackView.addArrangedSubview(left)
        horizontalStackView.addArrangedSubview(right)
        
        verticalStackView.addArrangedSubview(bttom)
        
        NSLayoutConstraint.activate([verticalStackView.topAnchor.constraint(equalTo: self.topAnchor,constant: 5),
                                     verticalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 5),
                                     verticalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -5),
                                     verticalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -5),
                                     
                                     verticalStackView.heightAnchor.constraint(equalToConstant: 85),
                                     verticalStackView.widthAnchor.constraint(equalToConstant: 85)
                                     
        ])
        
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.separator.cgColor
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class SingleLableView : UIView {
    
    lazy var titleLabel: UILabel = {
        
        let titleLabel = UILabel()
        titleLabel.text = "xcxcxcvx"
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        titleLabel.textColor = .blue
        titleLabel.backgroundColor = .clear
        return titleLabel
    }()
    
    init(){
        super.init(frame: .zero)
        self.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
        
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 19),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 19),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -19),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -19)
            ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}




struct ExportAPIModel: Codable {
    
    var fileName: String = ""
    var exportType: String = ""
    var filterType: Int = 1      // to be modified after new ui
    var selectedColumns: [String]? = nil
    var isPasswordProtected: Bool = false
    var password: String? = nil
    var confirmPassword: String? = nil
    var deviceType: Int = 2
    
    var pdfDisplayType: Int? = nil
    var paperSize: String? = nil
    var orientation: String? = nil
    var scalingType: Int? = nil // to be modified after new ui
    var scalingValue: Int? = nil // to be modified after new ui
    var headerContent: [PositionAPIModel]? = nil // to be modified after new ui
    var footerContent: [PositionAPIModel]? = nil // to be modified after new ui
    var margin: Margin? = nil
    
    init(model: ExportViewModel) {
        
        switch model.fileType {
       
        case .PDF:
            self.exportType = "pdf"
            self.pdfDisplayType = model.viewType
            self.paperSize = model.pageSettings.pageSize
            self.orientation = model.pageSettings.pageOrientation
            self.margin = model.pageSettings.margin
            
            
        case .Xls:
            self.exportType = "xls"
        case .Csv:
            self.exportType = "csv"
        case .Json:
            self.exportType = "json"
        case .Tsv:
            self.exportType = "tsv"
        }
        
        self.fileName = model.fileName
        
        if model.selecteColumns.isEmpty{
            self.filterType = model.viewType
            
        }else{
            self.filterType = 4
            self.selectedColumns = model.selecteColumns
        }
        
        if model.passwordSetting.password != nil{
            isPasswordProtected = true
            password = model.passwordSetting.password
            confirmPassword = model.passwordSetting.conforimPassword
        }
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.deviceType = 2
        }else{
            self.deviceType = 3
        }
        
    }
    
    
  
}

struct PositionAPIModel: Codable {
    let position, type, value: String
}
