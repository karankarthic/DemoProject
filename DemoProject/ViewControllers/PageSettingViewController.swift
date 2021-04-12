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

struct PageSettingValue {
    
    var pageSize:String
    var pageOrientation:String
    var columnWidth:String
    var margin : Margin
    var header :PagePositionValue
    var footer :PagePositionValue
    
    var optionSelectedForOrientation:ChoiceSelected = .choiceOne
    var optionSelectedForColumnWidth:ChoiceSelected = .choiceOne
    
}

class PageSettingViewController: CardLayoutTableViewController {
    
    var delegateCalledCell:ExportOptionCustomaizingCell? = nil
    
    weak var delegate :PageSettingViewControllerDelegate?
    
    var valueForPageSetting:PageSettingValue = PageSettingValue(pageSize: "A4", pageOrientation: "Portrait", columnWidth: "Actual", margin: Margin(top: 10, left: 10, right: 10, bottom: 10), header: PagePositionValue(position: "Left", value: "Date"), footer: PagePositionValue(position: "Left", value: "Date"))

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
    
    func numberOfSections(in tableView: UITableView) -> Int {
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
//            cell.delegate = self
            cell.onUpdateValue = { text in
                
                self.valueForPageSetting.pageSize = text
                
            }
            return cell
        }else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as PrintOptionSelectorViewCell
            let model = PrintOptionSelectorViewCellModel(optionViewTitle: "Page Orientation", optionViewConfigure: .orientation, optionViewSelectedChoice: valueForPageSetting.optionSelectedForColumnWidth, optionViewChoiceOneViewTitle: "Actual", optionViewChoiceTwoViewTitle: "Content based")
        
            cell.configure(model: model)
            cell.optionView.onUpdateValue = { (value,selectedOption) in
                
                self.valueForPageSetting.pageOrientation = value
                self.valueForPageSetting.optionSelectedForOrientation = selectedOption
            }
            cell.optionView.changeSelectionAsPerChoice()
            return cell
        }else if indexPath.section == 2{
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as PrintOptionSelectorViewCell
            
            let model = PrintOptionSelectorViewCellModel(optionViewTitle: "Column Width", optionViewConfigure: .columnWidth, optionViewSelectedChoice: valueForPageSetting.optionSelectedForColumnWidth, optionViewChoiceOneViewTitle: "Actual", optionViewChoiceTwoViewTitle: "Content based")
        
            cell.configure(model: model)
            cell.optionView.changeSelectionAsPerChoice()
            cell.optionView.onUpdateValue = { (value,selectedOption) in
                
                self.valueForPageSetting.columnWidth = value
                self.valueForPageSetting.optionSelectedForColumnWidth = selectedOption
            }
            
            return cell
        }else if indexPath.section == 3{
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as MarginCell

            cell.configure(model:valueForPageSetting.margin)
            cell.onUpdateValue = { margin in
                self.valueForPageSetting.margin = margin
            }
            return cell
        }
        else if indexPath.section == 4{
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as ExportOptionCustomaizingCell
            let model = ExportOptionCustomaizingCellModel(titleLabel: "Header", position: .header, subValuePickerOneViewtitle: "Position", subValuePickerOneViewvalue: valueForPageSetting.header.position, subValuePickerTwoViewtitle: "Value", subValuePickerTwoViewvalue: valueForPageSetting.header.value)
            cell.configure(model:model)
            cell.onUpdateValue = { text in
                self.valueForPageSetting.header.position = text
            }
            
            cell.toPushSelectVC = { cell in
                self.pushSelectVC(cell: cell)
            }
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as ExportOptionCustomaizingCell
            
            let model = ExportOptionCustomaizingCellModel(titleLabel: "Footer", position: .footer, subValuePickerOneViewtitle: "Position", subValuePickerOneViewvalue: valueForPageSetting.footer.position, subValuePickerTwoViewtitle: "Value", subValuePickerTwoViewvalue: valueForPageSetting.footer.value)
            
            cell.configure(model:model)
            
            cell.onUpdateValue = { text in
                self.valueForPageSetting.footer.position = text
            }
            
            cell.toPushSelectVC = { cell in
                self.pushSelectVC(cell: cell)
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
        
        
//         send back the moresettingvalues to the pageSetting done here
        delegate?.updatePageSettings(pageSettings:valueForPageSetting)
        
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @objc private func cancel(){
        
        self.dismiss(animated: true, completion: nil)
        
    }

}


extension PageSettingViewController {
//
//    func updateposition(position: String, inPosition: Position) {
//
//        if inPosition == .header{
//
//            valueForPageSetting.header.position = position
//        }else{
//
//            valueForPageSetting.footer.position = position
//        }
//    }
//
   private func pushSelectVC(cell: UITableViewCell?) {
        let selectModel = SelectCellModel(title: "Date", cellType: .normal, buttonType: .radio, choiceTitleEnabled: .off, isSelected: false)
        let selectModel1 = SelectCellModel(title: "Page Number", cellType: .normal, buttonType: .radio, choiceTitleEnabled: .off, isSelected: false)
        let selectModel2 = SelectCellModel(title: "Title", cellType: .title, buttonType: .radio, choiceTitleEnabled: .off, isSelected: false)

        self.delegateCalledCell = cell as? ExportOptionCustomaizingCell


        let vc = SelectViewController()
        vc.selectionType = .single
        vc.delegate = self
        vc.items = [selectModel,selectModel1,selectModel2]
        let valueForselectCell:String
        if delegateCalledCell?.position == .header{
            valueForselectCell = valueForPageSetting.header.value
        }else{
            valueForselectCell = valueForPageSetting.footer.value
        }
        vc.singleSelecteReview(value:valueForselectCell)
        let navVC = UINavigationController(rootViewController: vc)
        self.navigationController?.present(navVC, animated: true, completion: nil)


    }


}


extension PageSettingViewController: SelectViewControllerDelegate {
    
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

//extension PageSettingViewController: SinglePickerViewCellDelegate {
//    func updateSinglePickerValue(value: String) {
//        self.valueForPageSetting.pageSize = value
//
//    }
//
//}

//extension PageSettingViewController: PrintOptionSelectorViewCellDelegate {
//    func updateOptionSelectorViewValue(configure: Configure, value: String, selected: ChoiceSelected) {
//        if configure == .orientation{
//            valueForPageSetting.pageOrientation = value
//            valueForPageSetting.optionSelectedForOrientation = selected
//        }else{
//            valueForPageSetting.columnWidth = value
//            valueForPageSetting.optionSelectedForColumnWidth = selected
//        }
//    }
//
//}

//extension PageSettingViewController: MarginCellDelegate {
//
//    func updateMargingcell(margin: Margin) {
//        self.valueForPageSetting.margin = margin
//    }
//
//
//}
