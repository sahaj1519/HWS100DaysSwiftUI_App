//
//  Project_8_MoonShot_AnotherDetailView.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 09/03/25.
//

import SwiftUI

struct Project_8_MoonShot_AnotherDetailView: View {
    let astronaut: Project_8_MoonShot_Astronaut
    
    var body: some View {
        ScrollView{
            VStack{
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                    .accessibilityLabel(" image of Astronaut \(astronaut.name)")
                Text(astronaut.description)
                    .font(.headline.italic().weight(.light))
                    .padding()
                    .accessibilityLabel("description of astronaut \(astronaut.name)")
            }
            
        }
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
}

#Preview {
    let astronauts: [String : Project_8_MoonShot_Astronaut] = Bundle.main.decode("astronauts.json")
   return Project_8_MoonShot_AnotherDetailView(astronaut: astronauts["aldrin"]!)
        .preferredColorScheme(.dark)
}
