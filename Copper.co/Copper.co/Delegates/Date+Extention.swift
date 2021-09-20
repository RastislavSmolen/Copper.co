//
//  Date+Extention.swift
//  Copper.co
//
//  Created by Rastislav Smolen on 20/09/2021.
//

import Foundation
extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
