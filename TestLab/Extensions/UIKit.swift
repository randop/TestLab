//
//  UIKit.swift
//  TestLab
//
//  Created by Randolph on 6/26/18.
//  Copyright © 2018 Randolph. All rights reserved.
//

import UIKit

extension UIColor {
    class func getRandomColor() -> UIColor {
        let randomRed:CGFloat = CGFloat(drand48())
        let randomGreen:CGFloat = CGFloat(drand48())
        let randomBlue:CGFloat = CGFloat(drand48())
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
}

extension UITextField {
    public var trimmedText: String {
        if let value = text {
            return value.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        return ""
    }
}
