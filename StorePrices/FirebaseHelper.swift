//
//  FirebaseHelper.swift
//  StorePrices
//
//  Created by Julia Nikitina on 15/09/2018.
//  Copyright © 2018 Julia Nikitina. All rights reserved.
//

import Foundation
import Firebase

final class FirebaseHelper {
    
    lazy var db: Firestore = {
        let db = Firestore.firestore()
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
        return db
    }()
    
    static let shared = FirebaseHelper()
    
    
}
