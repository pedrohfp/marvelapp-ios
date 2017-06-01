//
//  HomeContract.swift
//  MarvelApp
//
//  Created by Pedro Henrique on 31/05/17.
//  Copyright © 2017 Test. All rights reserved.
//

import Foundation

protocol HomeContract{
    func set(h: HomeViewController)
    func loadAllCharacters(offset: Int)
    func searchCharacterByName(name: String, offset: Int)
}
