//
//  HomeViewController.swift
//  MarvelApp
//
//  Created by Pedro Henrique on 31/05/17.
//  Copyright © 2017 Test. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var characterTableView: UITableView!
    
    //ArrayList of Characters
    var characterArray = [Character]()
    
    //This is the reference to the Presenter, which is loaded in the segue
    var presenter: HomePresenter?
    
    required init?(coder aDecoder: NSCoder) {
        //Initialize Presenter
        presenter = HomePresenter()
        
        // Then, call the 'super' initialization:
        super.init(coder: aDecoder)
        
        // And then, register the Presenter entry point:
        presenter?.initialize(entryPoint:self)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Creating SearchBar and adding on Navigation Item
        createSearchBar()
    
        //Setting delegates and data sources
        self.characterTableView.delegate = self
        self.characterTableView.dataSource = self
        
        //
        // Set the login controller to the MainViewModel:
        //
        presenter?.set(h: self)
        
        //Load All Characters
        presenter?.loadAllCharacters(offset: 0)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
        presenter?.exit()
    }
    
    func createSearchBar(){
        let searchBar = UISearchBar()
        searchBar.placeholder = "Pesquise seu personagem"
        //searchBar.delegate = self
        self.navigationItem.titleView = searchBar
    }
    
    func loadAllCharacters(characterArray: [Character]){
        self.characterArray = characterArray
        self.characterTableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characterArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Get character from array
        let character = characterArray[indexPath.item]
        
        //Instante and adding character on a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "charactersTableCell") as! HomeTableViewCell
        cell.name.text = character.name
        cell.thumbnail.image = character.thumbnail
        
        
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
