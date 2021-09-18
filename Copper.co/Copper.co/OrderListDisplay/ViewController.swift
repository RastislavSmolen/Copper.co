//
//  ViewController.swift
//  Copper.co
//
//  Created by Rastislav Smolen on 18/09/2021.
//

import UIKit

class ViewController: UIViewController {

    var cachedOrders: [Orders] = []
    private var model : OrderListModel?

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
        for n in cachedOrders{
            print(n.orders.count)
        }
    }

}

