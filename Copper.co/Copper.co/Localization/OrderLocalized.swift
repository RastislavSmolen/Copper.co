//
//  OrderEnum.swift
//  Copper.co
//
//  Created by Rastislav Smolen on 20/09/2021.
//

import Foundation

enum OrderLocalized: String {
    case currency = "currency"
    case amount = "amount"
    case createdAt = "createdAt"
    case orderStatus = "orderStatus"
    func value() ->String { return self.rawValue }
}
