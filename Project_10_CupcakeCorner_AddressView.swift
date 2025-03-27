//
//  Project_10_CupcakeCorner_AddressView.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 13/03/25.
//

import SwiftUI

struct Project_10_CupcakeCorner_AddressView: View {
    
    
    
    @Bindable var addressData: Project_10_CupcakeCorner_DataModel
        
   
    
    
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Your Name", text: $addressData.name)
                    TextField("Enter street address", text: $addressData.streetAdress)
                    TextField("Enter city", text: $addressData.city)
                    TextField("Enter Pincode", text: $addressData.zipCode)
                }
                Section{
                    NavigationLink("Checkout"){
                            
                            Project_10_CupcakeCorner_CheckoutView(checkoutData: addressData)
                        }
                    
                }.disabled(addressData.hasValidAddress == false)
            }.padding(.vertical)
            .navigationTitle("Deliver Details")
            .onDisappear{
                Project_10_CupcakeCorner_DataModel.SaveUserAddress(addressData)
            }
        }
    
    }
}

#Preview {
   
    Project_10_CupcakeCorner_AddressView(addressData: Project_10_CupcakeCorner_DataModel())
        .preferredColorScheme(.dark)
}
