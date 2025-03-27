//
//  Project_14_BucketList_DetailView.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 17/03/25.
//
import MapKit
import SwiftUI

struct Project_14_BucketList_DetailView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var viewModel: ViewModel
    
  
    var onSave: (Project_14_BucketList_DataModel) -> Void
    
    init(dataInstance: Project_14_BucketList_DataModel, onSave: @escaping (Project_14_BucketList_DataModel) -> Void) {
        
        self.onSave = onSave
        self._viewModel = State(wrappedValue: ViewModel(dataInstance: dataInstance))
      
    }
    
   
    
    // body goes here
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Location Name", text: $viewModel.enterName)
                        .disableAutocorrection(true)
                    TextField("Location Description", text: $viewModel.enterDescription)
                        .disableAutocorrection(true)
                }
                Section("Nearby..."){
                    switch viewModel.enumState {
                    case .loaded:
                        ForEach(viewModel.pageArray, id: \.pageid){ item in
                            Text(item.title)
                                .font(.headline)
                            + Text(" :  ") +
                            
                            Text(item.description)
                                .italic()
                            
                        }
                            
                    case .loading:
                        Text("Loading")
                    case .failed:
                        Text("Please try again later.")
                    }
                }
                
               
            }
            .navigationTitle("Save Location")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem{
                    Button("Save"){
                        let newLocation = Project_14_BucketList_DataModel(id: UUID(), locationName: viewModel.enterName, locationDescription: viewModel.enterDescription, latitude: viewModel.dataInstance.latitude, longitude: viewModel.dataInstance.longitude)
                        
                          onSave(newLocation)
                          dismiss()
                    }
                }
            }
             .task{
                 await viewModel.fetchNearbyPlaces()
                }
            
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    Project_14_BucketList_DetailView(dataInstance: .example){ _ in}
        .preferredColorScheme(.dark)
}
