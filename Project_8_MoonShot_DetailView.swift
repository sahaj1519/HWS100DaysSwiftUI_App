//
//  Project_8_MoonShot_DetailView.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 09/03/25.
//

import SwiftUI

struct Project_8_MoonShot_DetailView: View, Hashable {
    
    let crew: [CrewMember]
    
    
    
    struct CrewMember: Hashable{
        let role: String
        let astronaut: Project_8_MoonShot_Astronaut
    }
    
    
    init(mission: Project_8_MoonShot_Mission, astronauts: [String: Project_8_MoonShot_Astronaut]){
        self.mission = mission
        
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name]{
                return CrewMember(role: member.role, astronaut: astronaut)
            }else{
                fatalError("missing \(member.name)")
            }
        }
    }
    
    let mission: Project_8_MoonShot_Mission
    var body: some View {
     //   NavigationStack{
            ScrollView{
                VStack{
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .containerRelativeFrame(.horizontal){ width , axis in
                            width * 0.6
                        }.padding(.top)
                        .accessibilityLabel("\(mission.displayName) Logo")
                    Text(mission.launchDate?.formatted(date: .complete , time: .standard) ?? "N/A")
                        .font(.headline.weight(.light))
                        .frame(maxWidth: .infinity)
                        .padding(.top)
                        .accessibilityLabel("launch date of \(mission.displayName)")
                    VStack(alignment: .leading){
                        
                        Rectangle() // custom divider
                            .frame(height: 2)
                            .foregroundStyle(.lightBackground)
                            .padding(.vertical)
                        
                        
                        Text("Mission Highlights")
                            .font(.title.weight(.bold))
                            .padding(.bottom, 5)
                        
                        Text(mission.description)
                            .font(.headline.italic().weight(.semibold))
                            .accessibilityLabel("description of \(mission.displayName) Mission")
                        
                        Rectangle() // custom divider
                            .frame(height: 2)
                            .foregroundStyle(.lightBackground)
                            .padding(.vertical)
                            .accessibilityLabel("")
                        
                        Text("Crew")
                            .font(.title.weight(.heavy))
                            .padding(.bottom, 5)
                            .accessibilityLabel("information about crew members of \(mission.displayName)")
                    }.padding(.horizontal)
                    
                   
                    
                    
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack{
                            ForEach(crew, id: (\.role)) { item in
                                NavigationLink{
                                    Project_8_MoonShot_AnotherDetailView(astronaut: item.astronaut)
                                }label: {
                                    HStack{
                                        Image(item.astronaut.id)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 104, height: 72)
                                            .clipShape(.capsule)
                                            .overlay(
                                                Capsule()
                                                    .strokeBorder(.white, lineWidth: 1)
                                            )
                                          
                                        
                                        VStack(alignment: .leading){
                                            Text(item.astronaut.name)
                                                .font(.headline.bold())
                                                .foregroundStyle(.white.opacity(0.8))
                                            
                                            Text(item.role)
                                                .font(.subheadline.weight(.semibold))
                                                .foregroundStyle(.white.opacity(0.4))
                                            
                                        }
                                        
                                    }.accessibilityElement(children: .combine)
                                        .accessibilityLabel("\(item.astronaut.name) . \(item.role)")
                                        .accessibilityHint("Tap to view details")
                                }
                                
                            }
                        }
                    }
                    
                }.padding(.bottom)
                
            }
            
            .navigationTitle(mission.displayName)
            .navigationBarTitleDisplayMode(.inline)
            .background(.darkBackground)
       // }
    }
}

#Preview {
    let missions: [Project_8_MoonShot_Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String : Project_8_MoonShot_Astronaut] = Bundle.main.decode("astronauts.json")
    Project_8_MoonShot_DetailView(mission: missions[1], astronauts: astronauts)
        .preferredColorScheme(.dark)
}
