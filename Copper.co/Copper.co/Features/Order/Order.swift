//
//  Order.swift
//  Copper.co
//
//  Created by Rastislav Smolen on 18/09/2021.
//

import Foundation

// MARK: - Orders
struct Orders: Codable {
    let orders: [Order]
}

// MARK: - Order
struct Order: Codable {
    let orderId: String
    let currency: Currency
    let amount: String
    let orderType: OrderType
    let orderStatus: OrderStatus
    let createdAt: String
}

enum Currency: String, Codable {
    case algo = "ALGO"
    case bsc = "BSC"
    case btc = "BTC"
    case dash = "DASH"
    case doge = "DOGE"
    case eos = "EOS"
    case eth = "ETH"
    case mob = "MOB"
    case xrp = "XRP"
}

enum OrderStatus: String, Codable {
    case approved = "approved"
    case canceled = "canceled"
    case executed = "executed"
    case processing = "processing"
}

enum OrderType: String, Codable {
    case buy = "buy"
    case deposit = "deposit"
    case sell = "sell"
    case withdraw = "withdraw"
}

//MARK: Json object for reference

//    "orderId":"35302977cd484d2fcbe8dd594de862fb",
//    "currency":"DOGE",
//    "amount":"583.039692",
//    "orderType":"buy",
//    "orderStatus":"canceled",
//    "createdAt":"1608894113071
    
