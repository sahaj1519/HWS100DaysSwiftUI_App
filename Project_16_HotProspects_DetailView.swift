//
//  Project_16_HotProspects_DetailView.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 20/03/25.
//
import SwiftData
import SwiftUI

struct Project_16_HotProspects_DetailView: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @Bindable var data: Project_16_HotProspects_DataModel
    
    @State private var enteredName: String
    @State private var enteredEmailAddress: String
    
   
    init(data: Project_16_HotProspects_DataModel) {
        self.data = data
        _enteredName =  State(initialValue: data.name)
        _enteredEmailAddress = State(initialValue: data.emailAddress)
        
        
    }
    
    func updatePerson(){
            data.name = enteredName
           data.emailAddress = enteredEmailAddress
           
            try? modelContext.save()
       
    }
    
    var body: some View {
        
            
            Form{
                Section(""){
                    TextField("Name", text: $data.name)
                        .textContentType(.name)
                    
                    
                    TextField("Email", text: $data.emailAddress)
                        .textContentType(.emailAddress)
                }
                Section{
                    Button("Save"){
                        try? modelContext.save()
                        dismiss()
                    }
                }
            }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    if let container = try? ModelContainer(for: Project_16_HotProspects_DataModel.self, configurations: config){
        let data = Project_16_HotProspects_DataModel(name: "Yohio", emailAddress: "dbfhbfhwe2@.com", isContacted: false)
        
        Project_16_HotProspects_DetailView(data: data)
            .modelContainer(container)
    }else{
       Text("failed to create preview")
    }
    
    
   
        
}
