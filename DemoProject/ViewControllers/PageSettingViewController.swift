//
//  PageSettingViewController.swift
//  DemoProject
//
//  Created by Karan Karthic Neelamegan on 23/03/21.
//

import UIKit

enum SingleSelectValues{
    
}

struct PositionValues{
    let position:PositionOpiton
    let type:String
    var value:String?
    var positionValue:SingleSelectValue? = nil
}

protocol PageSettingViewControllerDelegate:class {
    func updatePageSettings(pageSettings:PageSettingValue)
}

struct PageSettingValue {
    
    var pageSize:String
    var pageOrientation:String
    var columnWidth:ColumnWidthValue
    var margin : Margin
    var header :[PositionValues]
    var footer :[PositionValues]
    
    var optionSelectedForOrientation:ChoiceSelected = .choiceOne
    var optionSelectedForColumnWidth:ChoiceSelected = .choiceOne
    
}

class PageSettingViewController: CardLayoutTableViewController {
    
    private var delegateCalledCell:ExportPositionOpitonCell? = nil
    private var position:PositionOpiton? = nil
    
    weak var delegate :PageSettingViewControllerDelegate?
    
    var valueForPageSetting:PageSettingValue = PageSettingValue(pageSize: "A4", pageOrientation: "Portrait", columnWidth: .actual, margin: Margin(top: 10, left: 10, right: 10, bottom: 10), header:[ PositionValues(position: .left, type: "Date", value: "System Date"),PositionValues(position: .center, type: "Date", value: "System Date"),PositionValues(position: .right, type: "Date", value: "System Date")], footer: [ PositionValues(position: .left, type: "Date", value: "System Date"),PositionValues(position: .center, type: "Date", value: "System Date"),PositionValues(position: .right, type: "Date", value: "System Date")])

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerReusableCell(SinglePickerViewCell.self)
        tableView.registerReusableCell(PrintOptionSelectorViewCell.self)
        tableView.registerReusableCell(ColumnWidthSelectorCell.self)
        tableView.registerReusableCell(MarginCell.self)
        tableView.registerReusableCell(ExportPositionOpitonCell.self)
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
            let model = PrintOptionSelectorViewCellModel(optionViewTitle: "Page Orientation", optionViewConfigure: .orientation, optionViewSelectedChoice: valueForPageSetting.optionSelectedForColumnWidth, optionViewChoiceOneViewTitle: "Portrait", optionViewChoiceTwoViewTitle: "LandScape")
        
            cell.configure(model: model)
            cell.optionView.onUpdateValue = { (value,selectedOption) in
                
                self.valueForPageSetting.pageOrientation = value
                self.valueForPageSetting.optionSelectedForOrientation = selectedOption
            }
            cell.optionView.changeSelectionAsPerChoice()
            return cell
        }else if indexPath.section == 2{
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as ColumnWidthSelectorCell
            
            let model = ColumnWidthSelectorCellModel(title: "Column Width", selectedValue: valueForPageSetting.columnWidth)
            cell.configue(model: model)
            
            cell.reloadUiForScaling = {
                
                self.tableView.reloadData()
                
            }
            
            cell.updateValue = { value in
                
                self.valueForPageSetting.columnWidth = value
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
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as ExportPositionOpitonCell
            var left:String = "Select"
            var center:String = "Select"
            var right:String = "Select"
            
            for value in valueForPageSetting.header{
                if value.positionValue != nil {
                    if value.position == .left{
                        left = value.value ?? ""
                        
                    }
                    if value.position == .center
                    {
                        center = value.value ?? ""
                        
                    }
                    if value.position == .right{
                        right = value.value ?? ""
                        
                    }
                }
            }
            
            let model = ExportPositionOpitonCellModel(position: .header, titleLabel: "Header", left: left, right: right, center: center)
            

            cell.configue(model:model)

            cell.toPushSelectVC = { cell,position in
                self.pushSelectVC(cell: cell, position: position)
            }
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as ExportPositionOpitonCell
            var left:String = "Select"
            var center:String = "Select"
            var right:String = "Select"
            
            for value in valueForPageSetting.footer{
                if value.positionValue != nil {
                    if value.position == .left{
                        left = value.value ?? ""
                        
                    }
                    if value.position == .center
                    {
                        center = value.value ?? ""
                        
                    }
                    if value.position == .right{
                        right = value.value ?? ""
                        
                    }
                }
            }
            
            let model = ExportPositionOpitonCellModel(position: .footer, titleLabel: "Footer", left: left, right: right, center: center)
            
            cell.configue(model:model)
            
            cell.toPushSelectVC = { cell,position in
                self.pushSelectVC(cell: cell, position: position)
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

    private func pushSelectVC(cell: UITableViewCell?,position:PositionOpiton) {

        self.delegateCalledCell = cell as? ExportPositionOpitonCell
        self.position = position

        let vc = SelectViewController()
        vc.delegate = self
        var valueForselectCell:SingleSelectValue?
        
        
        if delegateCalledCell?.position == .header{
            for value in valueForPageSetting.header{
                if value.position == position{
                    valueForselectCell = value.positionValue
                }
            }
        }else{
            for value in valueForPageSetting.footer{
                if value.position == position{
                    valueForselectCell = value.positionValue
                }
            }
            
        }
        vc.singleSelecteReview(value:valueForselectCell)
        let navVC = UINavigationController(rootViewController: vc)
        self.navigationController?.present(navVC, animated: true, completion: nil)


    }


}


extension PageSettingViewController: SelectViewControllerDelegate {
    
    func valueForSingleSelect(value: SingleSelectValue?) {
        

        let positionValue:String?

        switch value {
    
        case .date:
            positionValue = "System Date"
        case .pageNumber:
            positionValue = "page Number"
        case .title(titleValue: let titleValue):
            positionValue = titleValue ?? ""
        case .none:
            positionValue = nil
        case .some(.default):
            positionValue = nil
        }
        
        if delegateCalledCell?.position == .header{
            
            for (index,valueOfHeader) in valueForPageSetting.header.enumerated(){
                if valueOfHeader.position == position{
                    valueForPageSetting.header[index].value = positionValue
                    valueForPageSetting.header[index].positionValue = value
                }
            }
        }else{
            for (index,valueOfFooter) in valueForPageSetting.footer.enumerated(){
                if valueOfFooter.position == position{
                    valueForPageSetting.footer[index].value = positionValue
                    valueForPageSetting.footer[index].positionValue = value
                }
            }
            
        }
        
        
        
        self.tableView.reloadData()
    }
    
}


