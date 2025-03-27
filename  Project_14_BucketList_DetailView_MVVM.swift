//
//   Project_14_BucketList_DetailView_MVVM.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 18/03/25.
//
import Observation
import MapKit
import SwiftUI

extension Project_14_BucketList_DetailView{
    
    @Observable
    class ViewModel{
        
        enum LoadingState {
            case loading, loaded, failed
        }
        
        var dataInstance: Project_14_BucketList_DataModel
           
        var  enumState = LoadingState.loading
        var pageArray = [WikiPage]()
        
        var enterName: String
        var enterDescription: String
        
        init(dataInstance: Project_14_BucketList_DataModel) {
            self.dataInstance = dataInstance
           
            self.enterName = dataInstance.locationName
            self.enterDescription = dataInstance.locationDescription
        }
        
        @MainActor
        func fetchNearbyPlaces() async{
            let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(dataInstance.latitude)%7C\(dataInstance.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
            
            guard let url = URL(string: urlString) else{
                print("Invalid url \(urlString)")
                return
            }
            do{
                let (data, _) = try await URLSession.shared.data(from: url)
                let decoder = try JSONDecoder().decode(Project_14_BucketList_WikipediaResult.self, from: data)
                
                pageArray = decoder.query.pages.values.sorted()
                
                enumState = .loaded
                
            }catch{
                print("failed to fetch data \(error.localizedDescription)")
                await MainActor.run{
                    enumState = .failed
                }
            }
            
        }
    }
}
