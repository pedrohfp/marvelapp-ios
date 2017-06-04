//
//  Character.swift
//  MarvelApp
//
//  Created by Pedro Henrique on 31/05/17.
//  Copyright © 2017 Test. All rights reserved.
//

import Foundation
import UIKit

struct Character{
    let id: Int64
    let name: String
    let thumbnail: UIImage?
    let description: String?
    let comics: [Comics]?
    
    
    init(id: Int64, name: String, thumbnail: UIImage?, description: String?, comics: [Comics]?) {
        self.id = id
        self.name = name
        self.thumbnail = thumbnail
        self.description = description
        self.comics = comics
    }
 
}

struct Comics{
    let id: Int64
    let title: String
    let thumbnail: UIImage?
}

struct Series{
    let id: Int64
    let title: String
    let thumbnail: UIImage?
}

struct Stories{
    let id: Int64
    let title: String
    let thumbnail: UIImage?
}

struct Events{
    let id: Int64
    let title: String
    let thumbnail: UIImage?
}

struct Item{
    let resourceUri: String
    let name: String
    let type: String?
}
