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
    func set(c: CharacterDetailViewController)
    func set(e: EventsCollectionViewController)
    func loadAllCharacters(offset: Int)
    func searchCharacterByName(name: String, offset: Int)
    func loadDetailCharacter(characterId: Int64)
    func loadEventsByCharacter(characterId: Int64)
    func loadStoriesByCharacter(characterId: Int64)
    func loadSeriesByCharacter(characterId: Int64)
}
