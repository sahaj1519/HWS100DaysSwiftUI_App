//
//  Consolidation_Project_10To12_DetailView.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 15/03/25.
//
import SwiftData
import SwiftUI

struct Consolidation_Project_10To12_DetailView: View {
    
    @Bindable var dataInstance: Consolidation_Project_10To12_DataModelUser
    
    
    
    var body: some View {
       
        
            
            ZStack{
                
                RadialGradient(colors: [.orange, .yellow, .green], center: .bottomTrailing, startRadius: 200, endRadius: 500)
                    .ignoresSafeArea()
                ScrollView{
                    VStack(alignment: .leading, spacing: 15){
                        
                        Text("User :\t\(dataInstance.name)")
                            .font(.largeTitle.bold())
                            .foregroundStyle(.secondary)
                            .padding(.vertical, 5)
                            .frame(maxWidth: .infinity)
                            .background(.regularMaterial)
                            .clipShape(.rect(cornerRadius: 10))
                       
                        HStack(alignment: .lastTextBaseline){
                            
                            Image(systemName: "circle.fill")
                                .font(.system(size: 14))
                                .padding(.leading,1)
                                .foregroundStyle(dataInstance.isActive ? .green : .gray)
                            Text(dataInstance.isActive ? "Active" : "Not Active")
                                .font(.headline.italic())
                                .foregroundStyle(dataInstance.isActive ? .green : .gray)
                            Spacer()
                        }
                        Divider()
                        Text("User ID :\t\(dataInstance.id.uuidString.prefix(6))")
                            .font(.headline.bold())
                            .foregroundStyle(.blue)
                        Divider()
                        Text("Age:\t\(dataInstance.age)")
                            .font(.headline)
                        Divider()
                        Text("Company:\t\(dataInstance.company)")
                            .font(.headline)
                        Divider()
                        Text("Registered Date:\t\(dataInstance.registered.formatted(date: .long , time: .shortened))")
                            .font(.headline)
                        Divider()
                          
                       
                        Text("Email:\t\(dataInstance.email)")
                            .font(.headline)
                            .foregroundStyle(.purple)
                        Divider()
                        Text("Address:\t\(dataInstance.address)")
                            .font(.headline)
                            .foregroundStyle(.white.opacity(0.7))
                        Divider()
                        
                        
                        Text("About:\t\(dataInstance.about)")
                            .font(.subheadline.italic().bold())
                        
                           
                        
                      
                    
                }.padding()
                .background(.regularMaterial)
                .frame(maxWidth: .infinity)
                .clipShape(.rect(cornerRadius: 10))
                
                
                    
                 //   VStack(alignment: .leading, spacing: 5){
                        HStack{
                            Text("Friends")
                                .font(.title.weight(.heavy))
                                .padding(.vertical, 5)
                                 .frame(maxWidth: .infinity)
                                .background(.regularMaterial)
                                .clipShape(.rect(cornerRadius: 10))
                            
                            Spacer()
                        }.padding(.bottom, 5)
                       
                            if let friends = dataInstance.friends, !friends.isEmpty {
                                
                                ForEach(friends){ onefirend in
                                   // Divider()
                                    
                                    Text("User Name:\t\(onefirend.name)")
                                        .font(.title2.bold())
                                        .foregroundStyle(.black)
                                    
                                    Text("User ID:\t\(onefirend.id.uuidString.prefix(6))")
                                        .font(.headline.weight(.heavy))
                                        .foregroundStyle(.black.opacity(0.7))
                                    
                                    Divider()
                                    
                                }
                                
                            }
                       
                  //  }.padding()
                  //  .frame(maxWidth: .infinity)
                   //   .background(.ultraThinMaterial)
                   //   .clipShape(.rect(cornerRadius: 10))
                
                
            }.padding(5)
                .navigationTitle("")
                .navigationBarTitleDisplayMode(.inline)
                .preferredColorScheme(.dark)
                .scrollBounceBehavior(.basedOnSize)
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    if let container = try? ModelContainer(for: Consolidation_Project_10To12_DataModelUser.self, configurations: config){
        let example = Consolidation_Project_10To12_DataModelUser(id: UUID(), isActive: true, name: "Akia Yaman", age: 21, company: "Dream ltd", email: "akiayaman@icloud.com", address: "London street - nomada 123", about: "this is a about string of the example user it will show like this", registered: .now, tags: ["array", "of", "strings", "what", "else"])
       
      //  let friend = Consolidation_Project_10To12_DataModel_Friend(id: UUID(), name: "friend", owner: example)
       
        Consolidation_Project_10To12_DetailView(dataInstance: example )
            .modelContainer(container)
    }else{
        Text("failed to create preview")
    }
    
   
}
