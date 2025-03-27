//
//  Project_7_iExpense.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 08/03/25.
//
import SwiftData
import SwiftUI


struct Project_7_iExpense: View {
    @Environment(\.modelContext) var modelContext
   
    
    @State private var isShowAnotherView = false
    @State private var isShowPersonalExpense = false
  
    
    
    
    @State var sortOrder = [
        SortDescriptor(\Project_7_iExpense_DataModel.name),
        SortDescriptor(\Project_7_iExpense_DataModel.amount)
         ]
    
    
    
    var body: some View {
        NavigationStack{
                     
     Project_7_iExpense_DetailView(type: isShowPersonalExpense ? "Personal" :  "", sortOrder: sortOrder)
            
            
            
            .navigationTitle("iExpense")
            .navigationBarTitleDisplayMode(.large)
            .preferredColorScheme(.dark)
           
            
           .sheet(isPresented: $isShowAnotherView){
                Project_7_iExpense_Another_View()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing){
                    Button("Add New Expense", systemImage: "plus"){
                        isShowAnotherView = true
                    }
                }
                ToolbarItem(placement: .bottomBar){
                    Menu("Sort", systemImage: "arrow.up.arrow.down"){
                        Picker("Sort Items", selection: $sortOrder ){
                            Text("Sort By Name")
                            .tag([
                                SortDescriptor(\Project_7_iExpense_DataModel.name),
                                SortDescriptor(\Project_7_iExpense_DataModel.amount)
                            ])
                            Text("Sort By Amount")
                                .tag([
                                    SortDescriptor(\Project_7_iExpense_DataModel.amount, order: .reverse),
                                    SortDescriptor(\Project_7_iExpense_DataModel.name)
                                ])
                        }
                    }
                }
                ToolbarItem(placement: .topBarLeading){
                    EditButton()
                }
                ToolbarItem{
                    Button(isShowPersonalExpense ? "Show All Expense" : "Show Personal Expense"){
                        isShowPersonalExpense.toggle()
                    }
                }
               
            }
        }
    }
}

#Preview {
    Project_7_iExpense()
        .modelContainer(for: Project_7_iExpense_DataModel.self)
        
}
