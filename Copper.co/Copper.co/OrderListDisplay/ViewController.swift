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
    var managedObjectContext : NSManagedObjectContext?
    var savedOrdersObject: [NSManagedObject] = []
    let group = DispatchGroup()

    override func viewDidLoad() {
        super.viewDidLoad()
        model = OrderListModel()
        fetchData()
    }

    private func fetchData(){
        group.enter()
        model?.fetchData { [weak self] (cachedOrders,err) in
            guard let cachedOrders = cachedOrders else { return }
            
            self?.loadData(order: cachedOrders)
        }
        
    }
    func loadData(order: [Orders]) {
        cachedOrders = order
    }
    func save(orders: [Orders]) {
      
      guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
        return
      }
      
      // Create context
      let managedContext = appDelegate.persistentContainer.viewContext
      
      // Create entity
      let entity = NSEntityDescription.entity(forEntityName: "SavedOrders", in: managedContext)!
      
      let savedObject = NSManagedObject(entity: entity, insertInto: managedContext)
      
      // Map object to saved object
        for orders in orders {
            for order in orders.orders {
                savedObject.setValue(order.orderId, forKeyPath: "orderID")
                savedObject.setValue(order.currency.rawValue, forKeyPath: "currency")
                savedObject.setValue(order.amount, forKeyPath: "amount")
                savedObject.setValue(order.orderType.rawValue, forKeyPath: "orderType")
                savedObject.setValue(order.orderStatus.rawValue, forKeyPath: "orderStatus")
                savedObject.setValue(order.createdAt, forKeyPath: "createdAt")
            }
        }
      
      // Save data to managedContext
      do {
        try managedContext.save()
        self.savedOrdersObject.append(savedObject)
        self.performSegue(withIdentifier: "show", sender: nil)
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    }
    @IBAction func download(_ sender: Any) {
       save(orders: cachedOrders)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? DisplayOrdersViewController {
            viewController.savedOrdersObject = savedOrdersObject
        }
    }
    
}
