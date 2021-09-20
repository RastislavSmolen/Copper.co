//
//  ViewController.swift
//  Copper.co
//
//  Created by Rastislav Smolen on 18/09/2021.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    private var cachedOrders: [Orders] = []
    private var model : OrderListModel?
    private var savedOrdersObject: [NSManagedObject] = []

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

    private func loadData(order: [Orders]) {
        cachedOrders = order
    }

    private func writeLargeObject(orders:[Orders],completion: @escaping () -> Void) throws {
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

    private func createSpinnerView() {
        let child = SpinnerViewController()
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
    }

    @IBAction func download(_ sender: Any) {
        do {
            try writeLargeObject(orders: cachedOrders,completion: {[weak self] in
                self?.createSpinnerView()
                self?.performSegue(withIdentifier: SequeIdentifierLocalized.show.seque(), sender: nil)
            })
        } catch {
            print("Could not write the data")
        }
    }
}
