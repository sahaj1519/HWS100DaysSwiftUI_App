//
//  Project_7_iExpense_DetailView.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 15/03/25.
//
import SwiftData
import SwiftUI

//
//  Project_7_iExpense.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 08/03/25.
//
import SwiftData
import SwiftUI


struct Project_7_iExpense_DetailView: View {
    @Environment(\.modelContext) var modelContext
    @Query  var expenses: [Project_7_iExpense_DataModel]
    
    
    
    func removeFromList(at indexes: IndexSet){    // function to remove item from list
        for index in indexes {
            let item = expenses[index]
            modelContext.delete(item)
        }
       
    }
    
    init(type: String, sortOrder: [SortDescriptor<Project_7_iExpense_DataModel>]){
        _expenses = Query(filter: type == "Personal" ? #Predicate<Project_7_iExpense_DataModel> { item in
            item.type == "Personal"
            
        } : nil, sort: sortOrder)
    }
    
    var body: some View {
      
           
                List{
                     ForEach(expenses){ item in
                            HStack{
                                VStack(alignment: .leading){
                                    Text(item.name)
                                        .font(.title3.weight(.bold))
                                    Text(item.type)
                                        .font(.subheadline.italic().weight(.semibold))
                                }
                                Spacer()
                                
                                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                    .font(.title3.weight(.bold))
                                    .foregroundStyle(item.amount < 51 ? .green : item.amount < 1001 ? .yellow : .red)
                                
                                
                            }.accessibilityElement(children: .combine)
                             .accessibilityLabel("\(item.name), \(item.amount.formatted(.currency(code: "INR"))) rupees")
                             .accessibilityHint("Expense category: \(item.type)")
                            
                        }.onDelete(perform: removeFromList)
                        
                }
            
            .preferredColorScheme(.dark)
           
    }
}

#Preview {
    Project_7_iExpense_DetailView(type: "Personal", sortOrder: [SortDescriptor(\Project_7_iExpense_DataModel.name)])
        .modelContainer(for: Project_7_iExpense_DataModel.self)
        
}

