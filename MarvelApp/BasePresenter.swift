//
//  BasePresenter.swift
//  MarvelApp
//
//  Created by Pedro Henrique on 31/05/17.
//  Copyright © 2017 Test. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

//
// This protocol marks a presenter signature, enabling all presenters be referred as types:
//
protocol Presenter {
    
}


//
// The BasePresenter is the class to be used as Base class of the majority of Presenters.
// Obviously, it's inherited of Presenter protocol. The Presenter protocol exists to be used
// when the facilities of BasePresenter are unsuitable for a specific Presenter.
//
class BasePresenter: Presenter {
    var entry: UIViewController?
    private var disposeBag : DisposeBag?
    
    func initialize(entryPoint entry: UIViewController) {
        self.entry = entry
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
    
    func exit() {
        // Deallocate the disposable bag, so all RxSwift Disposables associated
        // with it can be deallocated too:
        self.disposeBag = nil
    }
}
