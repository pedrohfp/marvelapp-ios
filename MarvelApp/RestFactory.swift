//
//  RestFactory.swift
//  MarvelApp
//
//  Created by Pedro Henrique on 31/05/17.
//  Copyright © 2017 Test. All rights reserved.
//

import Foundation
import Alamofire

/**
 This class is a factory for all necessary Alamofire Request instances.
 Any kind of Alamofire Request or DataReuquest must be created by this factory,
 and new create...() functions can be assembled to fulfill the application
 needs.
 */
class RestFactory {
    let baseUrl = "https://gateway.marvel.com/"
    let method: HTTPMethod
    let path: String

    let apikey = "d7eca9aa38c181fda0b58215c7c1848e"
    let privateApiKey = "f9734b014b9eeb709f21befccb04cd023aa17086"
    
    init(method:HTTPMethod, path:String) {
        self.method = method
        self.path = path
    }
    
    /**
     Function to create the most basic DataRequest instance to be used in the application:
     */
    func createDataRequest(encoding pencoding: ParameterEncoding = URLEncoding.default, parameters:[String: Any]? = nil) -> DataRequest {
        
        let timestamp = String(NSDate().timeIntervalSince1970 * 1000)
        let hash = MD5(timestamp + privateApiKey + apikey )
        
        let url = self.baseUrl + self.path + "ts=\(timestamp)&apikey=\(apikey)&hash=\(hash!)"
        
        print(url)
        
        var params: [String:Any] = [:]
        
        if parameters != nil {
            params = parameters!
        }
    
        let manager = Alamofire.SessionManager.default
        
        // Return the request, to be used by the caller:
        return manager.request(url, method: self.method, parameters: params, encoding: pencoding)
    }
    
    func createJsonRequest(parameters params:[String: Any]? = nil) -> DataRequest {
        return createDataRequest(encoding:JSONEncoding.default, parameters:params)
    }
    
    func createUrlRequest(parameters params:[String: Any]? = nil) -> DataRequest {
        return createDataRequest(parameters:params)
    }
    
    func MD5(_ string: String) -> String? {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        var digest = [UInt8](repeating: 0, count: length)
        if let d = string.data(using: String.Encoding.utf8) {
            d.withUnsafeBytes { (body: UnsafePointer<UInt8>) in
                CC_MD5(body, CC_LONG(d.count), &digest)
            }
        }
        return (0..<length).reduce("") {
            $0 + String(format: "%02x", digest[$1])
        }
    }
    
    func randomString(length: Int) -> String {
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
    
}
