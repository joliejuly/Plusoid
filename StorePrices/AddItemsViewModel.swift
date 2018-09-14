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
        FirebaseHelper.shared.db.collection("prices").getDocuments() { querySnapshot, error in
            if let err = error {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
        
        
    }
    
}
