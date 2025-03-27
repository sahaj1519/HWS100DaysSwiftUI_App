//
//  Project_16_HotProspects.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 19/03/25.
//
import SwiftData
import SwiftUI
import UserNotifications

struct Project_16_HotProspects: View {
    
    
    var body: some View {
        TabView{
            
            Project_16_HotProspects_ProspectView(filter: .none)
                .tabItem {
                    Label("Everyone", systemImage: "person.3")
                }
            Project_16_HotProspects_ProspectView(filter: .contacted)
                .tabItem {
                    Label("Contacted", systemImage: "checkmark.circle")
                }
            Project_16_HotProspects_ProspectView(filter: .uncontacted)
                .tabItem {
                    Label("Uncontacted", systemImage: "questionmark.diamond")
                }
            Project_16_HotProspects_MeView()
                .tabItem {
                    Label("Me", systemImage: "person.crop.square")
                }
                .preferredColorScheme(.dark)
        }
        
    }
}

#Preview {
    Project_16_HotProspects()
           .modelContainer(for: Project_16_HotProspects_DataModel.self)
}
