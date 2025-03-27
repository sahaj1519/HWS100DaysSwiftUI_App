//
//  Consolidation_Project_10To12_FetchFile.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 15/03/25.
//
import SwiftData
import SwiftUI

@MainActor
func fetchFiles(modelContext: ModelContext) async {
    do{
        let existingUser = try modelContext.fetch(FetchDescriptor<Consolidation_Project_10To12_DataModelUser>())
     
        if !existingUser.isEmpty {
            print("user already exist ")
            return
        }
        
    }catch{
        print("no existing users in database .... so fetching from url ")
    }
   
    
    let urlName = "https://www.hackingwithswift.com/samples/friendface.json"
    
    guard let url = URL(string: urlName) else{
        print("Invalid url")
        return}
    do{
        let (data, _ ) = try await URLSession.shared.data(from: url)
        
        let decoding = JSONDecoder()
       
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXX"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        decoding.dateDecodingStrategy = .formatted(formatter)
        
        
     let decoder =  try decoding.decode([UserCodable].self, from: data)
        
        await MainActor.run{
            for item in decoder{
                let newUser = Consolidation_Project_10To12_DataModelUser(id: item.id, isActive: item.isActive, name: item.name, age: item.age, company: item.company, email: item.email, address: item.address, about: item.about, registered: item.registered, tags: item
                    .tags, friends: []
                )
             /**  var newfriendss: [Consolidation_Project_10To12_DataModel_Friend] = []
                            for friend in item.friends {
                                let newFriend = Consolidation_Project_10To12_DataModel_Friend(id: friend.id, name: friend.name, owner: newUser)
                                newfriendss.append(newFriend)
                                print("Created Friend: \(newFriend.name) for User: \(newUser.name)")
                            }  **/
                newUser.friends = item.friends.map{ friend in
                    Consolidation_Project_10To12_DataModel_Friend(id: friend.id, name: friend.name, owner: newUser)
                }
                
              //  newUser.friends = newfriendss
                
                modelContext.insert(newUser)
              
            }
        }
        do{
           try modelContext.save()
            print("succesfully saved data by fetching from server")
        }catch{
            print("error occure to save data while fetching ")
        }
    }catch{
        print("error while fetching and decoding \(error.localizedDescription)")
    }
    
}



































