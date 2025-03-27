//
//  Project_12_SwiftDataProject.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 14/03/25.
//
import SwiftData
import SwiftUI

struct Project_12_SwiftDataProject: View {
    @Environment(\.modelContext) var modelContext
    
    
    @State private var isShowOnlyUpcomingUser = false
    
    @State var sortOrder = [
        SortDescriptor(\Project_12_SwiftdataProject_DataModel.name),
        SortDescriptor(\Project_12_SwiftdataProject_DataModel.joinDate)
    ]
    
    var body: some View {
        NavigationStack{
            Project_12_SwiftDataProject_UserEditView(minimumJoinDate: isShowOnlyUpcomingUser ? .now : .distantPast, sortOrder: sortOrder)
               
             
            .navigationTitle("Users")
            .preferredColorScheme(.dark)
            .toolbar{
                ToolbarItem( placement: .topBarTrailing){
                    Button("Add Sample data", systemImage: "plus"){
                        try? modelContext.delete(model: Project_12_SwiftdataProject_DataModel.self)
                        
                        let first = Project_12_SwiftdataProject_DataModel(name: "Ed Sheeran", city: "London", joinDate: .now.addingTimeInterval(86400 * -10))
                        let second = Project_12_SwiftdataProject_DataModel(name: "Rosa Diaz", city: "New York", joinDate: .now.addingTimeInterval(86400 * -5))
                        let third = Project_12_SwiftdataProject_DataModel(name: "Roy Kent", city: "London", joinDate: .now.addingTimeInterval(86400 * 5))
                        let fourth = Project_12_SwiftdataProject_DataModel(name: "Johnny English", city: "London", joinDate: .now.addingTimeInterval(86400 * 10))
                        let fifth = Project_12_SwiftdataProject_DataModel(name: "Akia", city: "Dream", joinDate: .now.addingTimeInterval(86400 * -20))
                        
                        modelContext.insert(first)
                        modelContext.insert(second)
                        modelContext.insert(third)
                        modelContext.insert(fourth)
                        modelContext.insert(fifth)
                        
                        
                    }
                }
                ToolbarItem{
                    Button(isShowOnlyUpcomingUser ? "Show Everyone" : "Show Upcoming"){
                        isShowOnlyUpcomingUser.toggle()
                    }
                }
               
                    ToolbarItem(placement: .topBarLeading){
                        Menu("Sort", systemImage: "arrow.up.arrow.down"){
                        Picker("Sort Users", selection: $sortOrder){
                            Text("Sort by Name")
                                .tag([
                                    SortDescriptor(\Project_12_SwiftdataProject_DataModel.name),
                                    SortDescriptor(\Project_12_SwiftdataProject_DataModel.joinDate)
                                ])
                            Text("Sort by Join Date")
                                .tag([
                                    SortDescriptor(\Project_12_SwiftdataProject_DataModel.joinDate),
                                    SortDescriptor(\Project_12_SwiftdataProject_DataModel.name)
                                    
                                ])
                        }
                    }
                }
            }
            
                
            }
            
        }
}


#Preview {
    Project_12_SwiftDataProject()
        .modelContainer(for: Project_12_SwiftdataProject_DataModel.self)
}
