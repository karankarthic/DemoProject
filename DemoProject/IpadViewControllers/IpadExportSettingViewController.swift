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

    
    var viewModel:ExportViewModel = ExportViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerReusableCell(ExportSettingsFileNameCell.self)
        tableView.registerReusableCell(SinglePickerViewCell.self)
        tableView.registerReusableCell(PrinterOptionViewTypeCell.self)
        tableView.registerReusableCell(SingleNonPickerViewValueCell.self)
        tableView.registerReusableCell(ExportPassWordAndPageSettingCell.self)
        
        tableView.allowsSelection = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))

        
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
            cell.fileNameView.valueTextField.text = viewModel.fileName
            return cell
        }else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as SinglePickerViewCell
            cell.fileNameView.title.text = "File Type"
            cell.items = ["PDF"]
            cell.fileNameView.valueTextField.text = viewModel.fileType
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
    
    @objc private func cancel(){
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
}

extension IpadExportSettingViewController: SingleNonPickerViewValueCellDelegate{
    
    func pushSelectVC() {
        
        let selectModel = SelectCellModel(title: "colum1", cellType: .normal, buttonType: .check, choiceTitleEnabled: .off, isSelected: false)
        let selectModel1 = SelectCellModel(title: "colum2", cellType: .normal, buttonType: .check, choiceTitleEnabled: .off, isSelected: false)
        let selectModel2 = SelectCellModel(title: "colum3", cellType: .normal, buttonType: .check, choiceTitleEnabled: .off, isSelected: false)
        let selectModel3 = SelectCellModel(title: "colum4", cellType: .normal, buttonType: .check, choiceTitleEnabled: .off, isSelected: false)
        
        
        let vc = SelectViewController()
        vc.selectionType = .multi
        vc.delegate = self
        vc.valueForMulitiSelect = viewModel.selecteColumns
        vc.items = [selectModel,selectModel1,selectModel2,selectModel3]
        vc.mulitSelectReview()
        let navVC = UINavigationController(rootViewController: vc)
        self.navigationController?.present(navVC, animated: true, completion: nil)
    }
    
    
}

extension IpadExportSettingViewController: ExportPassWordAndPageSettingCellDelegate {
    
    func pushToRespectiveVC(type: ExportSettingType) {
        
        
        let navVC : UINavigationController
        
        if type == .page{
            
            let vc = PageSettingViewController()
            vc.delegate = self
            navVC = UINavigationController(rootViewController: vc)
            
        }else{
            
            let vc = PassWordSettingViewController()
            vc.delegate = self
            navVC = UINavigationController(rootViewController: vc)
        }
    
        
        self.navigationController?.present(navVC, animated: true, completion: nil)
        
    }
  
}

extension IpadExportSettingViewController : SelectViewControllerDelegate {
    
    func valueForMulitiSelect(valueForMulitiSelect: [String]) {
        viewModel.selecteColumns = valueForMulitiSelect
    }
    
    func valueForSingleSelect(value: String) {
        
    }

}


extension IpadExportSettingViewController :ExportSettingsFileNameCellDelegate{
    func updateValue(fileName: String) {
        self.viewModel.fileName = fileName
    }
}

extension IpadExportSettingViewController : SinglePickerViewCellDelegate{
    func updateSinglePickerValue(value: String) {
        self.viewModel.fileType = value
    }
}

extension IpadExportSettingViewController : PageSettingViewControllerDelegate{
    func updatePageSettings(pageSettings: PageSettingValue) {
        self.viewModel.pageSettings = pageSettings
    }
    
    
}

extension IpadExportSettingViewController : PassWordSettingViewControllerDelegate{
    func updatePasswordValue(passwordValue: Passwords) {
        self.viewModel.passwordSetting = passwordValue
    }
    
    
}