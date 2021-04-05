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

struct Margin {
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
    var header :PagePositionValue
    var footer :PagePositionValue
    
}

protocol MoreSettingsViewControllerDelegate:class {
    func updateMoreSettingValue(value:MoreSettingsValueModel)
}

class MoreSettingsViewController: CardLayoutTableViewController {

    
    var delegateCalledCell:ExportOptionCustomaizingCell? = nil
    
    weak var delegate:MoreSettingsViewControllerDelegate?

    var valueForMoreSetting:MoreSettingsValueModel = MoreSettingsValueModel(margin: Margin(top: 10, left: 10, right: 10, bottom: 10), header: PagePositionValue(position: "Left", value: "Date"), footer: PagePositionValue(position: "Left", value: "Date"))

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerReusableCell(MarginCell.self)
        tableView.registerReusableCell(ExportOptionCustomaizingCell.self)
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
            cell.topTextField.text = "\(valueForMoreSetting.margin.top)"
            cell.leftTextField.text = "\(valueForMoreSetting.margin.left)"
            cell.rightTextField.text = "\(valueForMoreSetting.margin.right)"
            cell.bottomTextField.text = "\(valueForMoreSetting.margin.bottom)"
            cell.delegate = self
            return cell
        }
        else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as ExportOptionCustomaizingCell
            cell.titleLabel.text = "Header"
            cell.position = .header
            cell.subValuePickerOneView.title.text = "Position"
            cell.subValuePickerOneView.valueTextField.text =  valueForMoreSetting.header.position
            
            cell.subValuePickerTwoView.title.text = "Value"
            cell.subValuePickerTwoView.valueTextField.text = valueForMoreSetting.header.value
            cell.delegate = self
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as ExportOptionCustomaizingCell
            cell.titleLabel.text = "Footer"
            cell.position = .footer
            cell.subValuePickerOneView.title.text = "Position"
            cell.subValuePickerOneView.valueTextField.text = valueForMoreSetting.footer.position
            
            cell.subValuePickerTwoView.title.text = "Value"
            cell.subValuePickerTwoView.valueTextField.text = valueForMoreSetting.footer.value
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
  
    
    @objc private func done(){
        
//        valueForMoreSetting = MoreSettingsValueModel(margin: self.marginValues, header: PagePositionValue(position: self.headerPosition, value: self.headerValue), footer: PagePositionValue(position: self.footerPosition, value: self.footerValue))
        
//         send back the moresettingvalues to the printSetting to be done here
        
        delegate?.updateMoreSettingValue(value:valueForMoreSetting)
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @objc private func cancel(){
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
}

extension MoreSettingsViewController: PrinterOptionCustomaizingCellDelegate {
    
    func updateposition(position: String, inPosition: Position) {
        if inPosition == .header{
            valueForMoreSetting.header.position = position
        }else{
            valueForMoreSetting.footer.position = position
        }
    }
    
    func pushSelectVC(cell:UITableViewCell?) {
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



extension MoreSettingsViewController: SelectViewControllerDelegate {
    
    func valueForMulitiSelect(valueForMulitiSelect: [String]) {
        
    }
    
    
    func valueForSingleSelect(value: String) {
        
        if delegateCalledCell?.position == .header{
            valueForMoreSetting.header.value = value
        }else{
            valueForMoreSetting.footer.value = value
        }
        self.tableView.reloadData()
    }
    
}

extension MoreSettingsViewController:MarginCellDelegate{
    func updateMargingcell(margin: Margin) {
        self.valueForMoreSetting.margin = margin
    }
    
    
}

