//
//  OrderListMockAPILocalized.swift
//  Copper.coTests
//
//  Created by Rastislav Smolen on 20/09/2021.
//

import Foundation

enum MockAPIEndpoitLocalized: String{
    case mockJson = "OrderListMockData"
    func api() ->String { return self.rawValue }
}
