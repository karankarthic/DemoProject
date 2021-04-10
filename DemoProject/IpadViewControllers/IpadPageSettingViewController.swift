//
//  IpadPageSettingViewController.swift
//  DemoProject
//
//  Created by Karan Karthic Neelamegan on 24/03/21.
//

import UIKit

class IpadPageSettingViewController: UITableViewController {

    var delegateCalledCell:ExportOptionCustomaizingCell? = nil
    
    weak var delegate :PageSettingViewControllerDelegate?
    
    var valueForPageSetting:PageSettingValue = PageSettingValue(pageSize: "A4", pageOrientation: "Portrait", columnWidth: "Actual", margin: Margin(top: 10, left: 10, right: 10, bottom: 10), header: PagePositionValue( position: "Left", value: "Date"), footer: PagePositionValue(position: "Left", value: "Date"))

    
    init(){
        super.init(style: .grouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerReusableCell(SinglePickerViewCell.self)
        tableView.registerReusableCell(PrintOptionSelectorViewCell.self)
        tableView.registerReusableCell(MarginCell.self)
        tableView.registerReusableCell(ExportOptionCustomaizingCell.self)
        tableView.allowsSelection = false
        
        self.navigationItem.title = "Page Setting"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        6
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as SinglePickerViewCell
            let model = SinglePickerViewCellModel(fileNameViewtitle: "Page Size", items: ["A4","A9"], fileNameViewvalue: valueForPageSetting.pageSize)
            cell.configure(model:model)
            cell.delegate = self
            return cell
        }else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as PrintOptionSelectorViewCell
            
            let model = PrintOptionSelectorViewCellModel(optionViewTitle: "Page Orientation", optionViewConfigure: .orientation, optionViewSelectedChoice: valueForPageSetting.optionSelectedForColumnWidth, optionViewChoiceOneViewTitle: "Actual", optionViewChoiceTwoViewTitle: "Content based")
        
            cell.configure(model: model)
            cell.optionView.delegate = self
            cell.optionView.changeSelectionAsPerChoice()
            return cell
        }else if indexPath.section == 2{
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as PrintOptionSelectorViewCell
            
            let model = PrintOptionSelectorViewCellModel(optionViewTitle: "Column Width", optionViewConfigure: .columnWidth, optionViewSelectedChoice: valueForPageSetting.optionSelectedForColumnWidth, optionViewChoiceOneViewTitle: "Actual", optionViewChoiceTwoViewTitle: "Content based")
        
            cell.configure(model: model)
            cell.optionView.changeSelectionAsPerChoice()
            cell.optionView.delegate = self
            
            return cell
        }else if indexPath.section == 3{
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as MarginCell
            cell.configure(model:valueForPageSetting.margin)
            cell.delegate = self
            return cell
        }
        else if indexPath.section == 4{
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as ExportOptionCustomaizingCell
            let model = ExportOptionCustomaizingCellModel(titleLabel: "Header", position: .header, subValuePickerOneViewtitle: "Position", subValuePickerOneViewvalue: valueForPageSetting.header.position, subValuePickerTwoViewtitle: "Value", subValuePickerTwoViewvalue: valueForPageSetting.header.value)
            cell.configure(model:model)
            cell.delegate = self
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as ExportOptionCustomaizingCell
            
            let model = ExportOptionCustomaizingCellModel(titleLabel: "Footer", position: .footer, subValuePickerOneViewtitle: "Position", subValuePickerOneViewvalue: valueForPageSetting.footer.position, subValuePickerTwoViewtitle: "Value", subValuePickerTwoViewvalue: valueForPageSetting.footer.value)
            
            cell.configure(model:model)
            
            cell.delegate = self
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 78
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return ""
        }
        else if section == 1{
            return "PAGE ORIENTAION"
        }
        else if section == 2{
            return "COLUMN WIDTH"
        }
        else if section == 3{
            return "MARGIN ( ALL VALUES ARE IN MM )"
        }
        else if section == 4{
            return "HEADER"
        }else{
            return "Footer"
        }
    }

    @objc private func done(){
        
        
//         send back the moresettingvalues to the pageSetting done here
        delegate?.updatePageSettings(pageSettings:valueForPageSetting)
        
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @objc private func cancel(){
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
}


extension IpadPageSettingViewController: PrinterOptionCustomaizingCellDelegate {
  
    func updateposition(position: String, inPosition: Position) {
        
        if inPosition == .header{
           
            valueForPageSetting.header.position = position
        }else{
          
            valueForPageSetting.footer.position = position
        }
    }
    
    func pushSelectVC(cell: UITableViewCell?) {
        let selectModel = SelectCellModel(title: "Date", cellType: .normal, buttonType: .radio, choiceTitleEnabled: .off, isSelected: false)
        let selectModel1 = SelectCellModel(title: "Page Number", cellType: .normal, buttonType: .radio, choiceTitleEnabled: .off, isSelected: false)
        let selectModel2 = SelectCellModel(title: "Title", cellType: .title, buttonType: .radio, choiceTitleEnabled: .off, isSelected: false)
        
        
        
        let vc = SelectViewController()
        vc.selectionType = .single
        vc.delegate = self
        vc.items = [selectModel,selectModel1,selectModel2]
        let navVC = UINavigationController(rootViewController: vc)
        self.navigationController?.present(navVC, animated: true, completion: nil)
        
        self.delegateCalledCell = cell as? ExportOptionCustomaizingCell
    }
    
    
}


extension IpadPageSettingViewController: SelectViewControllerDelegate {
    
    func valueForMulitiSelect(valueForMulitiSelect: [String]) {
        
    }
    
    
    func valueForSingleSelect(value: String) {
        
        if delegateCalledCell?.position == .header{
            
            valueForPageSetting.header.value = value
        }else{
            
            valueForPageSetting.footer.value = value
        }
        self.tableView.reloadData()
        
    }
    
}

extension IpadPageSettingViewController: SinglePickerViewCellDelegate {
    func updateSinglePickerValue(value: String) {
        self.valueForPageSetting.pageSize = value

    }

}

extension IpadPageSettingViewController: PrintOptionSelectorViewCellDelegate {
    func updateOptionSelectorViewValue(configure: Configure, value: String, selected: ChoiceSelected) {
        if configure == .orientation{
            valueForPageSetting.pageOrientation = value
            valueForPageSetting.optionSelectedForOrientation = selected
        }else{
            valueForPageSetting.columnWidth = value
            valueForPageSetting.optionSelectedForColumnWidth = selected
        }
    }
    
}

extension IpadPageSettingViewController: MarginCellDelegate {
    
    func updateMargingcell(margin: Margin) {
        self.valueForPageSetting.margin = margin
    }
    

}
