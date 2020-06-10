//
//  ViewController.swift
//  pokedex
//
//  Created by Vyom Unadkat on 20/09/17.
//  Copyright © 2017 Vyom Unadkat. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemon = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionview.dataSource = self
        collectionview.delegate = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        
        
        parseCSV()
        
    }

  
    func parseCSV() {
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")
        
        do {
            let csv = try CSV(contentsOfURL: path!)
            let row = csv.rows
            print(row)
            for i in row{
            let pokeid = Int(i["id"]!)
            let pokename = String(i["identifier"]!)
            
                let pok = Pokemon(name: pokename, pokeId: pokeid!)
            pokemon.append(pok)
                
            }
            
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if isSearching{
            
            return filteredPokemon.count
            
        }else{
            
            return pokemon.count
            
        }
        
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? pokecell{
            
            let pokemon: Pokemon!
            
            if isSearching{
                
                pokemon = self.filteredPokemon[indexPath.row]
                cell.configure(pokemon: pokemon)
            }else{
                
                pokemon = self.pokemon[indexPath.row]
                cell.configure(pokemon: pokemon)
            }
            
            
            
            
            return cell
        }
        else{
            return UICollectionViewCell()
        }
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var poke: Pokemon!
        
        if isSearching{
            poke = filteredPokemon[indexPath.row]
        }
        else{
            poke = pokemon[indexPath.row]
        }
        
        performSegue(withIdentifier: "pokedesc", sender: poke)
        
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 120)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == ""{
            
            isSearching = false
            view.endEditing(true)
            collectionview.reloadData()
        }
        else{
            isSearching = true
            let str = searchBar.text?.lowercased()
            filteredPokemon = pokemon.filter({$0.name.range(of: str!) != nil})
            collectionview.reloadData()
        }

    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pokedesc"{
            if let destination = segue.destination as? pokeDescVC{
                if let poke = sender as? Pokemon{
                    destination.pokemon = poke
                }
                
            }
            
    }
    
    }
}
