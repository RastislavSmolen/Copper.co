//
//  DysplayOrdersViewController.swift
//  Copper.co
//
//  Created by Rastislav Smolen on 19/09/2021.
//

import Foundation
import UIKit
import CoreData
class Cell: UITableViewCell {
    @IBOutlet var currencyTextLabel: UILabel!
    
}
class DisplayOrdersViewController : UIViewController, UITableViewDelegate {
    @IBOutlet var tableView: UITableView!
    var savedOrdersObject = [NSManagedObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        fetchCoreData()
    }
    private func fetchCoreData(){
        //1
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext =
          appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
          NSFetchRequest<NSManagedObject>(entityName: "SavedOrders")
        
        //3
        do {
            savedOrdersObject = try managedContext.fetch(fetchRequest)
            self.tableView.reloadData()
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}

extension DisplayOrdersViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        print(savedOrdersObject.count)
      return savedOrdersObject.count
    }

    func tableView(_ tableView: UITableView,cellForRowAt indexPath: IndexPath) -> UITableViewCell {

      let order = savedOrdersObject[indexPath.row]
      let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! Cell
        cell.currencyTextLabel.text =
        order.value(forKeyPath: "currency") as? String
      return cell
    }
    
}
