//
//  AutoFilterRouter.swift
//  DemoProject
//
//  Created by Karan Karthic Neelamegan on 21/10/21.
//

import UIKit

class AutoFilterRouter:AutoFilterPresenterToRouterProtocol{
    
    static func createModule() -> AutoFilterViewController{
        
        let view = AutoFilterViewController()
        
        let router = AutoFilterRouter()
        
        let presenter = AutoFilterPresenter()
        
        let interactor = AutoFilterIntractor()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor

        
        return view
    }
}
