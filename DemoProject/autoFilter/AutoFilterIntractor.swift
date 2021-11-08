//
//  AutoFilterIntractor.swift
//  DemoProject
//
//  Created by Karan Karthic Neelamegan on 21/10/21.
//

import UIKit


class AutoFilterIntractor:AutoFilterPresenterToInteractorProtocol{
    
    func getFilterValues() -> [FilterModel] {
        
        return [.init(displaytext: "MonkeysRule", isSelected: false),.init(displaytext: "MonkeysRule", isSelected: false),.init(displaytext: "MonkeysRule", isSelected: false),.init(displaytext: "MonkeysRule", isSelected: false),.init(displaytext: "MonkeysRule", isSelected: false),.init(displaytext: "MonkeysRule", isSelected: false)]
//        return ["MonkeysRule", "RemoveMe", "SwiftRules","MonkeysRule", "RemoveMe", "SwiftRules","MonkeysRule", "RemoveMe", "SwiftRules","MonkeysRule", "RemoveMe", "SwiftRules","MonkeysRule", "RemoveMe", "SwiftRules"]
    }
    
    func fetchAndUpdateFliterValues(title: String) -> [FilterModel] {
        return [.init(displaytext: "new", isSelected: false),.init(displaytext: "new", isSelected: false),.init(displaytext: "new", isSelected: false),.init(displaytext: "new", isSelected: false),.init(displaytext: "new", isSelected: false),.init(displaytext: "newLast", isSelected: false)]
    }
    
    
}
