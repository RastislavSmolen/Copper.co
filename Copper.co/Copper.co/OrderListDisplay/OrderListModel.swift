//
//  OrderListModel.swift
//  Copper.co
//
//  Created by Rastislav Smolen on 18/09/2021.
//

import Foundation
class OrderListModel {

    var networking: NetworkingProtoccol
    var order = [Orders]()
    init(networking : NetworkingProtoccol = Networking()) {
        self.networking = networking
    }

    func fetchData(completion: @escaping ((_ data: [Orders]?,_ err: String?) -> Void)) {
        guard let url = URL(string: APIEndpoit.order.api()) else { return }
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

}
