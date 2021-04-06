//
//  cellViewsFileTwo.swift
//  DemoProject
//
//  Created by Karan Karthic Neelamegan on 22/03/21.
//

import UIKit

protocol ExportSettingsFileNameCellDelegate :class{
    func updateValue(fileName:String)
}


class ExportSettingsFileNameCell:UITableViewCell, UITextFieldDelegate {
    
    weak var delegate: ExportSettingsFileNameCellDelegate?
    
    lazy var fileNameView:PickerOptionView = {
        let fileName = PickerOptionView()
        fileName.translatesAutoresizingMaskIntoConstraints = false
        fileName.valueTextField.inputView = nil
        fileName.valueTextField.inputAccessoryView = nil
        fileName.valueTextField.rightViewMode = .never
        fileName.valueTextField.text = ""
        fileName.valueTextField.delegate = self
        fileName.valueTextField.tintColor = .black
        return fileName
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    func setupView(){
        self.contentView.addSubview(fileNameView)
        
        let topCons:CGFloat
        let bottomCons:CGFloat
        let leftCons:CGFloat
        let rightCons:CGFloat
        
        if UIDevice.current.userInterfaceIdiom == .phone {
             topCons = 19
             bottomCons = -20
             leftCons = 19
             rightCons = -19
            fileNameView.addBorder(edge: .bottom)
        }else{
            
            topCons = 15
            bottomCons = -15
            leftCons = 15
            rightCons = -15
        }
        
        
        
        NSLayoutConstraint.activate([
        
            fileNameView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: topCons),
            fileNameView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: leftCons),
            fileNameView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: bottomCons),
            fileNameView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: rightCons)
            ])
        
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        delegate?.updateValue(fileName: textField.text ?? "")
        
        return true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


protocol SinglePickerViewCellDelegate :class{
    func updateSinglePickerValue(value:String)
}


class SinglePickerViewCell:UITableViewCell{
    
    weak var delegate:SinglePickerViewCellDelegate?
    
    lazy var fileNameView:PickerOptionView = {
        let fileName = PickerOptionView()
        fileName.translatesAutoresizingMaskIntoConstraints = false
        fileName.valueTextField.inputView = subValueOnePicker
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
         let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissPickerViewaction))
         toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        fileName.valueTextField.inputAccessoryView = toolBar
        
        return fileName
    }()
    
    lazy var subValueOnePicker: UIPickerView = {

        let subValueOnePicker = UIPickerView()
        subValueOnePicker.delegate = self
        subValueOnePicker.dataSource = self
        subValueOnePicker.translatesAutoresizingMaskIntoConstraints = false
        return subValueOnePicker
    }()
    
    var items:[String] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    func setupView(){
        self.contentView.addSubview(fileNameView)
        
        let topCons:CGFloat
        let bottomCons:CGFloat
        let leftCons:CGFloat
        let rightCons:CGFloat
        
        if UIDevice.current.userInterfaceIdiom == .phone {
             topCons = 19
             bottomCons = -20
             leftCons = 19
             rightCons = -19
            fileNameView.addBorder(edge: .bottom)
        }else{
            
            topCons = 15
            bottomCons = -15
            leftCons = 15
            rightCons = -15
        }
        
        NSLayoutConstraint.activate([
        
            fileNameView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: topCons),
            fileNameView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: leftCons),
            fileNameView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: bottomCons),
            fileNameView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: rightCons)
            ])
    }
    
    @objc func dismissPickerViewaction(){
          
        delegate?.updateSinglePickerValue(value: fileNameView.valueTextField.text ?? "")
        self.contentView.endEditing(true)

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension SinglePickerViewCell: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
            return items.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    
            let row = items[row]
            return row
       
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
            let row = items[row]
            fileNameView.valueTextField.text = row
        
    }
}




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

enum PasswardViewType {
    case password
    case confirmPassword
}

protocol PasswordSettingCellDelegate:class{
    func updatePasswordValue(type:PasswardViewType,value:String?)
}

class PasswordSettingCell:UITableViewCell, UITextFieldDelegate{
    
    weak var delegate:PasswordSettingCellDelegate?
    lazy var passwordView: PickerOptionView = {
        var passwordView = PickerOptionView()
        passwordView.valueTextField.inputView = nil
        passwordView.valueTextField.inputAccessoryView = nil
        passwordView.valueTextField.tintColor = self.tintColor
        passwordView.valueTextField.selectedTextRange = .none
        passwordView.valueTextField.isSecureTextEntry = true
        passwordView.valueTextField.enablePasswordToggle()
        passwordView.valueTextField.delegate = self
        return passwordView
        
    }()
    

    lazy var verticalStackView:UIStackView = {
        let vStack = UIStackView()
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.alignment = .fill
        vStack.distribution = .fillProportionally
        vStack.spacing = 20
        return vStack
        
    }()
    
    var type : PasswardViewType = .password
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    func setupView(){

        self.contentView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(passwordView)
        
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            
            passwordView.title.removeFromSuperview()
            
            NSLayoutConstraint.activate([verticalStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 15),
                                         verticalStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 20),
                                         verticalStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -15),
                                         verticalStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -15),
                                         
            
            ])

        }else{
            
            NSLayoutConstraint.activate([verticalStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 19),
                                         verticalStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 19),
                                         verticalStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -19),
                                         verticalStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -19),
                                         
            
            ])

            passwordView.addBorder(edge: .bottom)
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        delegate?.updatePasswordValue(type: self.type, value: passwordView.valueTextField.text)
        return true
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        
        textField.isSecureTextEntry = true
        textField.rightView?.tintColor = .lightGray
    }
    
    
    
}



extension UITextField {
    fileprivate func setPasswordToggleImage(_ button: UIButton) {
        if(isSecureTextEntry){
            button.tintColor = .lightGray
        }else{
            button.tintColor = self.tintColor
        }
    }

    func enablePasswordToggle(){
        let button = UIButton(type: .custom)
        setPasswordToggleImage(button)
        button.setImage(UIImage(named: "Image")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .lightGray
        button.addTarget(self, action: #selector(self.togglePasswordView), for: .touchUpInside)
        self.rightView = button
        self.rightViewMode = .whileEditing
    }
    @objc func togglePasswordView(_ sender: Any) {
        self.isSecureTextEntry = !self.isSecureTextEntry
        setPasswordToggleImage(sender as! UIButton)
    }
}

protocol SingleNonPickerViewValueCellDelegate:class  {
    
    func pushSelectVC()
    
}




class SingleNonPickerViewValueCell: UITableViewCell{
    
    weak var delegate: SingleNonPickerViewValueCellDelegate?
    
    lazy var subValuePickerTwoView : PickerOptionView = {
        
        var subValuePickerTwoView = PickerOptionView()
        subValuePickerTwoView.translatesAutoresizingMaskIntoConstraints = false
        subValuePickerTwoView.valueTextField.isEnabled = false
        subValuePickerTwoView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(callDelegate)))
        return subValuePickerTwoView
    }()
    
    var value:String = "Select"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(subValuePickerTwoView)
        
        let topCons:CGFloat
        let bottomCons:CGFloat
        let leftCons:CGFloat
        let rightCons:CGFloat
        
        if UIDevice.current.userInterfaceIdiom == .phone {
             topCons = 19
             bottomCons = -20
             leftCons = 19
             rightCons = -19
            subValuePickerTwoView.addBorder(edge: .bottom)
        }else{
            
            topCons = 15
            bottomCons = -15
            leftCons = 15
            rightCons = -15
        }
        
        NSLayoutConstraint.activate([
        
            subValuePickerTwoView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: topCons),
            subValuePickerTwoView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: leftCons),
            subValuePickerTwoView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: bottomCons),
            subValuePickerTwoView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: rightCons)
            ])
        
        subValuePickerTwoView.valueTextField.text = value
    }
    
    func configure(value:String){
        self.value = value
    }
    
    @objc private func callDelegate(){
        delegate?.pushSelectVC()
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


enum ExportSettingType{
    
    case page
    case password
    case more
}



protocol ExportPassWordAndPageSettingCellDelegate:class {
    func pushToRespectiveVC(type:ExportSettingType)
}



class ExportPassWordAndPageSettingCell :UITableViewCell {
    
    weak var delegate:ExportPassWordAndPageSettingCellDelegate?
    
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

    lazy var pageSetting = SingleLableView()
    
    lazy var passwordSetting = SingleLableView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    func setupView(){
        
        
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
        
        pageSetting.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped)))
        passwordSetting.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped)))
    }
    
    @objc private func viewTapped(_ sender:UITapGestureRecognizer){
        
        if pageSetting.gestureRecognizers?[0] == sender{
            
            delegate?.pushToRespectiveVC(type: .page)
            
        }else{
            
            delegate?.pushToRespectiveVC(type: .password)
            
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



class MoreSettingCell :UITableViewCell {
    
    weak var delegate:ExportPassWordAndPageSettingCellDelegate?
    
    lazy var moreSetting = SingleLableView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        moreSetting.translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    func setupView(){

        self.contentView.addSubview(moreSetting)
//        verticalStackView.addArrangedSubview(pageSetting)
        
        NSLayoutConstraint.activate([moreSetting.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 0),
                                     moreSetting.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 0),
                                     moreSetting.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: 0),
                                     moreSetting.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: 0),
        
        ])
        
        moreSetting.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped)))

    }
    
    @objc private func viewTapped(_ sender:UITapGestureRecognizer){
        
       
        delegate?.pushToRespectiveVC(type: .more)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
