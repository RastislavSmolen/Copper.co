//
//  DysplayOrdersViewController.swift
//  Copper.co
//
//  Created by Rastislav Smolen on 19/09/2021.
//

import Foundation
import UIKit
import CoreData

class DisplayOrdersViewController : UIViewController, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    private var savedOrdersObject = [NSManagedObject]()
    private let vc = ViewController()

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

    private func fetchCoreData() {
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

   private func deleteCoreData() {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifierLocalized.cell.value()) as! Cell
        cell.currencyTextLabel.text =
            order.value(forKeyPath: OrderLocalized.currency.value()) as? String
        cell.amountTextLabel.text =
            order.value(forKeyPath: OrderLocalized.amount.value()) as? String
        cell.createdAtTextLabel.text = cell.setupWith(date: order.value(forKey: OrderLocalized.createdAt.value()) as? String ?? "N/A")
        cell.statusTextLabel.text =
            order.value(forKeyPath: OrderLocalized.orderStatus.value()) as? String
        return cell
    }
}
