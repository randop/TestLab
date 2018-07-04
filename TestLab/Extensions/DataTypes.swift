//
//  DataTypes.swift
//  TestLab
//
//  Created by Randolph on 6/17/18.
//  Copyright © 2018 Randolph. All rights reserved.
//

import Foundation

extension Float {
    
    func integerText() -> String {
        return String(Int(self))
    }
    
}

extension String {
    
    public var isEmail: Bool {
        /*
        @see http://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift
        */
        return range(of: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}",
                     options: .regularExpression, range: nil, locale: nil) != nil
    }
    
}

extension Data {
    mutating func append(_ string: String) {
        let data = string.data(
            using: String.Encoding.utf8,
            allowLossyConversion: true)
        append(data!)
    }
}
