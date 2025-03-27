//
//  Project_19_SnowSeeker.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 23/03/25.
//

import SwiftUI

struct Project_19_SnowSeeker: View {
    
    @State  var  data: [Project_19_SnowSeeker_DataModel] = Bundle.main.decodeFile("resorts.json")
    
    @State private var favoriteData = Project_19_SnowSeeker_Favorite_Class()
    
    @State private var searchText = ""
    @State private var sortBy = 0
    
    @State private var sortArray = ["Default","Name", "Country"]
    
    
    var filterResort: [Project_19_SnowSeeker_DataModel] {
        let filteredData = searchText.isEmpty ? data : data.filter { $0.name.localizedStandardContains(searchText) }
            
            if sortBy == 1 {
                return filteredData.sorted { $0.name < $1.name }
            } else if sortBy == 2 {
                return filteredData.sorted { $0.country < $1.country }
            }
            
            return filteredData
    }
    
    var body: some View {
        NavigationSplitView{
            List{
                ForEach(filterResort) { item in
                    
                        NavigationLink(value: item){
                            HStack{
                            Image(item.country)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 40, height: 25)
                                .clipShape(.rect(cornerRadius: 5))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(.black, lineWidth: 1)
                                )
                            
                          
                            
                            VStack(alignment: .leading){
                                
                                Text(item.name)
                                    .font(.headline)
                                
                                Text("\(item.runs) runs")
                                    .foregroundStyle(.secondary)
                                
                            }
                            
                                if favoriteData.containsId(item) {
                                    Spacer()
                                    Image(systemName: "heart.fill")
                                    .accessibilityLabel("This is a favorite resort")
                                        .foregroundStyle(.red)
                                }
                        }
                            
                       
                        
                    }
                }
            }
            .navigationTitle("Resorts")
            .navigationDestination(for: Project_19_SnowSeeker_DataModel.self){ resort in
                Project_19_SnowSeeker_DetailView(data: resort, id: resort.id)
            }
            .searchable(text: $searchText, prompt: "Search for a resort")
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Menu("Sort", systemImage: "arrow.up.arrow.down"){
                        Picker("Sort", selection: $sortBy ){
                            ForEach(0..<sortArray.count, id: \.self){i in
                                Text(sortArray[i])
                            }
                        }
                    }
                }
            }
        }detail: {
            Project_19_SnowSeeker_WelcomeView()
        }
        .environment(favoriteData)
        
        .preferredColorScheme(.dark)
    }
}

#Preview {
    Project_19_SnowSeeker()
        
}
