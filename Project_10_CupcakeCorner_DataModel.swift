//
//  Project_10_CupcakeCorner_DataModel.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 13/03/25.
//

import SwiftUI

@Observable
class Project_10_CupcakeCorner_DataModel: Codable {
    struct UserAddress: Codable, Hashable{
        var id = UUID()
        var name: String
        var city: String
        var StreetAddress: String
        var zipCode: String
    }
    
    enum CodingKeys: String, CodingKey{
        case _name = "name"
        case _city = "city"
        case _noOfCupCake = "noOfCupCake"
        case _cupCakeType = "cupCakeType"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _zipCode = "zipCode"
        case _streetAdress = "streetAdress"
      //  case _hasValidAddress = "hasValidAddress"  // giving error
        case _anySpecialRequest = "anySpecialRequest"
      //  case _cost = "cost"  // giving error
        
    }
    
    static func SaveUserAddress(_ storage: Project_10_CupcakeCorner_DataModel){
        if let encoded = try? JSONEncoder().encode(storage){
            UserDefaults.standard.set(encoded, forKey: "userAddress")
        }
       
    }
    
    static let cupCakeTypesArray = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var cupCakeType = 0
    var noOfCupCake = 3
    
    var anySpecialRequest = false{
        didSet{
            
            if anySpecialRequest == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    
    var extraFrosting = false
    var addSprinkles = false
    
    // address
        var name = ""
        var city = ""
        var zipCode = ""
        var streetAdress = ""
    
    
       
    // checking valid address
    var hasValidAddress: Bool {
        guard !name.trimmingCharacters(in: .whitespaces ).isEmpty || !city.trimmingCharacters(in: .whitespaces ).isEmpty || !zipCode.trimmingCharacters(in: .whitespaces ).isEmpty || !streetAdress.trimmingCharacters(in: .whitespaces ).isEmpty else{ return false }
        
        if name.isEmpty || city.isEmpty || zipCode.isEmpty || streetAdress.isEmpty {
            return false
        }
        return true
    }
    
    var costs: Decimal{
        // $2 per cake
      var  cost = Decimal(noOfCupCake) * 2
        
        // special cake  cost extra
        cost += Decimal(cupCakeType) / 2
        
        // sepcial request cost
        
        if anySpecialRequest {
            // $1 frostong cost per cake
            if extraFrosting {
                cost += Decimal(noOfCupCake)
            }
            
            if addSprinkles {
                // $0.50 sprinkle cost per cake
                cost += Decimal(noOfCupCake) / 2
            }
          
        }
        
        return cost
    }
    
   
    
}
