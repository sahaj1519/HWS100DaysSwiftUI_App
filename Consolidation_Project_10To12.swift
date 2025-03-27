//
//  Consolidation_Project_10To12.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 15/03/25.
//
import SwiftData
import SwiftUI

struct Consolidation_Project_10To12: View {
    @Environment(\.modelContext) var modelContext
    @Query var data: [Consolidation_Project_10To12_DataModelUser]
    
    init() {
        
            }
        
    
    func deleteAllUser(context: ModelContext){
        do{
            let fetch = FetchDescriptor<Consolidation_Project_10To12_DataModelUser>()
            let users = try context.fetch(fetch)
            
            for user in users{
                context.delete(user)
            }
            try context.save()
            print("succesfully deleted all users")
        }catch{
            print("failed to all delete users")
        }
    }
    
    func deleteSwiftDataStore() {
        let appSupportURL = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
            let fileManager = FileManager.default
            
            let storeFiles = ["default.store", "default.store-wal", "default.store-shm"]
            
            for fileName in storeFiles {
                let fileURL = appSupportURL.appendingPathComponent(fileName)
                
                do {
                    if fileManager.fileExists(atPath: fileURL.path) {
                        try fileManager.removeItem(at: fileURL)
                        print("✅ Deleted: \(fileURL.path)")
                    } else {
                        print("⚠️ Not found: \(fileURL.path)")
                    }
                } catch {
                    print("❌ Failed to delete \(fileURL.path): \(error)")
                }
            }
    }
    var body: some View {
        NavigationStack{
            List{
               
                ForEach(data){ item in
                    NavigationLink(value: item){
                        HStack{
                           
                            Image(systemName: "circle.fill")
                                .font(.system(size: 9))
                                .padding(.trailing, 30)
                               .foregroundStyle(item.isActive ? .green : .gray)
                               
                            Text(item.name)
                                .font(.headline.weight(.heavy))
                                .foregroundStyle(item.isActive ? .green : .white)
                                .padding(.vertical, 6)
                        }
                    }
                }
                
            }.scrollIndicators(.never)
            .padding(.vertical, 10)
            
            .navigationTitle("Users")
            .preferredColorScheme(.dark)
            .navigationDestination(for: Consolidation_Project_10To12_DataModelUser.self){ user in
                Consolidation_Project_10To12_DetailView(dataInstance: user)
            }
            .toolbar{
                ToolbarItem{
                    Button("Delete All Users"){
                        deleteSwiftDataStore()
                    }
                }
            }
        }
        .task {
          await  fetchFiles(modelContext: modelContext)
        }
        
    }
}

#Preview {
    Consolidation_Project_10To12()
        .modelContainer(for: Consolidation_Project_10To12_DataModelUser.self)
}
