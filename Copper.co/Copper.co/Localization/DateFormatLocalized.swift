//
//  DateFormatLocalized.swift
//  Copper.co
//
//  Created by Rastislav Smolen on 20/09/2021.
//

import Foundation

enum DateLocalized: String {
    case dateFormat = "MMM dd,YYYY hh:mm a"
    case dateLocale = "UTC"
    func date() ->String { return self.rawValue }
}
