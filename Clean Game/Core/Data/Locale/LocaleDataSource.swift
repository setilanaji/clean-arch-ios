//
//  LocaleDataSource.swift
//  Clean Game
//
//  Created by Yudha Setyaji on 2021/11/28.
//

import Foundation
import RealmSwift

protocol LocaleDataSourceProtocol: AnyObject {
    
}

final class LocaleDataSource: NSObject {
    private let realm: Realm?
    
    private init(realm: Realm?) {
        self.realm = realm
    }
    
    static let shared: (Realm?) -> LocaleDataSource = { realmDatabase in
        return LocaleDataSource(realm: realmDatabase)
    }
}

extension LocaleDataSource: LocaleDataSourceProtocol {
    
}
