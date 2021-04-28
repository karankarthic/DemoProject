//
//  MoreSettingsViewControllerViewController.swift
//  DemoProject
//
//  Created by Karan Karthic Neelamegan on 24/03/21.
//

import UIKit

enum Position{
    case header
    case footer
}

struct Margin:Codable {
    var top :Int
    var left :Int
    var right :Int
    var bottom :Int
}

struct PagePositionValue {

    var position :String
    var value:String
}

struct MoreSettingsValueModel{
    
    var margin : Margin
    var header :[PositionValues]
    var footer :[PositionValues]
    
}

protocol MoreSettingsViewControllerDelegate:class {
    func updateMoreSettingValue(value:MoreSettingsValueModel)
}

class MoreSettingsViewController: CardLayoutTableViewController {

    
    var delegateCalledCell:ExportPositionOpitonCell? = nil
    private var position:PositionOpiton? = nil
    
    weak var delegate:MoreSettingsViewControllerDelegate?

    var valueForMoreSetting:MoreSettingsValueModel = MoreSettingsValueModel(margin: Margin(top: 10, left: 10, right: 10, bottom: 10), header:[ PositionValues(position: .left, type: "Date", value: "System Date"),PositionValues(position: .center, type: "Date", value: "System Date"),PositionValues(position: .right, type: "Date", value: "System Date")], footer: [ PositionValues(position: .left, type: "Date", value: "System Date"),PositionValues(position: .center, type: "Date", value: "System Date"),PositionValues(position: .right, type: "Date", value: "System Date")])

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerReusableCell(MarginCell.self)
        tableView.registerReusableCell(ExportPositionOpitonCell.self)
        tableView.allowsSelection = false
        
        self.navigationItem.title = "More Setting"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))

        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as MarginCell
            cell.configure(model:valueForMoreSetting.margin)
            cell.onUpdateValue = { margin in
                self.valueForMoreSetting.margin = margin
            }
            return cell
        }
        else if indexPath.section == 1{
            
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as ExportPositionOpitonCell
            var left:String = "Select"
            var center:String = "Select"
            var right:String = "Select"
            
            for value in valueForMoreSetting.header{
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
            
            for value in valueForMoreSetting.footer{
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
            
            let model = ExportPositionOpitonCellModel(position: .footer, titleLabel: "Header", left: left, right: right, center: center)
            

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
       
        return 12
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       
        return 12
    }
  
    
    @objc private func done(){
        
//         send back the moresettingvalues to the printSetting to be done here
        
        delegate?.updateMoreSettingValue(value:valueForMoreSetting)
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @objc private func cancel(){
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
}

extension MoreSettingsViewController {

    func pushSelectVC(cell:UITableViewCell?,position:PositionOpiton) {

        self.delegateCalledCell = cell as? ExportPositionOpitonCell
        self.position = position

        let vc = SelectViewController()
        vc.delegate = self
        var valueForselectCell:SingleSelectValue?
        
        
        if delegateCalledCell?.position == .header{
            for value in valueForMoreSetting.header{
                if value.position == position{
                    valueForselectCell = value.positionValue
                }
            }
        }else{
            for value in valueForMoreSetting.footer{
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



extension MoreSettingsViewController: SelectViewControllerDelegate {
    
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
        }
        
        if delegateCalledCell?.position == .header{
            
            for (index,valueOfHeader) in valueForMoreSetting.header.enumerated(){
                if valueOfHeader.position == position{
                    valueForMoreSetting.header[index].value = positionValue
                    valueForMoreSetting.header[index].positionValue = value
                }
            }
        }else{
            for (index,valueOfFooter) in valueForMoreSetting.footer.enumerated(){
                if valueOfFooter.position == position{
                    valueForMoreSetting.footer[index].value = positionValue
                    valueForMoreSetting.footer[index].positionValue = value
                }
            }
            
        }
        
        self.tableView.reloadData()
    }
    
}
