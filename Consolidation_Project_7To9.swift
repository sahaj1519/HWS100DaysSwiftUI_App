//
//  Untitled.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 11/03/25.
//

import SwiftUI

struct Activity: Identifiable, Codable, Hashable,Equatable{
   
    
    var id = UUID()
     var count = 0
    let activityTitle: String
    let activityDescription: String
}

@Observable
class DataStorage {
    
   var activities:[Activity]{     // storing new activity
        didSet{
            saveActivity()
        }
    }
    
    init() {    // how to load data when app launch
       
            if let loadedData = UserDefaults.standard.data(forKey: "Added activities"){
                if let decoded = try? JSONDecoder().decode([Activity].self, from: loadedData){
                    activities = decoded
                   return
                }
            }
        
        activities = []
        
        
    }
    func saveActivity(){   // save data of  added activity in userdefault
        
        if let encoded = try? JSONEncoder().encode(activities){
            UserDefaults.standard.set(encoded, forKey: "Added activities")
        }
        
    }
    
    
  
}


struct Consolidation_Project_7To9:View {
    @State private var isSheetView = false
    
  var dataFromStorageClass = DataStorage()
    
    
    func removeFromList(atindex: IndexSet){
        dataFromStorageClass.activities.remove(atOffsets: atindex)
    }
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(dataFromStorageClass.activities){i in
                    NavigationLink{
                        AnotherView(activityInstance: i, storageInstance: dataFromStorageClass)
                    }
                    label:{  Text(i.activityTitle)
                            .font(.headline.weight(.heavy))
                        
                        
                    }
                }.onDelete(perform: removeFromList)
                
            }
           
            .preferredColorScheme(.dark)
            .accentColor(.black)
            .navigationTitle("Track Your Activity")
            
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    EditButton()
                }
                ToolbarItem(placement: .topBarTrailing){
                    Button("Add activity", systemImage: "plus"){
                        isSheetView = true
                    }
                }
            }
            .sheet(isPresented: $isSheetView){
                Consolidation_Project_7To9_FormView(storageFromClassInstance: dataFromStorageClass)
                   
            }
           
        }
    }
}


#Preview {
  
    Consolidation_Project_7To9()
         .preferredColorScheme(.dark)
}


