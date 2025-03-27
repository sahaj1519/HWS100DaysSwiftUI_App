//
//  Project_10_CupcakeCorner.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 12/03/25.
//
import SwiftUI





struct Project_10_CupcakeCorner: View {
  
    @State private var dataModelInstance = Project_10_CupcakeCorner_DataModel()
   
    init(){
        if let userdata = UserDefaults.standard.data(forKey: "userAddress"){
            if  let decoded = try? JSONDecoder().decode(Project_10_CupcakeCorner_DataModel.self, from: userdata){
                dataModelInstance.name = decoded.name
                dataModelInstance.streetAdress = decoded.streetAdress
                dataModelInstance.city  = decoded.city
                dataModelInstance.zipCode = decoded.zipCode
            }
        }
        return 
    }
    
    var body: some View {
        NavigationStack{
            
            Form{
                Section{
                    Picker("Select your cake type", selection: $dataModelInstance.cupCakeType){
                        ForEach(Project_10_CupcakeCorner_DataModel.cupCakeTypesArray.indices, id: \.self){
                            Text(Project_10_CupcakeCorner_DataModel.cupCakeTypesArray[$0])
                            
                        }
                    }
                    Stepper("No of Cupcakes: \(dataModelInstance.noOfCupCake)", value: $dataModelInstance.noOfCupCake, in: 3...20)
                }
                
               
                
                Section{
                    Toggle("Any Special Request", isOn: $dataModelInstance.anySpecialRequest)
                    if dataModelInstance.anySpecialRequest {
                        Toggle("Add Extra Frosting", isOn: $dataModelInstance.extraFrosting)
                        Toggle("Add Sprinkles", isOn: $dataModelInstance.addSprinkles)
                    }
                    
                }
                Section{
                    NavigationLink("Delivery Address"){
                        Project_10_CupcakeCorner_AddressView(addressData: dataModelInstance)
                    }
                }
            }.padding(.vertical)
                .navigationTitle("Cupcake Corner")
                .toolbar{
                    ToolbarItem(placement: .topBarLeading){
                        Text( !dataModelInstance.name.isEmpty ? "Hi \(dataModelInstance.name)!" : "")
                            .font(.headline.weight(.heavy))
                    }
                }
        }
    }
}

#Preview {
    Project_10_CupcakeCorner()
        .preferredColorScheme(.dark)
}
