//
//  Consolidation_Project_13To15.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 18/03/25.
//

import PhotosUI
import SwiftUI

struct Consolidation_Project_13To15: View {
    
    @State  var dataInstance = Consolidation_Project_13To15_DataModel()
    let locationFetcher = LocationFetcher()
    
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var importedImageData: Data? = nil
  
    
     func deletePerson(at index: IndexSet){
         dataInstance.realData.remove(atOffsets: index)
         dataInstance.save()
     }

    
    var body: some View {
        NavigationStack{
            List{
               
                ForEach(dataInstance.realData.sorted(), id: \.id){ item in
                    
                    NavigationLink(value: item ){
                    HStack{
                        if let uiImage =  UIImage(data: item.photo){
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 90, height: 70)
                                .clipShape(.rect(cornerRadius: 5))
                            
                        }else{
                            Image(systemName: "photo.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                        }
                        
                        Text(item.personName)
                            .font(.title2.bold())
                            .padding(.leading, 25)
                        
                    }
                }
                }.onDelete(perform: deletePerson)
                
            }
            .scrollBounceBehavior(.basedOnSize)
            .navigationDestination(for: RealData.self){item in
                Consolidation_Project_13To15_DetailView(data: dataInstance ,imageData: item.photo, imageId: item.id)
                }
                 .sheet(isPresented: Binding(
                        get: { importedImageData != nil },
                        set: { if !$0 { importedImageData = nil } }
                    )){
                        if let importedImageData{
                            Consolidation_Project_13To15_AddName(data: dataInstance ,addImage: importedImageData)
                                
                        }else{
                            Text("No Image Available")
                        }
                        
                    }
                    .toolbar{
                        ToolbarItem(placement: .topBarTrailing){
                            EditButton()
                        }
                        ToolbarItem(placement: .bottomBar){
                            
                            PhotosPicker("choose a photo", selection: $selectedItem , matching: .images)
                                .onChange(of: selectedItem){ _, newValue in
                                    Task{
                                        if let newValue, let dataOfImage = try? await newValue.loadTransferable(type: Data.self){
                                            importedImageData = dataOfImage
                                            
                                            }
                                        
                                     }
                                  }
                        }
                        ToolbarItem(placement: .topBarLeading){
                            Button("Reset Data") {
                                        dataInstance.resetData()
                                    }
                        }
                    }
                    .navigationTitle("App Name")
                    .navigationBarTitleDisplayMode(.inline)
                    .preferredColorScheme(.dark)
                    .onAppear{locationFetcher.start()}
        }// navigation Stack
    }
}

#Preview {
    Consolidation_Project_13To15(dataInstance: Consolidation_Project_13To15_DataModel())
        .preferredColorScheme(.dark)
}
