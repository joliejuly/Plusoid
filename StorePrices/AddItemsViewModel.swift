//
//  AddItemsViewModel.swift
//  StorePrices
//
//  Created by Julia Nikitina on 15/09/2018.
//  Copyright © 2018 Julia Nikitina. All rights reserved.
//

import Foundation

final class AddItemsViewModel {
    
    var didFetchPrices: ( ([Int]) -> Void)?
    
    func fetchPrices() {
        FirebaseHelper.shared.db.collection("prices").getDocuments() { [weak self] querySnapshot, error in
            if let err = error {
                print("Error getting documents: \(err)")
            } else {
                var data: Any = ()
                
                for document in querySnapshot!.documents {
                    data = document.data()
                }
                
                if let dic = data as? NSDictionary,
                    let arr = dic["prices"] as? Array<Int> {
                    self?.didFetchPrices?(arr)
                    print(arr)
                }
            }
        }
    }
    
    func sendPrices(with prices: [Int]) {
        
    FirebaseHelper.shared.db.collection("prices").document("yqLiqtqDz5ZTJ9qtQyfX").updateData([
            "prices": prices
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
}
