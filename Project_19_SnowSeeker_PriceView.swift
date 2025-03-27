//
//  Project_19_SnowSeeker_PriceView.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 23/03/25.
//

import SwiftUI

struct Project_19_SnowSeeker_PriceView: View {
    var data: Project_19_SnowSeeker_DataModel
    
    var size: String {
        switch data.size {
        case 1: "Small"
        case 2: "Medium"
        default : "Large"
        }
    }
    
    var price: String{
        String(repeating: "$", count: data.price)
    }
    
    var body: some View {
        Group{
            VStack{
                
                Text("Price")
                    .font(.caption.bold())
                Text(price)
                    .font(.title3)
            }
                VStack{
                    Text("Size")
                        .font(.caption.bold())
                    Text(size)
                        .font(.title3)
                   
               }
        }.frame(maxWidth: .infinity)
    }
}

#Preview {
    Project_19_SnowSeeker_PriceView(data: .example)
}
