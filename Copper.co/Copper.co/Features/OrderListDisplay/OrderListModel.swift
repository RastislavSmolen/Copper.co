//
//  OrderListModel.swift
//  Copper.co
//
//  Created by Rastislav Smolen on 18/09/2021.
//

import Foundation
import CoreData
import UIKit

class OrderListModel {

    var networking: NetworkingProtoccol
    var order = [Orders]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    init(networking : NetworkingProtoccol = Networking()) {
        self.networking = networking
    }

    func fetchData(completion: @escaping ((_ data: [Orders]?,_ err: String?) -> Void)) {

        guard let url = URL(string: APIEndpoitLocalized.order.api()) else { return }
        networking.fetchData(url: url, type: Orders.self){ (result) in
            switch result {
            case.success(let response): completion( [response], nil )
            case.failure(let error): completion( nil, error.localizedDescription )
                DispatchQueue.main.async {
                    print(error)
                }
            }
        }
    }

    func saveToCoreData(orders:[Orders],completion: @escaping () -> Void) throws {

        let context = appDelegate.persistentContainer.newBackgroundContext()
        context.automaticallyMergesChangesFromParent = true
        context.perform {
            for orders in orders {
                for order in orders.orders {
                    let savedObject = SavedOrders(context: context)
                    savedObject.currency = order.currency.rawValue
                    savedObject.createdAt = order.createdAt
                    savedObject.amount = order.amount
                    savedObject.orderStatus = order.orderStatus.rawValue
                }
            }
            do {
                try context.save()
                DispatchQueue.main.async {
                    completion()
                }
            } catch {
            }
        }
    }
    
}
