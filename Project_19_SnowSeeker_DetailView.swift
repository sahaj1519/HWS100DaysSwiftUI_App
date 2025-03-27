//
//  Project_19_SnowSeeker_DetailView.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 23/03/25.
//

import SwiftUI

struct Project_19_SnowSeeker_DetailView: View {
    var data: Project_19_SnowSeeker_DataModel
    
    @Environment(Project_19_SnowSeeker_Favorite_Class.self) var favoriteData
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    var id: String
    
    @State private var selectedFacility: Project_19_SnowSeeker_Facility_Model?
    @State private var isAlert = false
   
    
    var body: some View {
       // NavigationStack{
            ScrollView{
                VStack(alignment: .leading, spacing: 0){
                    ZStack(alignment: .bottomTrailing){
                        Image(data.id)
                            .resizable()
                            .scaledToFit()
                       
                    
                            
                            Text("Image Credit: \(data.imageCredit)")
                                .font(.caption2.bold())
                                .padding(2)
                                .background(.black.opacity(0.6))
                            
                      
                        
                    }
                    HStack{
                        if horizontalSizeClass == .compact  && dynamicTypeSize > .large {
                            VStack(spacing: 10){ Project_19_SnowSeeker_PriceView(data: data) }
                            VStack(spacing: 10){ Project_19_SnowSeeker_Snow_Information(data: data) }
                            
                        }else{
                            Project_19_SnowSeeker_PriceView(data: data)
                            Project_19_SnowSeeker_Snow_Information(data: data)
                        }
                    }.padding(.vertical)
                        .background(.primary.opacity(0.1))
                        .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                    
                    Group{
                        Text(data.description)
                            .padding(.vertical)
                        
                        Text("Facilities")
                            .font(.title2.bold())
                        HStack(spacing: 15){
                            ForEach(data.facilityType){ facility in
                                Button{
                                    selectedFacility = facility
                                    isAlert = true
                                    
                                }label:{
                                    facility.icon
                                        .font(.title2)
                                }
                                
                                
                            }
                            
                        }
                        
                        
                    }.padding(.horizontal)
                }
            }
            .navigationTitle("\(data.name), \(data.country)")
            .navigationBarTitleDisplayMode(.inline)
            .alert(selectedFacility?.name ?? "More Information", isPresented: $isAlert, presenting: selectedFacility){ _ in
                
                
            }message:{ item in
                
                Text(item.alertMessage)
            }
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button(favoriteData.containsId(data) ? "Unmark Favorite" : "Mark Favorite", systemImage: favoriteData.containsId(data) ? "heart.fill" : "heart") {
                        if favoriteData.containsId(data){
                            favoriteData.removeId(data)
                        }else{
                            favoriteData.addId(data)
                        }
                       
                        
                    }
                }
            }
            
            .preferredColorScheme(.dark)
       // }
    }
}

#Preview {
    Project_19_SnowSeeker_DetailView(data: .example, id: "")
        .environment(Project_19_SnowSeeker_Favorite_Class())
}
