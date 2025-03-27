//
//  Project_11_Bookworm_EmojiRatingView.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 14/03/25.
//

import SwiftUI



struct Project_11_Bookworm_EmojiRatingView: View {
    let rating: Int
    
    var body: some View {
        switch rating {
        case 1:
            Text("⭐️")
                
        case 2:
            Text("⭐️⭐️")
              
          
        case 3:
            Text("⭐️⭐️⭐️")
                
        case 4:
            Text("⭐️⭐️⭐️⭐️")
                
        default:
            Text("⭐️⭐️⭐️⭐️⭐️")
               
        }
    }
}

#Preview {
    Project_11_Bookworm_EmojiRatingView(rating: 3)
}
