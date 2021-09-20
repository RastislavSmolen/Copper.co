//
//  ViewController.swift
//  Copper.co
//
//  Created by Rastislav Smolen on 18/09/2021.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var cachedOrders: [Orders] = []
    private var model : OrderListModel?
    var savedOrdersObject: [NSManagedObject] = []
    let group = DispatchGroup()
    override func viewDidLoad() {
        super.viewDidLoad()
        model = OrderListModel()
        fetchData()
    }
    
    private func fetchData(){
        model?.fetchData { [weak self] (cachedOrders,err) in
            guard let cachedOrders = cachedOrders else { return }
            self?.loadData(order: cachedOrders)
        }
        
    }
    func loadData(order: [Orders]) {
        cachedOrders = order
        
    }
    func writeLargeObject(orders:[Orders],completion: @escaping () -> Void) throws {
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
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
    @IBAction func download(_ sender: Any) {
        do {
            try writeLargeObject(orders: cachedOrders,completion: {[weak self] in
                
            })
        } catch {
            print("Could not write the data")
        }
        performSegue(withIdentifier: "show", sender: nil)
        
    }
}
