//
//  HomePresenter.swift
//  MarvelApp
//
//  Created by Pedro Henrique on 31/05/17.
//  Copyright © 2017 Test. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class HomePresenter : BasePresenter, HomeContract{
    
    var homeViewController: HomeViewController?
    var characterDetailViewController: CharacterDetailViewController?
    var eventsCollectionViewController: EventsCollectionViewController?
    
    func set(h: HomeViewController){
        self.homeViewController = h
    }
    
    func set(c: CharacterDetailViewController){
        self.characterDetailViewController = c
    }
    
    func set(e: EventsCollectionViewController){
        self.eventsCollectionViewController = e
    }
    
    func loadAllCharacters(offset: Int){
        CharacterModel.instance.loadCharacters(offset: offset, name: nil).observeOn(Schedulers.ui).subscribe(
            onNext: { [unowned self] characterArray in
                self.homeViewController?.loadAllCharacters(characterArray: characterArray)
            },
            onError: { _ in
                
            }
        ).addDisposableTo(getDisposeBag())
    }
    
    func searchCharacterByName(name: String, offset: Int){
        CharacterModel.instance.loadCharacters(offset: offset, name: name).observeOn(Schedulers.ui).subscribe(
            onNext: { [unowned self] characterArray in
                self.homeViewController?.loadCharactersBySearch(characterArray: characterArray)
            },
            onError: { _ in
                
            }
        ).addDisposableTo(getDisposeBag())
    }
    
    func loadDetailCharacter(characterId: Int64){
        CharacterModel.instance.loadCharacterDetail(characterId: characterId).observeOn(Schedulers.ui).subscribe(
            onNext: { [unowned self] character in
                self.characterDetailViewController?.showCharacterDetail(character: character)
            }
        ).addDisposableTo(getDisposeBag())
    }
    
    func loadEventsByCharacter(characterId: Int64){
        CharacterModel.instance.loadEventsByCharacter(characterId: characterId).observeOn(Schedulers.network).subscribe(
            onNext: { [unowned self] events in
                self.eventsCollectionViewController?.showEvents(events: events)
            }
        ).addDisposableTo(getDisposeBag())
    }
    
}
