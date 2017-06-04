//
//  EventsCollectionViewController.swift
//  MarvelApp
//
//  Created by Pedro Henrique on 04/06/17.
//  Copyright © 2017 Test. All rights reserved.
//

import UIKit

private let reuseIdentifier = "EventsCell"

class EventsCollectionViewController: UICollectionViewController {
    
    // This is the reference to the ViewModel, which is loaded in the segue
    // calling this ViewController:
    var presenter: HomePresenter?
    
    //Character Id
    var characterId: Int64?
    
    //Events Array
    var eventsArray: [Events]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        // Set the events controller to the HomePresenter:
        //
        presenter?.set(e: self)
        
        presenter?.loadEventsByCharacter(characterId: characterId!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        presenter?.exit()
    }
    
    func showEvents(events: [Events]){
        print(events)
        self.eventsArray = events
        
        self.collectionView?.reloadData()
    }

    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if eventsArray == nil{
            return 1
        }else{
            return eventsArray!.count
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! EventsCollectionViewCell
        
        let event = eventsArray?[indexPath.item]

        // Configure the cell
        cell.eventsImageView.image = event?.thumbnail
        cell.eventsTitle.text = event?.title
    
        return cell
    }
}
