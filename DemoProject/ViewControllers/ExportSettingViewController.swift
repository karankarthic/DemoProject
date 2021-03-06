//
//  ExportSettingViewController.swift
//  DemoProject
//
//  Created by Karan Karthic Neelamegan on 23/03/21.
//

import UIKit

enum FileType:String,CaseIterable{
    case PDF = "pdf"
    case Xls = "xls"
    case Csv = "csv"
    case Json = "json"
    case Tsv = "tsv"
    
    static func returnValueArray() -> [String]{
        var array:[String]  = []
        for value in FileType.allCases{
            array.append(value.rawValue)
        }
        
        return array
    }
    
    static func returnValueForType(_ rawValue:String) -> FileType{
        var  returnValue:FileType = .Json
        
        for value in FileType.allCases{
            if value.rawValue == rawValue{
                returnValue = value
                break
            }
        }
        
        return returnValue
    }
}

struct ExportViewModel {
    var fileName:String = ""
    var fileType:FileType = .Json
    var viewType:Int = 1
    var selecteColumns:[String] = []
    var pageSettings:PageSettingValue = PageSettingValue(pageSize: "A4", pageOrientation: "Portrait", columnWidth: .actual, margin: Margin(top: 10, left: 10, right: 10, bottom: 10), header: [ PositionValues(position: .left, type: "Date", value: "System Date"),PositionValues(position: .center, type: "Date", value: "System Date"),PositionValues(position: .right, type: "Date", value: "System Date")], footer: [ PositionValues(position: .left, type: "Date", value: "System Date"),PositionValues(position: .center, type: "Date", value: "System Date"),PositionValues(position: .right, type: "Date", value: "System Date")])
    var passwordSetting:Passwords = Passwords()
}


class ExportSettingViewController: CardLayoutTableViewController {
    
    var viewModel:ExportViewModel = ExportViewModel()
    
    private var columnSelectionValue:ColumnSelectionValue? = nil

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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        5
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as ExportSettingsFileNameCell
            let model = ExportSettingsFileNameCellModel(title: "File Name", value: viewModel.fileName)
            cell.configure(model:model)

            cell.onUpdateValue = { text in
                
                self.viewModel.fileName = text
                
            }
            return cell
        }else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as SinglePickerViewCell
            let model = SinglePickerViewCellModel(fileNameViewtitle: "File Type", items: FileType.returnValueArray(), fileNameViewvalue: viewModel.fileType.rawValue)
            cell.configure(model:model)

            cell.onUpdateValue = { text in
                
                self.viewModel.fileType = FileType.returnValueForType(text)
                
            }
            return cell
        }else if indexPath.section == 2{
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as PrinterOptionViewTypeCell
            cell.onUpdateValue = { type in
                
                self.viewModel.viewType = type
                
            }
            cell.contentView.addBorder(edge: .bottom)
            return cell
        }else if indexPath.section == 3{
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as SingleNonPickerViewValueCell
            cell.toPushSelectVC = {
                self.pushSelectVC()
            }
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as ExportPassWordAndPageSettingCell
            cell.pushToPageVc = { pageView in
                self.pushToPageVc(sourceView: pageView)
            }
            
            cell.pushToPasswordVc = { passwordView in
                self.pushToPassword()
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
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }

    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }

    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 || section == 2{
            return 0
        }
        return 12
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 || section == 3{
            return .leastNonzeroMagnitude
        }
        return 12
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let viewConstructor = CornerViewConstructor.init(contentView: cell.contentView)
        
        if indexPath.section == 0 || indexPath.section == 2{
            viewConstructor.constructLayout(for: .topCorner)
        }
        else if indexPath.section == 1 || indexPath.section == 3{
            viewConstructor.constructLayout(for: .bottomCorner)
        }else{
            viewConstructor.constructLayout(for: .allCorner)
        }
        
        
    }
    
    @objc private func cancel(){
        
        self.dismiss(animated: true, completion: nil)
        
    }

}


extension ExportSettingViewController{
    
    func pushSelectVC() {
        let columns:[Column] = [Column(name: "Karan", inQuickView: true, inDetailView: false),Column(name: "karthic", inQuickView: true, inDetailView: true)]
        
        let vc = ColumnSelectionViewController(columns: columns, columnSelectionValue: columnSelectionValue)
        vc.delegate = self
    
        let navVC = UINavigationController(rootViewController: vc)
        self.navigationController?.present(navVC, animated: true, completion: nil)
    }
    
    
}

extension ExportSettingViewController:ColumnSelectionViewControllerDelegate{
    func updateColumnSelectionValues(columnSelectionValue: ColumnSelectionValue) {
        self.columnSelectionValue = columnSelectionValue
        var selectedColumns:[String] = []
        for column in columnSelectionValue.selectedColumn{
            selectedColumns.append(column.name)
        }
        
    }
    
    
}

extension ExportSettingViewController{
    
    func pushToPageVc(sourceView:UIView){
        let vc = PageSettingViewController()
        vc.delegate = self
        vc.valueForPageSetting = viewModel.pageSettings
        
        let navVC = UINavigationController(rootViewController: vc)
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            navVC.modalPresentationStyle = .popover
            navVC.popoverPresentationController?.sourceView = sourceView
            navVC.popoverPresentationController?.sourceRect = sourceView.bounds
            navVC.popoverPresentationController?.permittedArrowDirections = [.up, .down]
        }
        
        
        self.navigationController?.present(navVC, animated: true, completion: nil)
        
    }
    
    func pushToPassword(){
        let vc = PassWordSettingViewController()
        vc.delegate = self
        vc.value = viewModel.passwordSetting
        let navVC = UINavigationController(rootViewController: vc)
        self.navigationController?.present(navVC, animated: true, completion: nil)
        
    }
  
}

extension ExportSettingViewController : PageSettingViewControllerDelegate{
    func updatePageSettings(pageSettings: PageSettingValue) {
        self.viewModel.pageSettings = pageSettings
    }
    
    
}

extension ExportSettingViewController : PassWordSettingViewControllerDelegate{
    func updatePasswordValue(passwordValue: Passwords) {
        self.viewModel.passwordSetting = passwordValue
    }
    
    
}
