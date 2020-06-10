//
//  poke class.swift
//  pokedex
//
//  Created by Vyom Unadkat on 20/09/17.
//  Copyright © 2017 Vyom Unadkat. All rights reserved.
//

import Foundation

class Pokemon{
    
    var _name: String!
    var _pokeId: Int!
    
    var name: String{
        if _name == nil{
            _name = ""
        }
        return _name
    }
    
    var pokeId: Int{
        if _pokeId == nil{
            _pokeId = 1
        }
        return _pokeId
        
    }
    
    
    
    
   init(name: String, pokeId: Int){
   self._name = name
   self._pokeId = pokeId
   }
    
}
