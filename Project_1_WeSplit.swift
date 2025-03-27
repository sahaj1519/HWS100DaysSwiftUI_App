//
//  Project-1-WeSplit.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 03/03/25.
//

import SwiftUI

struct Project_1_WeSplit: View {
    
    @State private var amount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState  private var isFocusAmount: Bool
    
    let tipPercentageArray = [10, 20, 30 ,50, 0]
    
    var body: some View {
        
        var returnAmountPerPerson: (Double, Double){
          @State  var tipValue = amount * Double(tipPercentage)/100
          @State  var finalAmountAfterTip = amount + tipValue
           @State var amountPerPerson = finalAmountAfterTip / Double(numberOfPeople + 2)
            
            
            return (amountPerPerson, finalAmountAfterTip)
        }
        
        NavigationStack{
            
            List{
                Section{
                    TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($isFocusAmount)
                      
                    
                    Picker("Number of people", selection: $numberOfPeople){
                        ForEach(2..<11){
                            Text("\($0) people")
                        }
                    }
                }
                Section("How much would you like to tip?"){
                    Picker("Tip Selection", selection: $tipPercentage){
                        ForEach(tipPercentageArray, id: (\.self)){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                Section("Final amount after tip"){
                    Text("\(returnAmountPerPerson.1)")
                        .foregroundColor(tipPercentage == 0 ? .red : .black)
                }
                Section("Amount per person"){
                    Text("\(returnAmountPerPerson.0)")
                }
               
                    HStack{
                        
                        Spacer()
                        Button("Reset", role:.destructive){
                            amount = 0
                        }
                        .font(.title3.weight(.bold))
                        Spacer()
                    }
                
            }
            .navigationTitle("WeSplit")
            .navigationBarTitleDisplayMode(.large)
            .toolbar{
                if isFocusAmount {
                    Button("Done"){
                        isFocusAmount = false
                    }
                }
            }
           
        }
        
    
        
    }
    
}

#Preview{
    Project_1_WeSplit()
}
