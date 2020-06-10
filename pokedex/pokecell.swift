//
//  pokecell.swift
//  pokedex
//
//  Created by Vyom Unadkat on 21/09/17.
//  Copyright © 2017 Vyom Unadkat. All rights reserved.
//

import UIKit

class pokecell: UICollectionViewCell {
    
    
    @IBOutlet weak var pokeImg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var pokemon: Pokemon!
    
    func configure(pokemon: Pokemon){
        self.pokeImg.image = UIImage(named: "\(pokemon.pokeId)")
        self.nameLabel.text = pokemon.name
        
    }
    
    
    
}
