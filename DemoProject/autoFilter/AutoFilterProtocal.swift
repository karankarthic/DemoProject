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
}

protocol AutoFilterPresenterToViewProtocol: class
{
    func reloadUi(dataSource:AutoFilterDataSource)
}

protocol AutoFilterPresenterToRouterProtocol: class
{
    
}

protocol AutoFilterPresenterToInteractorProtocol: class {
    
    func getFilterValues() ->[String]
    
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
    
    func cellModel(forIndexpath indexPath:IndexPath) -> String{
        return  dataSourceModel[indexPath.section].filterValues[indexPath.row]
    }
    
    func returnSectionTitle(forSection index:Int) -> String{
        return  dataSourceModel[index].title
    }
    
    func isItInCollapsedState(forSection section:Int) -> Bool{
        return dataSourceModel[section].isInCollapsedState
    }
    
}


struct AutoFilterModel{
    let title:String
    var filterValues:[String]
    var isInCollapsedState:Bool
}
