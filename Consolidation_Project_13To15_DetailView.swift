//
//  Consolidation_Project_13To15_DetailView.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 18/03/25.
//

import SwiftUI

struct Consolidation_Project_13To15_DetailView: View {
    @Bindable var data: Consolidation_Project_13To15_DataModel
    var imageData: Data?
    var imageId: UUID
    var body: some View {
        ZStack{
            if let imageData, let uiImage = UIImage(data: imageData){
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .blur(radius: 50)
            }
               
               
            ScrollView{
   
                    if let imageData, let uiImage = UIImage(data: imageData){
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 400 ,height: 400)
                        
                    }
              
               
                    NavigationLink{
                        Consolidation_Project_13To15_DetailView_Map(data: data, imageId: imageId)
                    }label: {
                        Text("Saved At location")
                            .font(.headline.bold())
                            .foregroundStyle(.white)
                            .padding()
                            .background(.ultraThinMaterial)
                            .clipShape(.rect(cornerRadius: 9))
                            .shadow(color: .gray ,radius: 20)
                    }
                    
               
               
                
                
            }
            .scrollBounceBehavior(.basedOnSize)
            .background(.ultraThinMaterial)
            
            
               
        }
    }
}

#Preview {
    Consolidation_Project_13To15_DetailView(data: Consolidation_Project_13To15_DataModel(),imageData: Data(), imageId: UUID())
        .preferredColorScheme(.dark)
}
