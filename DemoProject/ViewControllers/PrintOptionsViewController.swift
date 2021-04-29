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
    var columnWidth:ColumnWidthValue = .actual
    var moreSetting:MoreSettingsValueModel = MoreSettingsValueModel(margin: Margin(top: 10, left: 10, right: 10, bottom: 10), header:[ PositionValues(position: .left, type: "Date", value: "System Date"),PositionValues(position: .center, type: "Date", value: "System Date"),PositionValues(position: .right, type: "Date", value: "System Date")], footer: [ PositionValues(position: .left, type: "Date", value: "System Date"),PositionValues(position: .center, type: "Date", value: "System Date"),PositionValues(position: .right, type: "Date", value: "System Date")])
    var optionSelectedForColumnWidth:ChoiceSelected = .choiceOne
    
}

class PrintOptionsViewController: CardLayoutTableViewController {
    
    var viewModel:PrintOptionModel = PrintOptionModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerReusableCell(PrinterOptionViewTypeCell.self)
        tableView.registerReusableCell(PageCustomizationCell.self)
        tableView.registerReusableCell(ColumnWidthSelectorCell.self)
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
            cell.onUpdateValue = { type in
                
                self.viewModel.viewType = type
                
            }
            return cell
        }else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as PageCustomizationCell
            
            let model = PageCustomizationCellModel(titleLabel: "Page", subValuePickerOneViewTitle: "Size", subValuePickerOneViewvalue: viewModel.pageSize, subValuePickerTwoViewTitle: "Orientation", subValuePickerTwoViewvalue: viewModel.pageOrientation)
            cell.configure(model:model)
            cell.onUpdateValue = { (size,orientation) in
                
                self.viewModel.pageSize = size
                self.viewModel.pageOrientation = orientation
            }
            
            return cell
        }else if indexPath.section == 2{
            
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as ColumnWidthSelectorCell
            
            let model = ColumnWidthSelectorCellModel(title: "Column Width", selectedValue: viewModel.columnWidth)
            cell.configue(model: model)
            
            cell.reloadUiForScaling = {
                
                self.tableView.reloadData()
                
            }
            
            cell.updateValue = { value in
                
                self.viewModel.columnWidth = value
            }
            
            

            return cell

        }else{
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as MoreSettingCell
            cell.pushToMoreVc = {
                self.pushToRespectiveVC()
            }
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



extension PrintOptionsViewController {

    func pushToRespectiveVC() {
       
            let vc = MoreSettingsViewController()
            vc.delegate = self
            vc.valueForMoreSetting = self.viewModel.moreSetting
            let navVC = UINavigationController(rootViewController: vc)

            self.navigationController?.present(navVC, animated: true, completion: nil)

      
    }

}

extension PrintOptionsViewController:MoreSettingsViewControllerDelegate{
    func updateMoreSettingValue(value: MoreSettingsValueModel) {
        self.viewModel.moreSetting = value
    }
}

