//
//  Cell.swift
//  Copper.co
//
//  Created by Rastislav Smolen on 20/09/2021.
//

import Foundation
import UIKit
import CoreData

class Cell: UITableViewCell {

    @IBOutlet var currencyTextLabel: UILabel!
    @IBOutlet var createdAtTextLabel: UILabel!
    @IBOutlet var amountTextLabel: UILabel!
    @IBOutlet var statusTextLabel: UILabel!

    func setupWith(object:NSManagedObject){
        

        guard let currency = object.value(forKeyPath: OrderLocalized.currency.value()) as? String else { return }
        guard let currencyDouble =  Double(currency) else { return }
        let floorAmount = floor(currencyDouble * 10 ) / 1000.0

        let status = object.value(forKeyPath: OrderLocalized.orderStatus.value()) as? String

        let ammount = object.value(forKeyPath: OrderLocalized.amount.value()) as? String

        guard let dateString = object.value(forKeyPath: OrderLocalized.createdAt.value()) as? String else { return }

        let dateFormatter = DateFormatter()
        let dateDouble = Double(dateString)
        let date = Date(timeIntervalSinceReferenceDate: dateDouble!)

        dateFormatter.setLocalizedDateFormatFromTemplate(DateLocalized.dateFormat.date())
        dateFormatter.timeZone = NSTimeZone(abbreviation: DateLocalized.dateLocale.date()) as TimeZone?
        print(dateFormatter.string(from: date))

        currencyTextLabel.text = "\(floorAmount)"
        createdAtTextLabel.text = dateFormatter.string(from: date)
        amountTextLabel.text = ammount
        statusTextLabel.text = status
        }
    }
