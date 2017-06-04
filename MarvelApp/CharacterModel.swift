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
    private var disposeBag : DisposeBag?

    
    func loadCharacters(offset: Int, name: String?) -> Observable<[Character]>{
        return Observable.create({ observer in
            
            let path: String?
            
            if name == nil{
                path = "v1/public/characters?offset=\(offset)&"
            }else{
                path = "v1/public/characters?offset=\(offset)&nameStartsWith=\(name!)&"
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

                                
                                let character = Character(id: id, name: name, thumbnail: image, description: nil, comics: nil)
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
    
    func loadCharacterDetail(characterId: Int64) -> Observable<Character>{
        return Observable.create({ observer in
            
            let path = "v1/public/characters/\(characterId)?"
            
            RestFactory(method: HTTPMethod.get, path: path)
              .createUrlRequest(parameters:  nil)
              .responseJSON(completionHandler: { response in
                if let status = response.response?.statusCode{
                    if status == 200{
                        if let result = response.result.value{
                            let json = JSON(result)
                            let result = json["data"]["results"][0]
                            let id = result["id"].int64Value
                            let name = result["name"].stringValue
                            let description = result["description"].stringValue
                            let thumbnail = result["thumbnail"]["path"].stringValue + "." + result["thumbnail"]["extension"].stringValue
                            
                            //Get Thumbnail
                            let url = URL(string: thumbnail)
                            let data = try? Data(contentsOf: url!)
                            let image: UIImage?
                            
                            if data != nil{
                                image = UIImage(data: data!)
                            }else{
                                image = nil
                            }
                            
                            self.loadComicsByCharacter(characterId: characterId).observeOn(Schedulers.network).subscribe(
                                onNext: { comicsArray in
                                    let character = Character(id: id, name: name, thumbnail: image, description: description, comics: comicsArray)
                                    
                                    observer.on(.next(character))
                                }
                            ).addDisposableTo(self.getDisposeBag())
                        }
                    }
                }
              })
            
            return Disposables.create()
        }).subscribeOn(Schedulers.network)
    }
    
    func loadComicsByCharacter(characterId: Int64) -> Observable<[Comics]>{
        return Observable.create({ observer in
            
            let path = "v1/public/characters/\(characterId)/comics?"
            
            RestFactory(method: HTTPMethod.get, path: path)
              .createUrlRequest(parameters: nil)
              .responseJSON(completionHandler: { response in
                if let status = response.response?.statusCode{
                    if status == 200{
                        if let result = response.result.value{
                            let json = JSON(result)
                            
                            var comicsArray = [Comics]()
                            
                            for(_, object) in json["data"]["results"]{
                                let id = object["id"].int64Value
                                let title = object["title"].stringValue
                                let thumbnail = object["thumbnail"]["path"].stringValue + "." + object["thumbnail"]["extension"].stringValue
                            
                                //Get thumbnail
                                let url = URL(string: thumbnail)
                                let data = try? Data(contentsOf: url!)
                                let image: UIImage?
                                
                                if data != nil{
                                    image = UIImage(data: data!)
                                }else{
                                    image = nil
                                }
                                
                                let comic = Comics(id: id, title: title, thumbnail: image)
                                comicsArray.append(comic)
                                
                            }
                            
                            observer.on(.next(comicsArray))
                        }
                    }
                }
              })
            
            return Disposables.create()
        }).subscribeOn(Schedulers.network)
    }
    
    func loadSeriesByCharacter(characterId: Int64) -> Observable<[Series]>{
        return Observable.create({ observer in
            
            let path = "v1/public/characters/\(characterId)/series?"
            
            RestFactory(method: HTTPMethod.get, path: path)
             .createUrlRequest(parameters: nil)
             .responseJSON(completionHandler: { response in
                if let status = response.response?.statusCode{
                    if status == 200{
                        if let result = response.result.value{
                            let json = JSON(result)
                            
                            var seriesArray = [Series]()
                            
                            for(_, object) in json["data"]["results"]{
                                let id = object["id"].int64Value
                                let title = object["title"].stringValue
                                let thumbnail = object["thumbnail"]["path"].stringValue + "." + object["thumbnail"]["extension"].stringValue
                                
                                //Get thumbnail
                                let url = URL(string: thumbnail)
                                let data = try? Data(contentsOf: url!)
                                let image: UIImage?
                                
                                if data != nil{
                                    image = UIImage(data: data!)
                                }else{
                                    image = nil
                                }
                                
                                let serie = Series(id: id, title: title, thumbnail: image)
                                seriesArray.append(serie)
                            }
                            
                            observer.on(.next(seriesArray))
                        }
                    }
                }
             })
            
            return Disposables.create()
        }).subscribeOn(Schedulers.network)
    }
    
    func loadEventsByCharacter(characterId: Int64) -> Observable<[Events]>{
        return Observable.create({ observer -> Disposable in
            let path = "v1/public/characters/\(characterId)/events?"
            
            RestFactory(method: HTTPMethod.get, path: path)
              .createUrlRequest(parameters: nil)
              .responseJSON(completionHandler: { response in
                if let status = response.response?.statusCode{
                    if status == 200{
                        if let result = response.result.value{
                            let json = JSON(result)
                            
                            var eventsArray = [Events]()
                            
                            for(_, object) in json["data"]["results"]{
                                let id = object["id"].int64Value
                                let title = object["title"].stringValue
                                let thumbnail = object["thumbnail"]["path"].stringValue + "." + object["thumbnail"]["extension"].stringValue
                                
                                //Get thumbnail
                                let url = URL(string: thumbnail)
                                let data = try? Data(contentsOf: url!)
                                let image: UIImage?
                                
                                if data != nil{
                                    image = UIImage(data: data!)
                                }else{
                                    image = nil
                                }
                                
                                let events = Events(id: id, title: title, thumbnail: image)
                                eventsArray.append(events)
                            }
                            
                            observer.on(.next(eventsArray))
                        }

                    }
                }
              })
            
            return Disposables.create()
        }).subscribeOn(Schedulers.network)
    }
    
    func loadStoriesByCharacter(characterId: Int64) -> Observable<[Stories]>{
        return Observable.create({ observer -> Disposable in
            
            let path = "v1/public/characters/\(characterId)/stories?"
            
            RestFactory(method: HTTPMethod.get, path: path)
             .createUrlRequest(parameters: nil)
             .responseJSON(completionHandler: { response in
                if let status = response.response?.statusCode{
                    if status == 200{
                        if let result = response.result.value{
                            let json = JSON(result)
                            
                            var storiesArray = [Stories]()
                            
                            for(_, object) in json["data"]["results"]{
                                let id = object["id"].int64Value
                                let title = object["title"].stringValue
                                let thumbnail = object["thumbnail"]["path"].stringValue + "." + object["thumbnail"]["extension"].stringValue
                                
                                //Get thumbnail
                                let url = URL(string: thumbnail)
                                let data = try? Data(contentsOf: url!)
                                let image: UIImage?
                                
                                if data != nil{
                                    image = UIImage(data: data!)
                                }else{
                                    image = nil
                                }
                                
                                let storie = Stories(id: id, title: title, thumbnail: image)
                                storiesArray.append(storie)
                            }
                            
                            observer.on(.next(storiesArray))
                            
                        }
                    }
                }
             })
            
            return Disposables.create()
        }).subscribeOn(Schedulers.network)
    }
    
    func getDisposeBag() -> DisposeBag {
        // If disposeBag exists, return it
        if disposeBag != nil {
            return disposeBag!
        }
        
        // Otherwise, create a new one, bind it to the current Presenter instance:
        self.disposeBag = DisposeBag()
        
        // Then return it:
        return self.disposeBag!
        
    }

    
}
