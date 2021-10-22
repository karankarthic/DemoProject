//
//  AutoFilterIntractor.swift
//  DemoProject
//
//  Created by Karan Karthic Neelamegan on 21/10/21.
//

import UIKit


class AutoFilterIntractor:AutoFilterPresenterToInteractorProtocol{
    
    func getFilterValues() -> [String] {
        
        return ["MonkeysRule", "RemoveMe", "SwiftRules"]
    }
    
    
}
