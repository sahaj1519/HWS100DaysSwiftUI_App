//
//  Project_10_CupcakeCorner_CheckoutView.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 13/03/25.
//

import SwiftUI

struct Project_10_CupcakeCorner_CheckoutView: View {
    
    @State private var alertConfimationMessage = ""
    @State private var isAlert = false
    
    @Bindable var checkoutData: Project_10_CupcakeCorner_DataModel
    func uploadData() async {
        
        guard let encoded = try? JSONEncoder().encode(checkoutData) else{
            return print("failed to encode data")
        }
       
             let url = URL(string: "https://reqres.in/api/cupcakes")!
      //  let know = String(decoding: encoded, as: UTF8.self) // for checking data in encoded
      //    print(know)
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            
        do{
            
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            //handle the result
            
            let  decoded = try JSONDecoder().decode(Project_10_CupcakeCorner_DataModel.self, from: data)
            alertConfimationMessage = "your oder for \(decoded.noOfCupCake) \(Project_10_CupcakeCorner_DataModel.cupCakeTypesArray[decoded.cupCakeType]) cupcakes is on the way!"
            isAlert = true
            
            
        }catch{
            alertConfimationMessage = "You seems offline! Try to connect to internet"
            isAlert = true
            print("checkout failed  \(error.localizedDescription)")
        }
       
    }
    
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
                    AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3){ img in
                        img
                            .resizable()
                            .scaledToFit()
                        
                    }placeholder: {
                        ProgressView()
                    }.frame(height: 233)
                        .accessibilityHidden(true)
                    Text("Your total is: \(checkoutData.costs ,format: .currency(code: Locale.current.currency?.identifier ?? "USD"))" )
                        .font(.title)
                    
                    Button("Place Order"){
                        Task{
                            await  uploadData()
                        }
                       
                    }
                    .font(.headline.weight(.heavy))
                    .padding(10)
                    .background(.regularMaterial)
                    .clipShape(.rect(cornerRadius: 15))
                    .alert("Thank you!", isPresented: $isAlert){
                        Button("OK"){ }
                    }message: {
                        Text(alertConfimationMessage)
                    }
                    
                    
                }
            }
        }
    }
}

#Preview {
    Project_10_CupcakeCorner_CheckoutView(checkoutData: Project_10_CupcakeCorner_DataModel())
        .preferredColorScheme(.dark)
}
