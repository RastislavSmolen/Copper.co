//
//  Cell.swift
//  Copper.co
//
//  Created by Rastislav Smolen on 20/09/2021.
//

import Foundation
import UIKit

class Cell: UITableViewCell {

    @IBOutlet var currencyTextLabel: UILabel!
    @IBOutlet var createdAtTextLabel: UILabel!
    @IBOutlet var amountTextLabel: UILabel!
    @IBOutlet var statusTextLabel: UILabel!

    func setupWith(date:String)->String{
        let dateFormatter = DateFormatter()
        let dateDouble = Double(date)
        let date = Date(timeIntervalSinceReferenceDate: dateDouble!)
        
        dateFormatter.setLocalizedDateFormatFromTemplate(DateLocalized.dateFormat.date())
        dateFormatter.timeZone = NSTimeZone(abbreviation: DateLocalized.dateLocale.date()) as TimeZone?
        print(dateFormatter.string(from: date))
   
       return dateFormatter.string(from: date)
        }
    }
