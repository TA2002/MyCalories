//
//  String+Ext.swift
//  MyCalories
//
//  Created by Tarlan Askaruly on 17.05.2023.
//

import Foundation

extension String {
    
    var asUrl: URL? {
        return URL(string: self)
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
}
