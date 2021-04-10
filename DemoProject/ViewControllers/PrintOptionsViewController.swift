//
//  PrintOptionsViewController.swift
//  DemoProject
//
//  Created by Karan Karthic Neelamegan on 24/03/21.
//

import UIKit

struct PrintOptionModel{
    
    var viewType:Int = 1
    var pageSize:String = "A4"
    var pageOrientation:String = "Portrait"
    var columnWidth:String = "Actual"
    var moreSetting:MoreSettingsValueModel = MoreSettingsValueModel(margin: Margin(top: 10, left: 10, right: 10, bottom: 10), header: PagePositionValue(position: "Left", value: "Date"), footer: PagePositionValue(position: "Left", value: "Date"))
    var optionSelectedForColumnWidth:ChoiceSelected = .choiceOne
    
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
            cell.delegate = self
            return cell
        }else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as PageCustomizationCell
            
            let model = PageCustomizationCellModel(titleLabel: "Page", subValuePickerOneViewTitle: "Size", subValuePickerOneViewvalue: viewModel.pageSize, subValuePickerTwoViewTitle: "Orientation", subValuePickerTwoViewvalue: viewModel.pageOrientation)
            cell.configure(model:model)
            cell.delegate = self
            
            return cell
        }else if indexPath.section == 2{
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as PrintOptionSelectorViewCell
            let model = PrintOptionSelectorViewCellModel(optionViewTitle: "Column Width", optionViewConfigure: .columnWidth, optionViewSelectedChoice: viewModel.optionSelectedForColumnWidth, optionViewChoiceOneViewTitle: "Actual", optionViewChoiceTwoViewTitle: "Content based")
        
            cell.configure(model: model)
            cell.optionView.delegate = self
            cell.optionView.changeSelectionAsPerChoice()
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as MoreSettingCell
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

extension PrintOptionsViewController:PrinterOptionViewTypeCellDelegate{
    func updatePrinterOptionViewTypeValue(viewType: Int) {
        self.viewModel.viewType = viewType
    }
    
}



extension PrintOptionsViewController: ExportPassWordAndPageSettingCellDelegate {
    
    func pushToRespectiveVC(type: ExportSettingType) {
        if type == .more{
            
            let vc = MoreSettingsViewController()
            vc.delegate = self
            vc.valueForMoreSetting = self.viewModel.moreSetting
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
    func updateOptionSelectorViewValue(configure: Configure, value: String, selected: ChoiceSelected) {
        if configure == .columnWidth{
            self.viewModel.columnWidth = value
            viewModel.optionSelectedForColumnWidth = selected
        }
    }
    
}
