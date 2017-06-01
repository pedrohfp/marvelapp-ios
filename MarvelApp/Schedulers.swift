//
//  Schedulers.swift
//  MarvelApp
//
//  Created by Pedro Henrique on 31/05/17.
//  Copyright © 2017 Test. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

/**
 This class centralizes all available schedulers on system:
 */
class Schedulers {
    // The IO Scheduler is a new Background Thread scheduler:
    static let io = ConcurrentDispatchQueueScheduler(qos: .background)
    
    // DB Operations (Core Data) are considered IO operations, so the DB Scheduler
    // and the IO Scheduler are exactly the same:
    static let db = io
    
    // The computation scheduler is a background scheduler, to perform
    // CPU intensive tasks without blocking the main thread:
    static let computation = ConcurrentDispatchQueueScheduler(qos: .background)
    
    // The network scheduler is a background scheduler, different from
    // any other scheduler. All network communication is done by it.
    static let network = ConcurrentDispatchQueueScheduler(qos: .background)
    
    // The main thread is represented here:
    static let mainThread = MainScheduler()
    
    // And the UI scheduler also is the main thread scheduler:
    static let ui = MainScheduler()
}

