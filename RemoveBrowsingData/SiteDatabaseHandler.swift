//
//  SiteDatabaseHandler.swift
//  RemoveBrowsingData
//
//  Created by Aapo Rautiainen on 19/02/2019.
//  Copyright © 2019 Aapo Rautiainen. All rights reserved.
//

import Foundation

class SiteDatabaseHandler: HandlerBase {
    let _databaseFolder = "Library/Safari/Databases"

    override init(whitelisted: [String]) {
        super.init(whitelisted: whitelisted)
    }
    
    func removeDatabases() {
        super.removeFromDirectory(isAbsolute: false, from: _databaseFolder, with: nil)
    }
}
