//
//  Project_7_iExpense_Another_View.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 08/03/25.
//
import SwiftData
import SwiftUI

struct  Project_7_iExpense_Another_View: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
   
    @State private var enterName = ""
    @State private var whichType = "Personal"
    @State private var enterAmount = 0.0
    
    @State private var isAlert = false
    
   
    
    var whichTypeArray = ["Personal", "Bussiness"]
    
   
    
    var body: some View {
        
        NavigationStack{
            
            Form{
                TextField("Name", text: $enterName)
                Picker("Type", selection: $whichType){
                    ForEach(whichTypeArray, id: (\.self)){
                        Text("\($0)")
                    }
                }
                TextField("Amount", value: $enterAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
            }
            .toolbar{
                Button("Save"){
                    guard enterName.count > 0 else{
                        isAlert = true
                            
                        return
                    }
                    let addingItem = Project_7_iExpense_DataModel(name: enterName, type: whichType, amount: enterAmount)
                    modelContext.insert(addingItem)
                    dismiss()
                }.alert("Please Enter Name", isPresented: $isAlert){
                    
                }
            }
            .navigationTitle("Add Expense")
            .navigationBarTitleDisplayMode(.inline)
            .preferredColorScheme(.dark)
            //.navigationBarBackButtonHidden()
        }
    }
}

#Preview {
   
        Project_7_iExpense_Another_View()
        
      
}
