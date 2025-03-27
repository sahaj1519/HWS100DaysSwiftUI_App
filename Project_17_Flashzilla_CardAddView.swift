//
//  Project_17_Flashzilla_CardAddView.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 21/03/25.
//

import SwiftUI

struct Project_17_Flashzilla_CardAddView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var dataArray = [Project_17_Flashzilla_DataModel]()
    
    
    let dataKey = "Cards"
    
    @State private var enterPrompt = ""
    @State private var enterAnswer = ""
    
    func loadData(){
        
        do{
            let data = try Data(contentsOf: URL.documentsDirectory.appending(path: "FlashZilla"))
            let decoder = try JSONDecoder().decode([Project_17_Flashzilla_DataModel].self, from: data)
                    dataArray = decoder
                
        }catch{
            print("failed to decode data \(error.localizedDescription)")
        }
    }
    
   
    
    func saveData(){
        do{
            let encoded = try JSONEncoder().encode(dataArray)
            try encoded.write(to: URL.documentsDirectory.appending(path: "FlashZilla"))
            
        }catch{
            print("failed to save data \(error.localizedDescription)")
        }
            
    }
    
    func addCard(){
        let trimmedPrompt = enterPrompt.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = enterAnswer.trimmingCharacters(in: .whitespaces)
        guard trimmedAnswer.isEmpty == false && trimmedPrompt.isEmpty == false else{ return}
        
        let card = Project_17_Flashzilla_DataModel(id: UUID(), prompt: trimmedPrompt, answer: trimmedAnswer)
        dataArray.insert(card, at: 0)
        enterPrompt = ""
        enterAnswer = ""
    }
    
    func removeCard(at index: IndexSet){
        dataArray.remove(atOffsets: index)
        saveData()
    }
    
    
    var body: some View {
        NavigationStack{
            List{
                Section("Add card"){
                    TextField("Your Question", text: $enterPrompt)
                        .autocorrectionDisabled(true)
                    
                    TextField("Answer of question", text: $enterAnswer)
                        .autocorrectionDisabled(true)
                    Button("Add Card"){
                        addCard()
                        saveData()
                        
                    }
                }
                    Section{
                        
                            ForEach(0..<dataArray.count, id: \.self) { i in
                                VStack(alignment: .leading){
                                Text(dataArray[i].prompt)
                                    .font(.headline)
                                
                                    Text(dataArray[i].answer)
                                        .font(.subheadline)
                                        .foregroundStyle(.white.opacity(0.7))
                                
                                }
                            
                        }.onDelete(perform: removeCard)
                    }
                    
               
                
                
            }
            .navigationTitle("Add Your Card")
            .navigationBarTitleDisplayMode(.inline)
            .preferredColorScheme(.dark)
            .toolbar{
                ToolbarItem{
                    Button("Done"){
                        dismiss()
                    }
                }
            }.onAppear(perform: loadData)
        }
        
    }
}

#Preview {
    Project_17_Flashzilla_CardAddView()
}
