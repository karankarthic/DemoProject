//
//  SelectViewController.swift
//  DemoProject
//
//  Created by Karan Karthic Neelamegan on 24/03/21.
//

import UIKit

enum SelectionType{
    case multi
    case single
}

protocol SelectViewControllerDelegate : class{
    func valueForSingleSelect(value:String)
    
    func valueForMulitiSelect(valueForMulitiSelect:[String])
}

class SelectViewController: UITableViewController {
    
    
    var items:[SelectCellModel] = []
    
    var selectionType:SelectionType = .single
    
    weak var delegate:SelectViewControllerDelegate?
    
    var valueForSingleSelect:String = ""
    
    var valueForMulitiSelect:[String] = []
    
    
    init(){
        if UIDevice.current.userInterfaceIdiom == .pad {
            super.init(style: .grouped)
        }else{
            super.init(style: .plain )
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerReusableCell(SelectCell.self)

//        tableView.separatorStyle = .none
        
        self.navigationItem.title = "List Of Columns"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))

        // Do any additional setup after loading the view.
        
        tableView.tableFooterView = UIView()
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if selectionType == .single{
            
            var modifiedItems:[SelectCellModel] = []
            
            for (index,item) in items.enumerated(){
                var modifyingItem = item
                
                if index == indexPath.row{
                    if modifyingItem.isSelected{
                        modifyingItem.isSelected = false
                        
                    }else{
                        modifyingItem.isSelected = true
                    }
                    
                    if modifyingItem.cellType == .title{
                        
                        if modifyingItem.choiceTitleEnabled == .off {
                            
                            modifyingItem.choiceTitleEnabled = .on
                        }else{
                            modifyingItem.choiceTitleEnabled = .off
                        }
                    }
                }
                else{
                    modifyingItem.isSelected = false
                    modifyingItem.choiceTitleEnabled = .off
                }
                
                modifiedItems.append(modifyingItem)
            }
            
            items = modifiedItems
            
        }else{
            
            if items[indexPath.row].isSelected {
                items[indexPath.row].isSelected = false
                let indexOfItem = valueForMulitiSelect.lastIndex(of:items[indexPath.row].title) ?? 0
                valueForMulitiSelect.remove(at: indexOfItem)
            }else{
                items[indexPath.row].isSelected = true
                valueForMulitiSelect.append(items[indexPath.row].title)
            }
            
        }
        
        self.tableView.reloadData()
        
    }
    
    func mulitSelectReview(){
     
        for value in valueForMulitiSelect{
            for (index,item) in items.enumerated(){
                if value == item.title {
                    items[index].isSelected = true
                    break
                }
            }
        }
    }
    
    func singleSelecteReview(value:String){
        for (index,item) in items.enumerated(){
            if value == item.title {
                items[index].isSelected = true
                break
            }
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(indexPath: indexPath) as SelectCell
        cell.setupView(cellModel:items[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 78
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if self.selectionType == .multi && UIDevice.current.userInterfaceIdiom == .pad{
            return "List Of Fields"
        }else{
            return ""
        }
        
    }
    
    
    @objc private func done(){
        
        if self.selectionType == .single{
            
            delegate?.valueForSingleSelect(value:valueForSingleSelect)
            
        }else{
            delegate?.valueForMulitiSelect(valueForMulitiSelect: self.valueForMulitiSelect)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func cancel(){
        
        self.dismiss(animated: true, completion: nil)
        
    }

}


extension SelectViewController: SelectCellDelegate {
    
    func valueUpdate(value: String) {
        
        valueForSingleSelect = value
        
    }
    
    
}
