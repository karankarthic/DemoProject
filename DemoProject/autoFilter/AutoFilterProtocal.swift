//
//  AutoFilterProtocal.swift
//  DemoProject
//
//  Created by Karan Karthic Neelamegan on 21/10/21.
//

import UIKit

protocol AutoFilterViewToPresenterProtocol: class{
    
    var view: AutoFilterPresenterToViewProtocol? {get set}
    var interactor: AutoFilterPresenterToInteractorProtocol? {get set}
    var router: AutoFilterPresenterToRouterProtocol? {get set}
   
    func viewDidLoad()
    func fetchFilterValuesForOption(section:Int)
    func fetchAndUpdateFliterValues(title:String)
}

protocol AutoFilterPresenterToViewProtocol: class
{
    func reloadUi(dataSource:AutoFilterDataSource)
}

protocol AutoFilterPresenterToRouterProtocol: class
{
    
}

protocol AutoFilterPresenterToInteractorProtocol: class {
    
    func getFilterValues() ->[FilterModel]
    func fetchAndUpdateFliterValues(title:String) -> [FilterModel]
    
}

protocol AutoFilterInteractorToPresenterProtocol: class {
    
}


class AutoFilterDataSource{
    
    var dataSourceModel:[AutoFilterModel] = []
    
    var numberOfSections:Int {
        
        return dataSourceModel.count
    }
    
    init() {
        dataSourceModel = [.init(title: "Bag Size", filterValues: [], isInCollapsedState: true),.init(title: "Brand", filterValues: [], isInCollapsedState: true)]
    }
    
    func getNumberOfRows(forSection index:Int) -> Int{
        if isItInCollapsedState(forSection:index){
            return 0
        }else{
            return 1
        }
    }
    
    func changeCollapsedState(forSection index:Int){
        dataSourceModel[index].isInCollapsedState = !dataSourceModel[index].isInCollapsedState
    }
    
//    func cellModel(forIndexpath indexPath:IndexPath) -> String{
//        return  dataSourceModel[indexPath.section].filterValues[indexPath.row].displaytext
//    }
    
    func updateFilterValues(for value:String,filtervalues:[FilterModel]){
        
        guard let indexOfValue = getIndexOfValue(value:value) else{ return }
        
        dataSourceModel[indexOfValue].filterValues.append(contentsOf: filtervalues)
        
    }
    
    func getCountOfSelectedItems(forSection section:Int) -> Int{
        var count = 0
        
        for item in dataSourceModel[section].filterValues{
            if item.isSelected {
                count = count + 1
            }
        }
        
        return count
    }
    
    func returnSectionTitle(forSection index:Int) -> String{
        return  dataSourceModel[index].title
    }
    
    func isItInCollapsedState(forSection section:Int) -> Bool{
        return dataSourceModel[section].isInCollapsedState
    }
    
    private func getIndexOfValue(value:String) -> Int?{
    
        for (index,item) in dataSourceModel.enumerated(){
            if item.title == value{
                return index
            }
        }
        
        return nil
    }
    
}


struct AutoFilterModel{
    let title:String
    var filterValues:[FilterModel]
    var isInCollapsedState:Bool
}

struct FilterModel{
    let displaytext:String
    var isSelected:Bool = false
}
