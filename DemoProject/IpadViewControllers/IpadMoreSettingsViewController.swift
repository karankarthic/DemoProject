//
//  IpadMoreSettingsViewController.swift
//  DemoProject
//
//  Created by Karan Karthic Neelamegan on 25/03/21.
//

import UIKit

class IpadMoreSettingsViewController: UITableViewController {
    
    
    var delegateCalledCell:ExportOptionCustomaizingCell? = nil
    
    weak var delegate:MoreSettingsViewControllerDelegate?
    
    var valueForMoreSetting:MoreSettingsValueModel = MoreSettingsValueModel(margin: Margin(top: 10, left: 10, right: 10, bottom: 10), header: PagePositionValue(position: "Left", value: "Date"), footer: PagePositionValue(position: "Left", value: "Date"))

    
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
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))

        
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
            
            cell.configure(model:valueForMoreSetting.margin)
            cell.delegate = self
            return cell
        }
        else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as ExportOptionCustomaizingCell
            let model = ExportOptionCustomaizingCellModel(titleLabel: "Header", position: .header, subValuePickerOneViewtitle: "Position", subValuePickerOneViewvalue: valueForMoreSetting.header.position, subValuePickerTwoViewtitle: "Value", subValuePickerTwoViewvalue: valueForMoreSetting.header.value)
            cell.configure(model:model)
            cell.delegate = self
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as ExportOptionCustomaizingCell
            
            let model = ExportOptionCustomaizingCellModel(titleLabel: "Footer", position: .footer, subValuePickerOneViewtitle: "Position", subValuePickerOneViewvalue: valueForMoreSetting.footer.position, subValuePickerTwoViewtitle: "Value", subValuePickerTwoViewvalue: valueForMoreSetting.footer.value)
            
            cell.configure(model:model)
            
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
        
//         send back the moresettingvalues to the printSetting to be done here
        
        delegate?.updateMoreSettingValue(value:valueForMoreSetting)
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @objc private func cancel(){
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
}

extension IpadMoreSettingsViewController: PrinterOptionCustomaizingCellDelegate {
    
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



extension IpadMoreSettingsViewController: SelectViewControllerDelegate {
    
    func valueForMulitiSelect(valueForMulitiSelect: [String]) {
        
    }
    
    
    func valueForSingleSelect(value: String) {
        
        if delegateCalledCell?.position == .header{
            valueForMoreSetting.header.value = value
        }else{
            valueForMoreSetting.footer.value = value
        }
        
    }
    
}

extension IpadMoreSettingsViewController:MarginCellDelegate{
    func updateMargingcell(margin: Margin) {
        self.valueForMoreSetting.margin = margin
    }
    
    
}

