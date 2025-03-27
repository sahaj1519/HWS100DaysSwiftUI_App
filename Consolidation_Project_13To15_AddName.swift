//
//  Consolidation_Project_13To15_AddName.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 19/03/25.
//
import CoreLocation
import SwiftUI

struct Consolidation_Project_13To15_AddName: View {
    @Environment(\.dismiss)  var dismiss
    
    let locationFetcher = LocationFetcher()
    
    @Bindable var data: Consolidation_Project_13To15_DataModel
   
      let addImage: Data?
    @State var enterName = ""
    var body: some View {
        Form{
            Section{
                if let addImage, let  uiImage = UIImage(data: addImage){
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                }
                    
                
            } .frame(width: 500, height: 300)
            
            Section{
                TextField("Enter Name", text: $enterName, axis: .vertical)
                    .autocorrectionDisabled(true)
                    
            }
            Section{
                Button("save"){
                    
                    if let addImage{
                        Task{
                            let location: CodableCoordinate
                            if let fetchedLocation = locationFetcher.lastKnownLocation{
                                location = CodableCoordinate(from: fetchedLocation)
                            } else{
                                    locationFetcher.start() // ✅ Force location fetch before saving
                    try? await Task.sleep(nanoseconds: 500_000_000) // ✅ Small delay for fetching (0.5s)
                        location = CodableCoordinate(from: locationFetcher.lastKnownLocation ?? CLLocationCoordinate2D(latitude: 0, longitude: 0))
                                }
                    let newPerson = RealData(photo: addImage, personName: enterName, location:  location )
                          
                    DispatchQueue.main.async {
                            data.realData.append(newPerson)
                                data.save()
                                        }
                                dismiss()
                            }
                            
                        }
                       
                    }
                   
            }.disabled(enterName.isEmpty)
           
        } 
    }
}

#Preview {
    Consolidation_Project_13To15_AddName(data: Consolidation_Project_13To15_DataModel(), addImage: Data())
        .preferredColorScheme(.dark)
}
