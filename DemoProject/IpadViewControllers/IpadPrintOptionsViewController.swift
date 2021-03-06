////
////  IpadPrintOptionsViewController.swift
////  DemoProject
////
////  Created by Karan Karthic Neelamegan on 25/03/21.
////
//
//import UIKit
//
//class IpadPrintOptionsViewController: UITableViewController {
//    
//    
//    var viewModel:PrintOptionModel = PrintOptionModel()
//
//    
//    init(){
//        super.init(style: .grouped)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        tableView.registerReusableCell(PrinterOptionViewTypeCell.self)
//        tableView.registerReusableCell(PageCustomizationCell.self)
//        tableView.registerReusableCell(PrintOptionSelectorViewCell.self)
//        tableView.registerReusableCell(MoreSettingCell.self)
//        
//        tableView.allowsSelection = false
//        
//        self.navigationItem.title = "Print Options"
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextfunc))
//        
//        
//        
//    }
//    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        4
//    }
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        if indexPath.section == 0{
//            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as PrinterOptionViewTypeCell
//            cell.onUpdateValue = { type in
//                
//                self.viewModel.viewType = type
//                
//            }
//            return cell
//        }else if indexPath.section == 1{
//            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as PageCustomizationCell
//            let model = PageCustomizationCellModel(titleLabel: "Page", subValuePickerOneViewTitle: "Size", subValuePickerOneViewvalue: viewModel.pageSize, subValuePickerTwoViewTitle: "Orientation", subValuePickerTwoViewvalue: viewModel.pageOrientation)
//            cell.configure(model:model)
//            cell.onUpdateValue = { (size,orientation) in
//                
//                self.viewModel.pageSize = size
//                self.viewModel.pageOrientation = orientation
//            }
//            
//            return cell
//        }else if indexPath.section == 2{
//            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as PrintOptionSelectorViewCell
//            let model = PrintOptionSelectorViewCellModel(optionViewTitle: "Column Width", optionViewConfigure: .columnWidth, optionViewSelectedChoice: viewModel.optionSelectedForColumnWidth, optionViewChoiceOneViewTitle: "Actual", optionViewChoiceTwoViewTitle: "Content based")
//        
//            cell.configure(model: model)
//            cell.optionView.onUpdateValue = { (value,selectedOption) in
//                
//                self.viewModel.columnWidth = value
//                self.viewModel.optionSelectedForColumnWidth = selectedOption
//            }
//            cell.optionView.changeSelectionAsPerChoice()
//            return cell
//        }else{
//            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as MoreSettingCell
//            cell.pushToMoreVc = {
//                self.pushToRespectiveVC()
//            }
//            return cell
//        }
//        
//    }
//    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//    
//    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 78
//    }
//    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if section == 0{
//            return "View Type"
//        }
//        else if section == 1{
//            
//            return "Page"
//        }
//        else if section == 2{
//            
//            return "Column Width"
//        }else{
//            return ""
//        }
//    }
//    
//    @objc private func nextfunc(){
//        
//        
//        let vc = PrintBatchViewController()
//        vc.printSettings = self.viewModel
//        
//        let navVC = UINavigationController(rootViewController: vc)
//        
//        self.navigationController?.present(navVC, animated: true, completion: nil)
//        
//        
//    }
//    
//    @objc private func cancel(){
//        
//        self.dismiss(animated: true, completion: nil)
//        
//    }
//    
//}
//
////extension IpadPrintOptionsViewController: PageCustomizationCellDelegate {
////    func updateposition(size: String, orientation: String) {
////
////        self.viewModel.pageSize = size
////        self.viewModel.pageOrientation = orientation
////    }
////
////
////}
//
////extension IpadPrintOptionsViewController:PrinterOptionViewTypeCellDelegate{
////    func updatePrinterOptionViewTypeValue(viewType: Int) {
////        self.viewModel.viewType = viewType
////    }
////
////}
//
//
//
//extension IpadPrintOptionsViewController {
//
//    func pushToRespectiveVC() {
//       
//            let vc = MoreSettingsViewController()
//            vc.delegate = self
//            vc.valueForMoreSetting = self.viewModel.moreSetting
//            let navVC = UINavigationController(rootViewController: vc)
//
//            self.navigationController?.present(navVC, animated: true, completion: nil)
//
//      
//    }
//
//}
//
//extension IpadPrintOptionsViewController:MoreSettingsViewControllerDelegate{
//    func updateMoreSettingValue(value: MoreSettingsValueModel) {
//        self.viewModel.moreSetting = value
//    }
//}
//
////extension IpadPrintOptionsViewController: PrintOptionSelectorViewCellDelegate {
////
////    func updateOptionSelectorViewValue(configure: Configure, value: String, selected: ChoiceSelected) {
////        if configure == .columnWidth{
////            self.viewModel.columnWidth = value
////            viewModel.optionSelectedForColumnWidth = selected
////        }
////    }
////
////
////}
