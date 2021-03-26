//
//  IpadExportSettingViewController.swift
//  DemoProject
//
//  Created by Karan Karthic Neelamegan on 25/03/21.
//

import UIKit

class IpadExportSettingViewController: UITableViewController {
    
    init(){
        super.init(style: .grouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    var fileName:String = ""
    var fileType:String = "A4"
    var selecteColumns:[String] = []
    var pageSettings:PageSettingValue = PageSettingValue(pageSize: "A4", pageOrientation: "Portrait", columnWidth: "Actual", margin: Margin(t: "10", l: "10", r: "10", b: "10"), header: PagePositionValue(position: "Left", value: "Date"), footer: PagePositionValue(position: "Left", value: "Date"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerReusableCell(ExportSettingsFileNameCell.self)
        tableView.registerReusableCell(SinglePickerViewCell.self)
        tableView.registerReusableCell(PrinterOptionViewTypeCell.self)
        tableView.registerReusableCell(SingleNonPickerViewValueCell.self)
        tableView.registerReusableCell(ExportPassWordAndPageSettingCell.self)
        
        tableView.allowsSelection = false
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        5
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as ExportSettingsFileNameCell
            cell.fileNameView.title.text = "File Name"
            cell.delegate = self
            cell.fileNameView.valueTextField.text = fileName
            return cell
        }else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as SinglePickerViewCell
            cell.fileNameView.title.text = "File Type"
            cell.items = ["PDF"]
            cell.fileNameView.valueTextField.text = fileType
            cell.delegate = self
            return cell
        }else if indexPath.section == 2{
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as PrinterOptionViewTypeCell
            cell.contentView.addBorder(edge: .bottom)
            return cell
        }else if indexPath.section == 3{
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as SingleNonPickerViewValueCell
            cell.subValuePickerTwoView.title.text = "Colums Selection"
            cell.delegate = self
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as ExportPassWordAndPageSettingCell
            cell.delegate = self
            cell.pageSetting.titleLabel.text = "Page Setting"
            cell.passwordSetting.titleLabel.text = "Password Setting"
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
        if section == 2{
            return "VIEW TYPE"
        }
        else{
            return ""
        }
    }
    
}

extension IpadExportSettingViewController: SingleNonPickerViewValueCellDelegate{
    
    func pushSelectVC() {
        
        let selectModel = SelectCellModel(title: "column1", cellType: .normal, buttonType: .check, choiceTitleEnabled: .off, isSelected: false)
        let selectModel1 = SelectCellModel(title: "column2", cellType: .normal, buttonType: .check, choiceTitleEnabled: .off, isSelected: false)
        let selectModel2 = SelectCellModel(title: "column3", cellType: .normal, buttonType: .check, choiceTitleEnabled: .off, isSelected: false)
        let selectModel3 = SelectCellModel(title: "column4", cellType: .normal, buttonType: .check, choiceTitleEnabled: .off, isSelected: false)
        
        
        let vc = SelectViewController()
        vc.selectionType = .multi
        vc.items = [selectModel,selectModel1,selectModel2,selectModel3]
        let navVC = UINavigationController(rootViewController: vc)
        self.navigationController?.present(navVC, animated: true, completion: nil)
    }
    
    
}

extension IpadExportSettingViewController: ExportPassWordAndPageSettingCellDelegate {
    
    func pushToRespectiveVC(type: ExportSettingType) {
        
        
        let navVC : UINavigationController
        
        if type == .page{
            
            let vc = IpadPageSettingViewController()
            vc.delegate = self
            navVC = UINavigationController(rootViewController: vc)
            
        }else{
            
            let vc = IpadPasswordViewController()
//            vc.delegate = self
            navVC = UINavigationController(rootViewController: vc)
        }
    
        
        self.navigationController?.present(navVC, animated: true, completion: nil)
        
    }
  
}

extension IpadExportSettingViewController : SelectViewControllerDelegate {
    
    func valueForMulitiSelect(valueForMulitiSelect: [String]) {
        selecteColumns = valueForMulitiSelect
    }
    
    func valueForSingleSelect(value: String) {
        
    }

}

extension IpadExportSettingViewController :ExportSettingsFileNameCellDelegate{
    func updateValue(fileName: String) {
        self.fileName = fileName
    }
    
    
    
    
}

extension IpadExportSettingViewController : SinglePickerViewCellDelegate{
    func updateSinglePickerValue(value: String) {
        self.fileType = value
    }
}

extension IpadExportSettingViewController : PageSettingViewControllerDelegate{
    func updatePageSettings(pageSettings: PageSettingValue) {
        self.pageSettings = pageSettings
    }
    
    
}
