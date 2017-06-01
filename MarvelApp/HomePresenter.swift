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
    
    func set(h: HomeViewController){
        self.homeViewController = h
    }
    
    func loadAllCharacters(offset: Int){
        CharacterModel.instance.loadAllCharacters(offset: offset).observeOn(Schedulers.ui).subscribe(
            onNext: { [unowned self] characterArray in
                self.homeViewController?.loadAllCharacters(characterArray: characterArray)
            },
            onError: { _ in
                
            }
        ).addDisposableTo(getDisposeBag())
    }
    
}
