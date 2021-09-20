//
//  NetworkErrors.swift
//  Copper.co
//
//  Created by Rastislav Smolen on 18/09/2021.
//

import Foundation

enum NetworkError: Error {
    case parsingFailed(message: String)
    case errorWith(message: String)
    case networkNotAvailalbe
    case malformedURL(message: String)
    case malformedLocalizedJsonFile(message: String)
}

