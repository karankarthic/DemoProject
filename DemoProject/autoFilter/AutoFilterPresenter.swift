//
//  AutoFilterPresenter.swift
//  DemoProject
//
//  Created by Karan Karthic Neelamegan on 21/10/21.
//

import UIKit

class AutoFilterPresenter:AutoFilterViewToPresenterProtocol{
    
    var view: AutoFilterPresenterToViewProtocol?
    
    var interactor: AutoFilterPresenterToInteractorProtocol?
    
    var router: AutoFilterPresenterToRouterProtocol?
    
    var dataSource:AutoFilterDataSource = .init()
    
    
}

extension AutoFilterPresenter:AutoFilterInteractorToPresenterProtocol{
    
    func viewDidLoad(){
        view?.reloadUi(dataSource:self.dataSource)
    }
    
    func fetchFilterValuesForOption(section:Int){
        
        dataSource.changeCollapsedState(forSection: section)
        
        if dataSource.dataSourceModel[section].filterValues.isEmpty{
            let values = interactor?.getFilterValues() ?? []
            
            dataSource.dataSourceModel[section].filterValues = values
            
        }
       
        view?.reloadUi(dataSource:self.dataSource)
        
    }
    
    func fetchAndUpdateFliterValues(title: String) {
        
        let values = interactor?.fetchAndUpdateFliterValues(title: title) ?? []
        
        dataSource.updateFilterValues(for: title, filtervalues: values)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            
            self.view?.reloadUi(dataSource:self.dataSource)
        }
        
        
    }
    
    
}

