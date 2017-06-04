//
//  EventsCollectionViewController.swift
//  MarvelApp
//
//  Created by Pedro Henrique on 04/06/17.
//  Copyright © 2017 Test. All rights reserved.
//

import UIKit

private let reuseIdentifier = "EventsCell"

struct TypeEvent{
    static let event = 0
    static let storie = 1
    static let serie = 2
}

class EventsCollectionViewController: UICollectionViewController {
    
    // This is the reference to the ViewModel, which is loaded in the segue
    // calling this ViewController:
    var presenter: HomePresenter?
    
    //Character Id
    var characterId: Int64?
    
    //Events Array
    var eventsArray: [Events]?
    var storiesArray: [Stories]?
    var seriesArray: [Series]?
    
    //Type Event
    var typeEvent: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        // Set the events controller to the HomePresenter:
        //
        presenter?.set(e: self)
        
        if typeEvent == TypeEvent.event{
           presenter?.loadEventsByCharacter(characterId: characterId!)
        } else if typeEvent == TypeEvent.storie{
           presenter?.loadStoriesByCharacter(characterId: characterId!)
        }else{
           presenter?.loadSeriesByCharacter(characterId: characterId!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        presenter?.exit()
    }
    
    func showEvents(events: [Events]){
        self.eventsArray = events
        self.collectionView?.reloadData()
    }
    
    func showStories(stories: [Stories]){
        print(stories)
        self.storiesArray = stories
        self.collectionView?.reloadData()
    }
    
    func showSeries(series: [Series]){
        self.seriesArray = series
        self.collectionView?.reloadData()
    }

    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if typeEvent == TypeEvent.event{
           if eventsArray == nil{
              return 1
           }else{
              return eventsArray!.count
           }
        }else if typeEvent == TypeEvent.storie{
            if storiesArray == nil{
                return 1
            }else{
                return storiesArray!.count
            }
        }else{
            if seriesArray == nil{
                return 1
            }else{
                return seriesArray!.count
            }
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! EventsCollectionViewCell
        
        if typeEvent == TypeEvent.event{
           let event = eventsArray?[indexPath.item]

           // Configure the cell
           cell.eventsImageView.image = event?.thumbnail
           cell.eventsTitle.text = event?.title
            
        }else if typeEvent == TypeEvent.storie{
            let storie = storiesArray?[indexPath.item]
            
            // Configure the cell
            cell.eventsImageView.image = storie?.thumbnail
            cell.eventsTitle.text = storie?.title
        }else{
            let serie = seriesArray?[indexPath.item]
            
            // Configure the cell
            cell.eventsImageView.image = serie?.thumbnail
            cell.eventsTitle.text = serie?.title
        }
    
        return cell
    }
}
