//
//  ApiEndpoint.swift
//  Copper.co
//
//  Created by Rastislav Smolen on 18/09/2021.
//

import Foundation

enum APIEndpoitLocalized: String{
    case order = "https://assessments.stage.copper.co/ios/orders"
    func api() ->String { return self.rawValue }
}
