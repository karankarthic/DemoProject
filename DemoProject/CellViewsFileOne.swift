//
//  CellViewsFileOne.swift
//  DemoProject
//
//  Created by Karan Karthic Neelamegan on 20/03/21.
//

import UIKit

enum ScreenType{
    case ipad
    case iphone
}

protocol PrinterOptionViewTypeCellDelegate:class {
    func updatePrinterOptionViewTypeValue(viewType:String)
}

class PrinterOptionViewTypeCell:UITableViewCell{
    
    weak var delegate:PrinterOptionViewTypeCellDelegate?
    
    lazy var segmentView: UISegmentedControl = {
        
        var items = ["List View","Detail View"]
        
        let segmentView = UISegmentedControl(items: items)
        segmentView.translatesAutoresizingMaskIntoConstraints = false
        segmentView.selectedSegmentIndex = 0
        segmentView.tintColor = UIColor.black
        segmentView.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .touchUpInside)
        if #available(iOS 13.0, *) {
            segmentView.setTitleTextAttributes([NSAttributedString.Key.backgroundColor: UIColor.white], for: .normal)
            segmentView.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        } else {}
        return segmentView
    }()
    
    lazy var titleLabel: UILabel = {
        
        let titleLabel = UILabel()
        titleLabel.text = "View Type"
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 17, weight: .bold)
        titleLabel.backgroundColor = .clear
        return titleLabel
    }()
    
    lazy var verticalStackView:UIStackView = {
        let vStack = UIStackView()
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.alignment = .fill
        vStack.distribution = .equalSpacing
        vStack.spacing = 17
        return vStack
        
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellView()
        
    }
    
    private func setupCellView() {
        
        self.contentView.addSubview(verticalStackView)
    
        if UIDevice.current.userInterfaceIdiom == .phone {
            verticalStackView.addArrangedSubview(titleLabel)
        }
        
        verticalStackView.addArrangedSubview(segmentView)
        
        NSLayoutConstraint.activate([
        
            verticalStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 19),
            verticalStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 19),
            verticalStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -19),
            verticalStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -19)
            ])
        delegate?.updatePrinterOptionViewTypeValue(viewType: "List View")
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            delegate?.updatePrinterOptionViewTypeValue(viewType: "List View")
        }else{
            delegate?.updatePrinterOptionViewTypeValue(viewType: "Detail View")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}





protocol PrinterOptionCustomaizingCellDelegate:class  {
    
    func pushSelectVC(cell:UITableViewCell?)
    func updateposition(position:String,inPosition:Position)
    
}

protocol PageCustomizationCellDelegate:class  {

    func updateposition(size:String,orientation:String)
    
}


class PageCustomizationCell: UITableViewCell{
    
    var items = ["Left","Right","Top","Bottom"]
    var orientationItems = ["Portait","Landscape"]
    
    weak var delegate : PageCustomizationCellDelegate?
    lazy var titleLabel: UILabel = {
        
        let titleLabel = UILabel()
        titleLabel.text = "Page"
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.backgroundColor = .clear
        return titleLabel
    }()
    
    lazy var subValuePickerOneView : PickerOptionView = {
        
        var subValuePickerOneView = PickerOptionView()
        
        subValuePickerOneView.valueTextField.inputView = subValueOnePicker
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
         let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissPickerViewaction))
         toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        subValuePickerOneView.valueTextField.inputAccessoryView = toolBar
        
        subValueOnePicker.delegate = self
        subValueOnePicker.dataSource = self
        
        return subValuePickerOneView
    }()
    
    lazy var subValuePickerTwoView : PickerOptionView = {
        
        var subValuePickerTwoView = PickerOptionView()
        subValuePickerTwoView.valueTextField.inputView = subValueTwoPicker
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
         let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissPickerViewaction))
         toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        subValuePickerTwoView.valueTextField.inputAccessoryView = toolBar
        
        subValueTwoPicker.delegate = self
        subValueTwoPicker.dataSource = self
        
        return subValuePickerTwoView
    }()
    

    lazy var subValueOnePicker: UIPickerView = {

        let subValueOnePicker = UIPickerView()
        subValueOnePicker.delegate = self
        subValueOnePicker.dataSource = self
        subValueOnePicker.translatesAutoresizingMaskIntoConstraints = false
        return subValueOnePicker
    }()
    
    lazy var subValueTwoPicker: UIPickerView = {

        let subValueOnePicker = UIPickerView()
        subValueOnePicker.delegate = self
        subValueOnePicker.dataSource = self
        subValueOnePicker.translatesAutoresizingMaskIntoConstraints = false
        return subValueOnePicker
    }()
    
    private lazy var separatorLine: UIView = {
        let separatorLine = UIView()
        separatorLine.backgroundColor = UIColor.separator
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        return separatorLine
    }()
    
    lazy var verticalStackView:UIStackView = {
        let vStack = UIStackView()
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.alignment = .fill
        vStack.distribution = .equalSpacing
        return vStack
        
    }()
    
    lazy var horizontalStackView:UIStackView = {
        let vStack = UIStackView()
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .horizontal
        vStack.alignment = .fill
        vStack.distribution = .fillEqually
        vStack.spacing = 16
        return vStack
        
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCellView(){
        
        self.contentView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(separatorLine)
        verticalStackView.addArrangedSubview(horizontalStackView)
        
        horizontalStackView.addArrangedSubview(subValuePickerOneView)
        
        horizontalStackView.addArrangedSubview(subValuePickerTwoView)

        if UIDevice.current.userInterfaceIdiom == .pad {
            subValuePickerOneView.title.font = .systemFont(ofSize: 16, weight: .bold)
            subValuePickerTwoView.title.font = .systemFont(ofSize: 16, weight: .bold)
            titleLabel.heightAnchor.constraint(equalToConstant: 0).isActive = true
            separatorLine.heightAnchor.constraint(equalToConstant: 0).isActive = true
            separatorLine.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor,constant: 10).isActive = true
            verticalStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -10).isActive = true
        }else{
            
            subValuePickerOneView.title.font = .systemFont(ofSize: 17, weight: .bold)
            subValuePickerTwoView.title.font = .systemFont(ofSize: 17, weight: .bold)
            NSLayoutConstraint.activate([
            
                titleLabel.leadingAnchor.constraint(equalTo: self.verticalStackView.leadingAnchor,constant: 19),
                titleLabel.topAnchor.constraint(equalTo: self.verticalStackView.topAnchor,constant: 20),

                
                separatorLine.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor,constant: 20),
                separatorLine.leadingAnchor.constraint(equalTo: self.verticalStackView.leadingAnchor),
                separatorLine.trailingAnchor.constraint(equalTo: self.verticalStackView.trailingAnchor),
                verticalStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -19),
                separatorLine.heightAnchor.constraint(equalToConstant: 0.5),
            
            ])
            
            subValuePickerOneView.addBorder(edge:.bottom)
            subValuePickerTwoView.addBorder(edge: .bottom)
        }
        
        NSLayoutConstraint.activate([
        
            verticalStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            horizontalStackView.topAnchor.constraint(equalTo: self.separatorLine.bottomAnchor,constant: 20),
            horizontalStackView.leadingAnchor.constraint(equalTo: self.verticalStackView.leadingAnchor,constant: 19),
            horizontalStackView.bottomAnchor.constraint(equalTo: self.verticalStackView.bottomAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: self.verticalStackView.trailingAnchor,constant: -20)
            
            
            ])
        
    }

    @objc func dismissPickerViewaction(){
          
        delegate?.updateposition(size: subValuePickerOneView.valueTextField.text ?? "", orientation: subValuePickerTwoView.valueTextField.text ?? "")
        self.contentView.endEditing(true)

    }
    
    
}

extension PageCustomizationCell: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == subValueOnePicker {
            return items.count
        }else{
            return orientationItems.count
        }
       
           
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       
        if pickerView == subValueOnePicker {
            let row = items[row]
            return row
        }else{
            let row = orientationItems[row]
            return row
        }
        
            
       
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       
        if pickerView == subValueOnePicker {
            let row = items[row]
            subValuePickerOneView.valueTextField.text = row
        }else{
            let row = orientationItems[row]
            subValuePickerTwoView.valueTextField.text = row
        }
    }
}







class ExportOptionCustomaizingCell : UITableViewCell {
    
    var items = ["Left","Right","Top","Bottom"]
    
    weak var delegate : PrinterOptionCustomaizingCellDelegate?
    var position:Position = .header
    lazy var titleLabel: UILabel = {
        
        let titleLabel = UILabel()
        titleLabel.text = "Page"
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.backgroundColor = .clear
        return titleLabel
    }()
    
    lazy var subValuePickerOneView : PickerOptionView = {
        
        var subValuePickerOneView = PickerOptionView()
        
        subValuePickerOneView.valueTextField.inputView = subValueOnePicker
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
         let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissPickerViewaction))
         toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        subValuePickerOneView.valueTextField.inputAccessoryView = toolBar
        
        subValueOnePicker.delegate = self
        subValueOnePicker.dataSource = self
        
        return subValuePickerOneView
    }()
    
    lazy var subValuePickerTwoView : PickerOptionView = {
        
        var subValuePickerTwoView = PickerOptionView()
        subValuePickerTwoView.valueTextField.isEnabled = false
        subValuePickerTwoView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(callDelegate)))
        return subValuePickerTwoView
    }()
    

    lazy var subValueOnePicker: UIPickerView = {

        let subValueOnePicker = UIPickerView()
        subValueOnePicker.delegate = self
        subValueOnePicker.dataSource = self
        subValueOnePicker.translatesAutoresizingMaskIntoConstraints = false
        return subValueOnePicker
    }()
    
    
    private lazy var separatorLine: UIView = {
        let separatorLine = UIView()
        separatorLine.backgroundColor = UIColor.separator
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        return separatorLine
    }()
    
    lazy var verticalStackView:UIStackView = {
        let vStack = UIStackView()
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.alignment = .fill
        vStack.distribution = .equalSpacing
        return vStack
        
    }()
    
    lazy var horizontalStackView:UIStackView = {
        let vStack = UIStackView()
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .horizontal
        vStack.alignment = .fill
        vStack.distribution = .fillEqually
        vStack.spacing = 16
        return vStack
        
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCellView(){
        
        self.contentView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(separatorLine)
        verticalStackView.addArrangedSubview(horizontalStackView)
        
        horizontalStackView.addArrangedSubview(subValuePickerOneView)
        
        horizontalStackView.addArrangedSubview(subValuePickerTwoView)

        if UIDevice.current.userInterfaceIdiom == .pad {
            subValuePickerOneView.title.font = .systemFont(ofSize: 16, weight: .bold)
            subValuePickerTwoView.title.font = .systemFont(ofSize: 16, weight: .bold)
            titleLabel.heightAnchor.constraint(equalToConstant: 0).isActive = true
            separatorLine.heightAnchor.constraint(equalToConstant: 0).isActive = true
            separatorLine.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor,constant: 10).isActive = true
            verticalStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -10).isActive = true
        }else{
            
            subValuePickerOneView.title.font = .systemFont(ofSize: 17, weight: .bold)
            subValuePickerTwoView.title.font = .systemFont(ofSize: 17, weight: .bold)
            NSLayoutConstraint.activate([
            
                titleLabel.leadingAnchor.constraint(equalTo: self.verticalStackView.leadingAnchor,constant: 19),
                titleLabel.topAnchor.constraint(equalTo: self.verticalStackView.topAnchor,constant: 20),

                
                separatorLine.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor,constant: 20),
                separatorLine.leadingAnchor.constraint(equalTo: self.verticalStackView.leadingAnchor),
                separatorLine.trailingAnchor.constraint(equalTo: self.verticalStackView.trailingAnchor),
                verticalStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -19),
                separatorLine.heightAnchor.constraint(equalToConstant: 0.5),
            
            ])
            
            subValuePickerOneView.addBorder(edge:.bottom)
            subValuePickerTwoView.addBorder(edge: .bottom)
        }
        
        NSLayoutConstraint.activate([
        
            verticalStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            horizontalStackView.topAnchor.constraint(equalTo: self.separatorLine.bottomAnchor,constant: 20),
            horizontalStackView.leadingAnchor.constraint(equalTo: self.verticalStackView.leadingAnchor,constant: 19),
            horizontalStackView.bottomAnchor.constraint(equalTo: self.verticalStackView.bottomAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: self.verticalStackView.trailingAnchor,constant: -20)
            
            
            ])
        
    }
    
    @objc private func callDelegate(){
        delegate?.pushSelectVC(cell: self)
    }
    
    @objc func dismissPickerViewaction(){
          
        self.contentView.endEditing(true)
        delegate?.updateposition(position:subValuePickerOneView.valueTextField.text ?? "", inPosition: position)
    }
    
    
}

extension ExportOptionCustomaizingCell: UIPickerViewDelegate, UIPickerViewDataSource{
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
            subValuePickerOneView.valueTextField.text = row
       
    }
}





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
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            valueTextField.bottomAnchor.constraint(equalTo:self.bottomAnchor,constant: -10 ).isActive = true
        }
        
        
        
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
    var buttonType : ButtonType = .radio
    
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

protocol PrintOptionSelectorViewCellDelegate:class {
    
    func updateOptionSelectorViewValue(configure:Configure,value:String)
    
}
enum ChoiceSelected{
    case choiceOne
    case choiceTwo
}

class OptionSelectorRadioButtonView : UIView {
    
    
    
    var configure:Configure = .orientation
    weak var delegate: PrintOptionSelectorViewCellDelegate?
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
        
        self.addSubview(verticalStackView)
        
        verticalStackView.addArrangedSubview(title)
        verticalStackView.addArrangedSubview(choiceOneView)
        verticalStackView.addArrangedSubview(choiceTwoView)
        
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            
            title.heightAnchor.constraint(equalToConstant: 0).isActive = true
        }
        
        NSLayoutConstraint.activate([verticalStackView.topAnchor.constraint(equalTo: self.topAnchor,constant: 0),
                                     verticalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 0),
                                     verticalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: 0),
                                     verticalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: 0)
        ])
        
        choiceOneView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonTapped(_:))))
        choiceTwoView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonTapped(_:))))
        
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
        
        delegate?.updateOptionSelectorViewValue(configure: configure, value: choiceOneView.title.text ?? "")
    }
    private func choiceTwoSelected(){
        choiceOneView.selectButton.image = intialimg
        choiceTwoView.selectButton.image = radio
        
        choiceOneView.selectButton.tintColor = .lightGray
        choiceTwoView.selectButton.tintColor = .blue
        delegate?.updateOptionSelectorViewValue(configure: configure, value: choiceTwoView.title.text ?? "")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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





class MargingInnerView:UIView {
    
    lazy var horizontalStackView:UIStackView = {
        let vStack = UIStackView()
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .horizontal
        vStack.alignment = .leading
        vStack.distribution = .fillProportionally
        vStack.spacing = 15
        return vStack
    }()
    
    lazy var verticalStackView:UIStackView = {
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
    
    lazy var innerVerticalStackView:UIStackView = {
        let vStack = UIStackView()
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.alignment = .fill
        vStack.distribution = .equalSpacing
        vStack.spacing = 2
        return vStack
        
    }()
    
    lazy var secInnerVerticalStackView:UIStackView = {
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
    
    lazy var horizontalStackView:UIStackView = {
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
    
    lazy var marginInnerView = MargingInnerView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupCellView()
        
    }
    
    func setupCellView(){
        
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
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        
//        
//        return true
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



class PrintBatchCell:UITableViewCell {
    
    lazy var horizontalStackView:UIStackView = {
        let vStack = UIStackView()
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .horizontal
        vStack.alignment = .center
        vStack.distribution = .fillProportionally
        vStack.spacing = 10
        return vStack
    }()
    
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
        vStack.spacing = 7
        return vStack
        
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
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupCellView()
        
    }
    
    func setupCellView(){
        
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
