//
//  RemoteManager.swift
//  Clean Game
//
//  Created by Yudha Setyaji on 2021/11/9.
//

import Foundation
import Alamofire
import RxAlamofire
import RxSwift

protocol RemoteManagerProtocol {
    var session: Alamofire.Session { get }
    var requestQueue: DispatchQueue { get }
    var disposeBag: DisposeBag { get }
    
    func call<T>(type: Endpoint, completion: @escaping (Result<T, APIError>) -> Void ) where T: Codable
    
    func call<T>(type: Endpoint, completion: @escaping (Result<BaseResponse<T>, APIError>) -> Void ) where T: Codable
}

final class RemoteManager: RemoteManagerProtocol {
    var session: Session
    var requestQueue: DispatchQueue
    var disposeBag: DisposeBag
    
    init(
        session: Session,
        requestQueue: DispatchQueue = DispatchQueue(label: "com.ydhstj.cleangame.alamofireQueue"),
        disposeBag: DisposeBag = DisposeBag()
    ) {
        self.session = session
        self.requestQueue = requestQueue
        self.disposeBag = disposeBag
    }
    
    private static let remoteManager: RemoteManager = {
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForResource = 30
        configuration.timeoutIntervalForRequest = 60
        configuration.waitsForConnectivity = true
        
        let networkLogger = RemoteLogger()
        
        return RemoteManager(
            session: Session(
                configuration: configuration,
                delegate: SessionDelegate(),
                startRequestsImmediately: true,
                eventMonitors: [networkLogger]
            ))
    }()
    
    class func sharedInstance() -> RemoteManager {
        return remoteManager
    }
    
    func call<T>(
        type: Endpoint,
        completion: @escaping (Result<T, APIError>) -> Void
    ) where T : Decodable, T : Encodable {
        self.session.rx
            .request(type.httpMethod, type.url, parameters: type.parameters, encoding: type.encoding, headers: type.headers, interceptor: nil)
            .responseData()
            .expectingObject(ofType: T.self)
            .subscribe(onNext: { result in
                switch result {
                case let .failure(error):
                    completion(.failure(error))
                case let .success(response):
                    completion(.success(response))
                }
            }, onError: { err in
                switch err.asAFError(orFailWith: "Terjadi kesalahan") {
                case .requestRetryFailed(let error, _):
                    completion(.failure(error as! APIError))
                default:
                    completion(.failure(.unknownError(message: "")))
                }
            }).disposed(by: disposeBag)
    }
    
    func call<T>(
        type: Endpoint,
        completion: @escaping (Result<BaseResponse<T>, APIError>) -> Void
    ) where T : Decodable, T : Encodable {
        self.session.rx
            .request(type.httpMethod, type.url, parameters: type.parameters, encoding: type.encoding, headers: type.headers, interceptor: nil)
            .responseData()
            .expectingObjectList(ofType: BaseResponse<T>.self)
            .subscribe(onNext: { apiResult in
                switch apiResult {
                case let .failure(error):
                    completion(.failure(error))
                case  let .success(response):
                    completion(.success(response))
                }
            }, onError: { err in
                switch err.asAFError(orFailWith: "Terjadi kesalahan") {
                case .requestRetryFailed(let error, _):
                    completion(.failure(error as! APIError))
                default:
                    completion(.failure(.unknownError(message: "")))
                }
            }).disposed(by: disposeBag)
    }
    
}

extension Observable where Element == (HTTPURLResponse, Data) {
    fileprivate func expectingObject<T : Codable>(ofType type: T.Type) -> Observable<Result<T, APIError>>{
        return self.map{ (httpURLResponse, data) -> Result<T, APIError> in
            switch httpURLResponse.statusCode{
            case 200 ... 299:
                let object = try JSONDecoder().decode(type, from: data)
                return .success(object)
            case 400:
                return .failure(.inactiveToken(message: ""))
            case 401:
                return .failure(.unauthorized(message: ""))
            case 403:
                return .failure(.forbidden(message: ""))
            case 404:
                return .failure(.notFound(message: ""))
            default:
                return .failure(.unknownError(message: ""))
            }
        }
    }
    
    fileprivate func expectingObjectList<T : Codable>(ofType type: BaseResponse<T>.Type) -> Observable<Result<BaseResponse<T>, APIError>>{
        return self.map{ (httpURLResponse, data) -> Result<BaseResponse<T>, APIError> in
            switch httpURLResponse.statusCode{
            case 200 ... 299:
                let object = try JSONDecoder().decode(type, from: data)
                return .success(object)
            case 400:
                return .failure(.inactiveToken(message: ""))
            case 401:
                return .failure(.unauthorized(message: ""))
            case 403:
                return .failure(.forbidden(message: ""))
            case 404:
                return .failure(.notFound(message: ""))
            default:
                return .failure(.unknownError(message: ""))
            }
        }
    }
}
