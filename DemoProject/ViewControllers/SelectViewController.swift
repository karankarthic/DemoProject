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
    func valueForSingleSelect()
    
    func valueForMulitiSelect()
}

class SelectViewController: UITableViewController {
    
    
    var items:[SelectCellModel] = []
    
    var selectionType:SelectionType = .single
    
    weak var delegate:SelectViewControllerDelegate?
    
    var valueForSingleSelect:String = ""
    
    var valueForMulitiSelect:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerReusableCell(SelectCell.self)

//        tableView.separatorStyle = .none
        
        self.navigationItem.title = "List Of Columns"
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
            }else{
                items[indexPath.row].isSelected = true
            }
            
        }
        
        self.tableView.reloadData()
        
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
    
    
    @objc private func done(){
        
        if self.selectionType == .single{
             
        }else{
            
        }
    }
    

}


extension SelectViewController: SelectCellDelegate {
    
    func valueUpdate(value: String) {
        
    }
    
    
}
