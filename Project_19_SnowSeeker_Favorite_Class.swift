//
//  Project_19_SnowSeeker_Favorite_Class.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 23/03/25.
//

import SwiftUI

@Observable
class Project_19_SnowSeeker_Favorite_Class{
   
    private var resorts: Set<String> = []
    private let key = "Favorites"
    
    
    init(){
        
        do{
            if let data =  UserDefaults.standard.data(forKey: key){
                let decoded = try JSONDecoder().decode([String].self, from: data)
                
                resorts = Set(decoded)
            }
            
        }catch{
            
            print("failed to load data from userDefaults \(error.localizedDescription)")
            
        }
    }
    
    func saveId(){
        do{
            let encoded = try JSONEncoder().encode(Array(resorts))
            UserDefaults.standard.set(encoded, forKey: key)
            
        }catch{
            print("failed to save data to userDefaults")
        }
    }
    
    func removeId(_ data: Project_19_SnowSeeker_DataModel){
        
        resorts.remove(data.id)
        saveId()
    }
    
    func addId(_ data: Project_19_SnowSeeker_DataModel){
        resorts.insert(data.id)
        saveId()
    }
    
    func containsId(_ data: Project_19_SnowSeeker_DataModel) -> Bool{
        resorts.contains(data.id)
    }
    
}
