//
//  CharacterDetailViewController.swift
//  MarvelApp
//
//  Created by Pedro Henrique on 03/06/17.
//  Copyright © 2017 Test. All rights reserved.
//

import UIKit

class CharacterDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // This is the reference to the Presenter, which is loaded in the segue
    // calling this ViewController:
    var presenter: HomePresenter?
    
    var characterId: Int64?
    
    var character: Character?
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var characterDescription: UITextView!
    @IBOutlet weak var comicCollectionView: UICollectionView!
    
    @IBOutlet weak var comicCollectionHeightConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.characterDescription.sizeToFit()
        
        self.comicCollectionView.delegate = self
        self.comicCollectionView.dataSource = self
        
        //
        // Set the character detail controller to the HomePresenter:
        //
        presenter?.set(c: self)
        
        presenter?.loadDetailCharacter(characterId: characterId!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        presenter?.exit()
    }
    
    func showCharacterDetail(character: Character){
        print(character.comics!)
        
        self.character = character
        
        self.characterImageView.image = character.thumbnail
        self.characterName.text = character.name
        self.characterDescription.text = character.description
        
        if character.comics?.count == 0{
            self.comicCollectionHeightConstraint.constant = 0
        }
        
        self.comicCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if character != nil{
            return (character?.comics?.count)!
        }else{
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "comicsCollectionCell", for: indexPath) as? ComicsCollectionViewCell
        
        let comic = character?.comics?[indexPath.item]
        
        cell?.comicImageView.image = comic?.thumbnail
        cell?.comicTitleLable.text = comic?.title
      
        return cell!
    }
    

    /*
     MARK: - Navigation

     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         Get the new view controller using segue.destinationViewController.
         Pass the selected object to the new view controller.
    }
    */

}
