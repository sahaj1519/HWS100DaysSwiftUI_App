//
//  Project_12_SwiftDataProject_UserEditView.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 14/03/25.
//
import SwiftData
import SwiftUI

struct Project_12_SwiftDataProject_UserEditView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query var dataInstance: [Project_12_SwiftdataProject_DataModel]
    
    init(minimumJoinDate: Date, sortOrder: [SortDescriptor<Project_12_SwiftdataProject_DataModel>]){
        
        _dataInstance = Query(filter: #Predicate<Project_12_SwiftdataProject_DataModel> { user in
            user.joinDate >= minimumJoinDate
        }, sort: sortOrder )
    }
    func addJobsSample(){
        let user1 = Project_12_SwiftdataProject_DataModel(name: "Yaman", city: "London", joinDate: .now)
        let job1 = Project_12_SwiftDataProject_Job(name: "Do Developing", priority: 3)
        let job2 = Project_12_SwiftDataProject_Job(name: "Do Gym", priority: 3)
        
        modelContext.insert(user1)
        
        user1.jobArray?.append(job1)
        user1.jobArray?.append(job2)
        
    }
    
    var body: some View {
       
            List{
               
                    ForEach(dataInstance){item in
                        HStack{
                            Text(item.name)
                            
                            Spacer()
                            Text("^[\(item.unwrappedJobs.count)\tJob](inflect: true)")
                                .fontWeight(.black)
                                .padding(.horizontal, 7)
                                .padding(.vertical, 5)
                                .background(.black)
                                .clipShape(.capsule)
                        }
                }
            .preferredColorScheme(.dark)
            .onAppear(perform: addJobsSample)
        }
    }
        
    
}

#Preview {
    
   
    Project_12_SwiftDataProject_UserEditView(minimumJoinDate: .now , sortOrder: [SortDescriptor(\Project_12_SwiftdataProject_DataModel.name)])
        .modelContainer(for: Project_12_SwiftdataProject_DataModel.self)
    
    
    
}
