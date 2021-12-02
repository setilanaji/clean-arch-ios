//
//  LocaleDataSource.swift
//  Clean Game
//
//  Created by Yudha Setyaji on 2021/11/28.
//

import Foundation
import RealmSwift
import RxSwift

protocol LocaleDataSourceProtocol: AnyObject {
    func updateFavoriteGame(
        from favorite: FavoriteEntity
    ) -> Observable<Bool>
    
    func getFavorites() -> Observable<[FavoriteEntity]>
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
    
    func updateFavoriteGame(
        from favorite: FavoriteEntity
    ) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let realm = self.realm {
                do {
                    try realm.write {
                        realm.add(favorite)
                        observer.onNext(true)
                        observer.onCompleted()
                    }
                } catch {
                    observer.onError(DatabaseError.requestFailed)
                }
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    func getFavorites() -> Observable<[FavoriteEntity]> {
        return Observable<[FavoriteEntity]>.create {  observer in
            if let realm = self.realm {
              let favorites: Results<FavoriteEntity> = {
                realm.objects(FavoriteEntity.self)
                  .sorted(byKeyPath: "name", ascending: true)
              }()
                observer.onNext(favorites.toArray(ofType: FavoriteEntity.self))
                observer.onCompleted()
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }

    }
}

extension Results {

  func toArray<T>(ofType: T.Type) -> [T] {
    var array = [T]()
    for index in 0 ..< count {
      if let result = self[index] as? T {
        array.append(result)
      }
    }
    return array
  }

}
