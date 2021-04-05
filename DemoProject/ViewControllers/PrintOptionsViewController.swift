//
//  PrintOptionsViewController.swift
//  DemoProject
//
//  Created by Karan Karthic Neelamegan on 24/03/21.
//

import UIKit

struct PrintOptionModel{
    
    var pageSize:String = "A4"
    var pageOrientation:String = "Portrait"
    var columnWidth:String = "Actual"
    var moreSetting:MoreSettingsValueModel = MoreSettingsValueModel(margin: Margin(top: 10, left: 10, right: 10, bottom: 10), header: PagePositionValue(position: "Left", value: "Date"), footer: PagePositionValue(position: "Left", value: "Date"))
    
}

class PrintOptionsViewController: CardLayoutTableViewController {
    
    var viewModel:PrintOptionModel = PrintOptionModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerReusableCell(PrinterOptionViewTypeCell.self)
        tableView.registerReusableCell(PageCustomizationCell.self)
        tableView.registerReusableCell(PrintOptionSelectorViewCell.self)
        tableView.registerReusableCell(MoreSettingCell.self)
        
        tableView.allowsSelection = false
        
        self.navigationItem.title = "Print Options"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextfunc))
        
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as PrinterOptionViewTypeCell
            return cell
        }else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as PageCustomizationCell
            cell.titleLabel.text = "Page"
            cell.subValuePickerOneView.title.text = "Size"
            cell.subValuePickerOneView.valueTextField.text = viewModel.pageSize
            
            cell.subValuePickerTwoView.title.text = "Orientation"
            cell.subValuePickerTwoView.valueTextField.text = viewModel.pageOrientation
            cell.delegate = self
            return cell
        }else if indexPath.section == 2{
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as PrintOptionSelectorViewCell
            cell.optionView.title.text = "Column Width"
            cell.optionView.configure = .columnWidth
            cell.optionView.choiceOneView.title.text = "Actual"
            cell.optionView.choiceTwoView.title.text = "Content based"
            cell.optionView.delegate = self
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as MoreSettingCell
            cell.moreSetting.titleLabel.text = "More Setting"
            cell.delegate = self
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 78
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 12
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 12
    }
    
    @objc private func nextfunc(){
        
        
        let vc = PrintBatchViewController()
        vc.printSettings = self.viewModel
        
        let navVC = UINavigationController(rootViewController: vc)
        
        self.navigationController?.present(navVC, animated: true, completion: nil)
        
        
    }
    
    @objc private func cancel(){
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
}

extension PrintOptionsViewController: PageCustomizationCellDelegate {
    func updateposition(size: String, orientation: String) {
        
        self.viewModel.pageSize = size
        self.viewModel.pageOrientation = orientation
    }
    
    
}



extension PrintOptionsViewController: ExportPassWordAndPageSettingCellDelegate {
    
    func pushToRespectiveVC(type: ExportSettingType) {
        if type == .more{
            
            let vc = MoreSettingsViewController()
            vc.delegate = self
            let navVC = UINavigationController(rootViewController: vc)
            
            self.navigationController?.present(navVC, animated: true, completion: nil)
            
        }
    }
    
}

extension PrintOptionsViewController:MoreSettingsViewControllerDelegate{
    func updateMoreSettingValue(value: MoreSettingsValueModel) {
        self.viewModel.moreSetting = value
    }
}

extension PrintOptionsViewController: PrintOptionSelectorViewCellDelegate {
    func updateOptionSelectorViewValue(configure: Configure, value: String) {
        if configure == .columnWidth{
            self.viewModel.columnWidth = value
        }
    }
    
    
}
