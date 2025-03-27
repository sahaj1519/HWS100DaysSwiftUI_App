//
//  Project_8_MoonShot.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 09/03/25.
//

import SwiftUI

struct Project_8_MoonShot: View {
    
    let astronautFileData: [String : Project_8_MoonShot_Astronaut] = Bundle.main.decode("astronauts.json")
    let missionFileData: [Project_8_MoonShot_Mission] = Bundle.main.decode("missions.json")
    
    @State private var isGridView = true
    
    
    
    
    let coloumn = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    
    
    var body: some View {
     
        NavigationStack{
            
            
            
            
            Group{
                if !isGridView {
                   
                        Project_8_MoonShot_ListLayoutView()
              
                }else{
                  
            Group{
                ScrollView{
                    
                    LazyVGrid(columns: coloumn){
                        ForEach(missionFileData){ item in
                            
                            NavigationLink(value: item){
                                //  Project_8_MoonShot_DetailView(mission: item, astronauts: astronautFileData)
                               
                                VStack{
                                    Image(item.image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                        .padding()
                                        
                                    
                                    VStack{
                                        
                                        Text(item.displayName)
                                            .font(.headline.weight(.bold))
                                            .foregroundStyle(.white)
                                            .accessibilityLabel("mission \(item.displayName)")
                                        
                                        Text(item.formattedDate)
                                            .font(.caption)
                                            .foregroundStyle(.white.opacity(0.3))
                                            .accessibilityLabel(item.formattedDate == "N/A" ? "launch date not available" : "launch date \(item.formattedDate)")
                                        
                                    }.padding(.vertical)
                                        .frame(maxWidth: .infinity)
                                        .background(.lightBackground)
                                    
                                } .clipShape(.rect(cornerRadius: 10))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(.lightBackground) )
                                
                                
                            }
                        
                        }
                    }
                }
            } .padding([.horizontal, .bottom])
        }
        
                
            }.navigationDestination(for: Project_8_MoonShot_Mission.self) { selectedMission in
                Project_8_MoonShot_DetailView(mission: selectedMission, astronauts: astronautFileData)
            }
           
            
            
                .navigationTitle("MoonShot")
                .navigationBarTitleDisplayMode(.automatic)
                .background(.darkBackground)
                .preferredColorScheme(.dark)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            isGridView.toggle()
                            //  Project_8_MoonShot_ListLayoutView()
                            
                        }) {
                            Image(systemName: isGridView ? "list.bullet" : "square.grid.2x2")
                                .accessibilityLabel(isGridView ? "List view" : "Grid View")
                        }
                    }
                }
        }
        
    }
}

#Preview {
    Project_8_MoonShot()
}
