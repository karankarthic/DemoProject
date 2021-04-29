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
    func valueForSingleSelect(value:SingleSelectValue?)
    
//    func valueForMulitiSelect(valueForMulitiSelect:[String])
}

class SelectViewController: UITableViewController {
    
    
    var items:[SingleSelectModel] = [SingleSelectModel(title: "Date", cellType: .normal, valueType: .date),SingleSelectModel(title: "Page Number", cellType: .normal, valueType: .pageNumber),SingleSelectModel(title: "Title", cellType: .title, valueType: .title(titleValue: nil))]
    
//    var selectionType:SelectionType = .single
    
    weak var delegate:SelectViewControllerDelegate?
    
    var valueForSingleSelect:SingleSelectValue? = nil
    
    
    
    
    init(){
//        if UIDevice.current.userInterfaceIdiom == .pad {
//            super.init(style: .grouped)
//        }else{
            super.init(style: .plain )
//        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerReusableCell(SingleSelectCell.self)

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
        
//        if selectionType == .single{
//
            var modifiedItems:[SingleSelectModel] = []
            
            for (index,item) in items.enumerated(){
                var modifyingItem = item
                
                if index == indexPath.row{
                    if modifyingItem.isSelected{
                        modifyingItem.isSelected = false
                        valueForSingleSelect = nil
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
        
        self.tableView.reloadData()
        
    }
    
    func singleSelecteReview(value:SingleSelectValue?){
        guard let selectedValue = value else {
            return
        }
        for (index,item) in items.enumerated(){
            
            if selectedValue == item.valueType {
                items[index].isSelected = true
                items[index].valueType = selectedValue
                valueForSingleSelect = value
                break
            }
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(indexPath: indexPath) as SingleSelectCell
        cell.setupView(cellModel:items[indexPath.row])
        
        cell.valueUpdate = { value in
            
            self.valueForSingleSelect = value
            
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 78
    }
    
    
    @objc private func done(){
        
            
            delegate?.valueForSingleSelect(value:valueForSingleSelect)
            

        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func cancel(){
        
        self.dismiss(animated: true, completion: nil)
        
    }

}
