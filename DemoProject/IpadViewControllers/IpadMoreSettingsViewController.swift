//
//  IpadMoreSettingsViewController.swift
//  DemoProject
//
//  Created by Karan Karthic Neelamegan on 25/03/21.
//

import UIKit

class IpadMoreSettingsViewController: UITableViewController {
    
    
    var headerPosition:String = ""
    var footerPosition:String = ""
    var headerValue:String = ""
    var footerValue:String = ""
    var marginValues:Margin = Margin(t: "10", l: "10", r: "10", b: "10")
    
    var delegateCalledCell:ExportOptionCustomaizingCell? = nil
    
    var valueForMoreSetting:MoreSettingsValueModel = MoreSettingsValueModel(margin: Margin(t: "10", l: "10", r: "10", b: "10"), header: PagePositionValue(position: "Left", value: "Date"), footer: PagePositionValue(position: "Left", value: "Date"))

    
    init(){
        super.init(style: .grouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerReusableCell(MarginCell.self)
        tableView.registerReusableCell(ExportOptionCustomaizingCell.self)
        tableView.allowsSelection = false
        
        self.navigationItem.title = "More Setting"
       
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as MarginCell
            cell.topTextField.text = valueForMoreSetting.margin.t
            cell.leftTextField.text = valueForMoreSetting.margin.l
            cell.rightTextField.text = valueForMoreSetting.margin.r
            cell.bottomTextField.text = valueForMoreSetting.margin.b
            cell.delegate = self
            return cell
        }
        else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as ExportOptionCustomaizingCell
            cell.titleLabel.text = "Header"
            cell.subValuePickerOneView.title.text = "Position"
            cell.subValuePickerOneView.valueTextField.text =  valueForMoreSetting.header.position
            
            cell.subValuePickerTwoView.title.text = "Value"
            cell.subValuePickerTwoView.valueTextField.text = valueForMoreSetting.header.value
            cell.delegate = self
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as ExportOptionCustomaizingCell
            cell.titleLabel.text = "Footer"
            cell.subValuePickerOneView.title.text = "Position"
            cell.subValuePickerOneView.valueTextField.text = valueForMoreSetting.footer.value
            
            cell.subValuePickerTwoView.title.text = "Value"
            cell.subValuePickerTwoView.valueTextField.text = valueForMoreSetting.footer.value
            cell.delegate = self
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 78
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "MARGIN ( ALL VALUES ARE IN MM )"
        }
        else if section == 1{
            
            return "HEADER"
        }
        else if section == 2{
            
            return "Footer"
            
        }else{
            return ""
        }
    }
    
    
    @objc private func done(){
        
        valueForMoreSetting = MoreSettingsValueModel(margin: self.marginValues, header: PagePositionValue(position: self.headerPosition, value: self.headerValue), footer: PagePositionValue(position: self.footerPosition, value: self.footerValue))
        
//         send back the moresettingvalues to the printSetting to be done here
        
        
        
        self.dismiss(animated: true, completion: nil)
        
    }
   
  
}

extension IpadMoreSettingsViewController:MarginCellDelegate{
    func updateMargingcell(margin: Margin) {
        self.marginValues = margin
    }
    
    
}

extension IpadMoreSettingsViewController: PrinterOptionCustomaizingCellDelegate {
    
    func updateposition(position: String, inPosition: String) {
        if inPosition == "Header"{
            headerPosition = position
        }else{
            footerPosition = position
        }
    }
    
    func pushSelectVC(cell:UITableViewCell?) {
        let selectModel = SelectCellModel(title: "Date", cellType: .normal, buttonType: .radio, choiceTitleEnabled: .off, isSelected: false)
        let selectModel1 = SelectCellModel(title: "Page Number", cellType: .normal, buttonType: .radio, choiceTitleEnabled: .off, isSelected: false)
        let selectModel2 = SelectCellModel(title: "Title", cellType: .title, buttonType: .radio, choiceTitleEnabled: .off, isSelected: false)
        
        
        
        let vc = SelectViewController()
        vc.selectionType = .single
        vc.items = [selectModel,selectModel1,selectModel2]
        let navVC = UINavigationController(rootViewController: vc)
        self.navigationController?.present(navVC, animated: true, completion: nil)
        
        self.delegateCalledCell = cell as? ExportOptionCustomaizingCell
        
    }
    
    
}

