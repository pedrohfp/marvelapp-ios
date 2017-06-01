//
//  CharacterModel.swift
//  MarvelApp
//
//  Created by Pedro Henrique on 31/05/17.
//  Copyright © 2017 Test. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire
import SwiftyJSON

class CharacterModel{
    
    static let instance = CharacterModel()
    
    func loadCharacters(offset: Int, name: String?) -> Observable<[Character]>{
        return Observable.create({ observer in
            
            let path: String?
            
            if name == nil{
                path = "v1/public/characters?offset=\(offset)"
            }else{
                path = "v1/public/characters?offset=\(offset)&nameStartsWith=\(name!)"
            }
            
            RestFactory(method: HTTPMethod.get, path: path!)
                .createUrlRequest(parameters: nil)
                .responseJSON(completionHandler: { response in
                  if let status = response.response?.statusCode{
                    if status == 200{
                        if let result = response.result.value{
                            let json = JSON(result)
                            
                            var characterArray = [Character]()
                            
                            for(_, object) in json["data"]["results"]{
                                let id = object["id"].int64Value
                                let name = object["name"].stringValue
                                let thumbnail = object["thumbnail"]["path"].stringValue + "/standard_small." +  object["thumbnail"]["extension"].stringValue
                                
                                //Get thumbnail
                                let url = URL(string: thumbnail)
                                let data = try? Data(contentsOf: url!)
                                let image: UIImage?
                                
                                if data != nil{
                                   image = UIImage(data: data!)
                                }else{
                                    image = nil
                                }

                                
                                let character = Character(id: id, name: name, thumbnail: image!)
                                characterArray.append(character)
                            }
                            
                            observer.on(.next(characterArray))
                            
                        }
                    }else{
                        print(response.error.debugDescription)
                    }
                }
              })
            
            return Disposables.create()
            
        }).subscribeOn(Schedulers.network)
    }
}
