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
    @IBOutlet var createdAtTextLabel: UILabel!
    @IBOutlet var amountTextLabel: UILabel!
    @IBOutlet var statusTextLabel: UILabel!
    func setupWith(date:String)->String{

        let dateFormatter = DateFormatter()
        let dateDouble = Double(date)
        let date = Date(timeIntervalSinceReferenceDate: dateDouble!)
        
        dateFormatter.setLocalizedDateFormatFromTemplate("MMM dd,YYYY hh:mm a")
        dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC") as TimeZone?
        print(dateFormatter.string(from: date))
   
       return dateFormatter.string(from: date)
        }
    }
extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
class DisplayOrdersViewController : UIViewController, UITableViewDelegate {
    @IBOutlet var tableView: UITableView!
    var savedOrdersObject = [NSManagedObject]()
    let vc = ViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        fetchCoreData()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        deleteCoreData()
    }
    private func fetchCoreData(){
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }
        let personFetchRequest: NSFetchRequest<SavedOrders> = SavedOrders.fetchRequest()
        let context = appDelegate.persistentContainer.viewContext
        let orders = try? context.fetch(personFetchRequest)
        guard let order = orders else {fatalError()}
        
        context.perform {
            self.tableView.reloadData()
        }
        savedOrdersObject = order
    }
    func deleteCoreData(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        for object in savedOrdersObject {
            context.delete(object)
        }
        do {
            try context.save()
        } catch{
            
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
        cell.amountTextLabel.text =
            order.value(forKeyPath: "amount") as? String
        cell.createdAtTextLabel.text = cell.setupWith(date: order.value(forKey: "createdAt") as? String ?? "na")
        print(order.value(forKey: "createdAt") as? String)
        cell.statusTextLabel.text =
            order.value(forKeyPath: "orderStatus") as? String
        return cell
    }
    
}
