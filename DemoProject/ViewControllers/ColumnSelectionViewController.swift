//
//  ColumnSelectionViewController.swift
//  DemoProject
//
//  Created by Karan Karthic Neelamegan on 31/05/21.
//

import UIKit


protocol ColumnSelectionViewControllerDelegate : class{
    
    func updateColumnSelectionValues(columnSelectionValue:ColumnSelectionValue)
}

enum ColumnsFrom:String,CaseIterable{
    case allField = "All Fields"
    case quickView = "Quick View Fields"
    case detailView = "Detail View Fields"
    case selectedFields = "Selected Fields"
}

struct Column{
    let name:String
    let inQuickView:Bool
    let inDetailView:Bool
}

struct ColumnSelectionValue{
    var selectedType:ColumnsFrom
    var selectedColumn:[Column] = []
}

class ColumnSelectionViewController:CardLayoutTableViewController{
    
    weak var delegate:ColumnSelectionViewControllerDelegate?
    var columns:[Column] = [Column(name: "Karan", inQuickView: true, inDetailView: false),Column(name: "karthic", inQuickView: true, inDetailView: true)]
    
    private var selectedColumn:[Column] = []
    
    private var quicViewColumns:[Column] = []
    private var detailViewColumns:[Column] = []
    
    private var selectedColumnsIndexs:[Int] = []
    
    private var items:[SingleSelectModel] = []
    private var selectedValueItems:[SingleSelectModel] = []
    
    var selectedType:ColumnsFrom = .allField
    
    
    init(columns:[Column],columnSelectionValue:ColumnSelectionValue? = nil){
        super.init(nibName: nil, bundle: nil)
        
        makeIndividualColumns(columns:columns)
        if let columnSelectionValue = columnSelectionValue{
            
            selectedType = columnSelectionValue.selectedType
            selectedColumn = columnSelectionValue.selectedColumn
            
            updateSelectionValue()
            
        }else{
            makeSingleSelectModel()
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerReusableCell(SingleSelectCell.self)

//        tableView.separatorStyle = .none
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        
        self.navigationItem.title = "List Of Fields"

    }
    
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0{
        
            var modifiedItems:[SingleSelectModel] = []
            
            for (index,item) in items.enumerated(){
                var modifyingItem = item
                
                if index == indexPath.row{
                    
                    modifyingItem.isSelected = true
                    
                }
                else{
                    modifyingItem.isSelected = false
                }
                
                modifiedItems.append(modifyingItem)
            }
            
            items = modifiedItems
        
            self.selectedType = ColumnsFrom.allCases[indexPath.row]
            
            updateSelectedValueItems()
            
            self.tableView.reloadData()
            
        }else{
            
            var modifiedItems:[SingleSelectModel] = []
            
            for (index,item) in selectedValueItems.enumerated(){
                var modifyingItem = item
                
                if index == indexPath.row{
                    if selectedType == .selectedFields{
                        if modifyingItem.isSelected{
                            modifyingItem.isSelected = false
                            removeValueFromSelectedIndex(index:indexPath.row)
                        }else{
                            self.selectedColumnsIndexs.append(indexPath.row)
                            modifyingItem.isSelected = true
                        }
                    }else{
                        modifyingItem.isSelected = true
                    }
                    
                }
                modifiedItems.append(modifyingItem)
            }
            
            selectedValueItems = modifiedItems
            
            if selectedType == .selectedFields{
                self.tableView.reloadSections(IndexSet([indexPath.section]), with: .automatic)
            }
            
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0{
            
            return ColumnsFrom.allCases.count
            
        }else{
            return selectedValueItems.count
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as SingleSelectCell

            cell.setupView(cellModel:items[indexPath.row])

            return cell
        }
        if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as SingleSelectCell
            
            // give check img
            cell.radio = UIImage.init(named: "Image-1")?.withRenderingMode(.alwaysTemplate)
            
            cell.setupView(cellModel:selectedValueItems[indexPath.row])

            return cell
        }
        
        return UITableViewCell()
    }

    private func makeSingleSelectModel(){
        for (index,item) in ColumnsFrom.allCases.enumerated(){
            let singleSelect:SingleSelectModel
            if index == 0{
                singleSelect = SingleSelectModel(title: item.rawValue, cellType: .normal, valueType: .default, choiceTitleEnabled: .off, isSelected: true)
            }else{
                singleSelect = SingleSelectModel(title: item.rawValue , cellType: .normal, valueType:.default)
            }
            self.items.append(singleSelect)
        }
        
        for column in columns{
            
            let singleSelect = SingleSelectModel(title: column.name, cellType: .normal, valueType: .default, choiceTitleEnabled: .off, isSelected: true)
            
            self.selectedValueItems.append(singleSelect)
            
        }
    }
    
    private func updateSelectionValue(){
        for item in ColumnsFrom.allCases{
            let singleSelect:SingleSelectModel
            if selectedType == item{
                singleSelect = SingleSelectModel(title: item.rawValue, cellType: .normal, valueType: .default, choiceTitleEnabled: .off, isSelected: true)
            }else{
                singleSelect = SingleSelectModel(title: item.rawValue , cellType: .normal, valueType:.default)
            }
            self.items.append(singleSelect)
        }
        
        
        
        updateSelectedValueItems()

    }
    
    private func updateSelectedValueItems(){
        
        selectedColumnsIndexs.removeAll()
        selectedValueItems.removeAll()
        
        switch selectedType{

        case .allField:
            
            for column in columns{
                
                let singleSelect = SingleSelectModel(title: column.name, cellType: .normal, valueType: .default, choiceTitleEnabled: .off, isSelected: true)
                
                self.selectedValueItems.append(singleSelect)
                
            }
           
        case .quickView:
            for column in quicViewColumns{
                
                let singleSelect = SingleSelectModel(title: column.name, cellType: .normal, valueType: .default, choiceTitleEnabled: .off, isSelected: true)
                
                self.selectedValueItems.append(singleSelect)
                
            }
        case .detailView:
            for column in detailViewColumns{
                
                let singleSelect = SingleSelectModel(title: column.name, cellType: .normal, valueType: .default, choiceTitleEnabled: .off, isSelected: true)
                
                self.selectedValueItems.append(singleSelect)
                
            }
        case .selectedFields:
            if !selectedColumn.isEmpty{
                for item in selectedColumn{
                    for (columnIndex,column) in columns.enumerated(){
                        let singleSelect:SingleSelectModel
                        if column.name == item.name {
                            self.selectedColumnsIndexs.append(columnIndex)
                            singleSelect = SingleSelectModel(title: column.name, cellType: .normal, valueType: .default, choiceTitleEnabled: .off, isSelected: true)
                        }
                        else{
                            singleSelect = SingleSelectModel(title: column.name , cellType: .normal, valueType:.default)
                        }
                        self.selectedValueItems.append(singleSelect)
                    }
                }
            }else{
                for column in columns{
                    let singleSelect = SingleSelectModel(title: column.name, cellType: .normal, valueType: .default, choiceTitleEnabled: .off, isSelected: false)
                    self.selectedValueItems.append(singleSelect)
                }
                
                
                    
            }
        }
    }
    
    private func makeIndividualColumns(columns:[Column]){
        quicViewColumns.removeAll()
        detailViewColumns.removeAll()
        
        for column in columns{
            if column.inQuickView{
                quicViewColumns.append(column)
            }
            if column.inDetailView{
                detailViewColumns.append(column)
            }
        }
        
    }
    
     @objc private func done(){
        
        let columnselectionValue:ColumnSelectionValue
        
        switch selectedType{
        
        case .allField:
            columnselectionValue = ColumnSelectionValue(selectedType: .allField, selectedColumn: self.columns)
        case .quickView:
            columnselectionValue = ColumnSelectionValue(selectedType: .quickView, selectedColumn: self.quicViewColumns)
        case .detailView:
            columnselectionValue = ColumnSelectionValue(selectedType: .detailView, selectedColumn: self.detailViewColumns)
        case .selectedFields:
            var selected:[Column] = []
            for selectedIndex in self.selectedColumnsIndexs{
                for (index,column) in self.columns.enumerated(){
                    if selectedIndex == index{
                        selected.append(column)
                    }
                }
            }
            columnselectionValue = ColumnSelectionValue(selectedType: .selectedFields, selectedColumn: selected)
        }
        
        self.delegate?.updateColumnSelectionValues(columnSelectionValue: columnselectionValue)
        
    }
    
    private func removeValueFromSelectedIndex(index:Int){
        var modifiedIndexs:[Int] = []
        for selectedIndex in selectedColumnsIndexs{
            if index != selectedIndex{
                modifiedIndexs.append(selectedIndex)
            }
        }
        
        self.selectedColumnsIndexs = modifiedIndexs
    }
    
    
}
