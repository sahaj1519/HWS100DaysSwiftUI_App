//
//  Consolidation_Project_16To18_DetailView.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 22/03/25.
//
import SwiftData
import SwiftUI

struct Consolidation_Project_16To18_DetailView:View {
    @Environment(\.modelContext) var modelContext
    
    @Query(sort: \Consolidation_Project_16To18_DataModel.date, order: .reverse) var data: [Consolidation_Project_16To18_DataModel]
    
    func delete(at index: IndexSet){
        
        for i in index{
            modelContext.delete(data[i])
        }
        try? modelContext.save()
    }
    
    var body: some View {
        List{
            
            ForEach(data, id: \.id){ item in
                VStack(alignment: .leading){
                    Text("Rolled\t\(item.rolledNumber)")
                        .font(.title)
                    
                    
                    Text("\(item.sideInDice)-sided dice")
                        .font(.headline)
                        .foregroundStyle(.white.opacity(0.8))
                    
                    
                }
            }.onDelete(perform: delete)
            
            
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    Consolidation_Project_16To18_DetailView()
}


