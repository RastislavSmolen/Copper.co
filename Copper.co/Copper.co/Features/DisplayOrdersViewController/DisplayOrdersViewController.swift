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
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
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

        let personFetchRequest: NSFetchRequest<SavedOrders> = SavedOrders.fetchRequest()
        let context = appDelegate.persistentContainer.viewContext
        let orders = try? context.fetch(personFetchRequest)
        guard let order = orders else { return }

        context.perform {
            self.tableView.reloadData()
        }
        savedOrdersObject = order
    }
    
    private func deleteCoreData() {

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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedOrdersObject.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let order = savedOrdersObject[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifierLocalized.cell.value()) as! Cell

        cell.setupWith(object : order)

        return cell
    }
}
