//
//  PageSettingViewController.swift
//  DemoProject
//
//  Created by Karan Karthic Neelamegan on 23/03/21.
//

import UIKit

protocol PageSettingViewControllerDelegate:class {
    func updatePageSettings(pageSettings:PageSettingValue)
}

struct PageSettingValue{
    
    var pageSize:String
    var pageOrientation:String
    var columnWidth:String
    var margin : Margin
    var header :PagePositionValue
    var footer :PagePositionValue
    
}

class PageSettingViewController: CardLayoutTableViewController {

    var headerPosition:String = "Left"
    var headerValue:String = "Date"
    var footerPosition:String = "Left"
    var footerValue:String = "Date"
    var pageSize:String = "A4"
    var pageOrientation:String = "Portrait"
    var columnWidth:String = "Actual"
    var marginValues:Margin = Margin(t: "10", l: "10", r: "10", b: "10")
    
    var delegateCalledCell:ExportOptionCustomaizingCell? = nil
    
    weak var delegate :PageSettingViewControllerDelegate?
    
    var valueForPageSetting:PageSettingValue = PageSettingValue(pageSize: "A4", pageOrientation: "Portrait", columnWidth: "Actual", margin: Margin(t: "10", l: "10", r: "10", b: "10"), header: PagePositionValue(position: "Left", value: "Date"), footer: PagePositionValue(position: "Left", value: "Date"))

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerReusableCell(SinglePickerViewCell.self)
        tableView.registerReusableCell(PrintOptionSelectorViewCell.self)
        tableView.registerReusableCell(MarginCell.self)
        tableView.registerReusableCell(ExportOptionCustomaizingCell.self)
        tableView.allowsSelection = false
        
        self.navigationItem.title = "Page Setting"
       
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        6
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as SinglePickerViewCell
            cell.fileNameView.title.text = "Page Size"
            cell.items = ["A4","A9"]
            cell.fileNameView.valueTextField.text = pageSize
            cell.delegate = self
            return cell
        }else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as PrintOptionSelectorViewCell
            cell.optionView.title.text = "Page Orientation"
            cell.optionView.choiceOneView.title.text = "Portrait"
            cell.optionView.choiceTwoView.title.text = "Landscape"
            cell.optionView.delegate = self
            return cell
        }else if indexPath.section == 2{
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as PrintOptionSelectorViewCell
            cell.optionView.title.text = "Column Width"
            cell.optionView.choiceOneView.title.text = "Actual"
            cell.optionView.choiceTwoView.title.text = "Content based"
            cell.optionView.delegate = self
            return cell
        }else if indexPath.section == 3{
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as MarginCell
            cell.topTextField.text = valueForPageSetting.margin.t
            cell.leftTextField.text = valueForPageSetting.margin.l
            cell.rightTextField.text = valueForPageSetting.margin.r
            cell.bottomTextField.text = valueForPageSetting.margin.b
            cell.delegate = self
            return cell
        }
        else if indexPath.section == 4{
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as ExportOptionCustomaizingCell
            cell.titleLabel.text = "Header"
            cell.subValuePickerOneView.title.text = "Position"
            cell.subValuePickerOneView.valueTextField.text =  headerPosition
            
            cell.subValuePickerTwoView.title.text = "Value"
            cell.subValuePickerTwoView.valueTextField.text = headerValue
            cell.delegate = self
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as ExportOptionCustomaizingCell
            cell.titleLabel.text = "Footer"
            cell.subValuePickerOneView.title.text = "Position"
            cell.subValuePickerOneView.valueTextField.text = footerPosition
            
            cell.subValuePickerTwoView.title.text = "Value"
            cell.subValuePickerTwoView.valueTextField.text = footerValue
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
        if section == 0 || section == 1{
            return 0
        }
        return 12
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 || section == 2{
            return 0
        }
        return 12
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        let viewConstructor = CornerViewConstructor.init(contentView: cell.contentView)
        
        if indexPath.section == 0 {
            viewConstructor.constructLayout(for: .topCorner)
        }else if indexPath.section == 1{
            
        }
        else if indexPath.section == 2{
            viewConstructor.constructLayout(for: .bottomCorner)
        }else{
            viewConstructor.constructLayout(for: .allCorner)
        }
        
        
    }
    
    @objc private func done(){
        
        valueForPageSetting = PageSettingValue(pageSize: self.pageSize, pageOrientation: self.pageOrientation, columnWidth: self.columnWidth, margin: self.marginValues, header: PagePositionValue(position: self.headerPosition, value: self.headerValue), footer: PagePositionValue(position: self.footerPosition, value: self.footerValue))

        
//         send back the moresettingvalues to the pageSetting done here
        delegate?.updatePageSettings(pageSettings:valueForPageSetting)
        
        
        self.dismiss(animated: true, completion: nil)
        
    }

}


extension PageSettingViewController: PrinterOptionCustomaizingCellDelegate {
  
    func updateposition(position: String, inPosition: String) {
        
        if inPosition == "Header"{
            headerPosition = position
        }else{
            footerPosition = position
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


extension PageSettingViewController: SelectViewControllerDelegate {
    
    func valueForMulitiSelect(valueForMulitiSelect: [String]) {
        
    }
    
    
    func valueForSingleSelect(value: String) {
        
        if delegateCalledCell?.titleLabel.text == "Header"{
            headerValue = value
        }else{
            footerValue = value
        }
        
        tableView.reloadData()
        
    }
    
}

extension PageSettingViewController: SinglePickerViewCellDelegate {
    func updateSinglePickerValue(value: String) {
        self.pageSize = value
    }

}

extension PageSettingViewController: PrintOptionSelectorViewCellDelegate {
    func updateOptionSelectorViewValue(title: String, value: String) {
        
        if title == "Page Orientation"{
            self.pageOrientation = value
        }else{
            self.columnWidth = value
        }
        
    }
    
    
}

extension PageSettingViewController: MarginCellDelegate {
    
    func updateMargingcell(margin: Margin) {
        self.marginValues = margin
    }
    

}
