//
//  Project_11_Bookworm_RatingView.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 14/03/25.
//

import SwiftUI

struct Project_11_Bookworm_RatingView: View {
    
    @Binding  var rating: Int
       var label = ""
        var maxiumRatingNumber = 5
        var offImage: Image?
       var onImage = Image(systemName: "star.fill")
    var onColor = Color.yellow
    var offColor = Color.gray
    
    
    
    func giveImage(number: Int) -> Image{
        if number > rating{
            offImage ?? onImage
        }else{
            onImage
        }
        
       
    }
    
    var body: some View {
        HStack{
            if label.isEmpty == false{
                Text(label)
            }
            ForEach(1..<maxiumRatingNumber + 1, id: \.self){ i in
                Button{
                   rating = i
                 
                }label: {
                    giveImage(number: i)
                        .foregroundStyle(i > rating ? offColor : onColor)
                   
                }.buttonStyle(.plain)
                
            }
            
        }.accessibilityElement(children: .ignore)
            .accessibilityLabel(rating == 1 ? "1 star" : "\(rating) stars")
            .accessibilityAdjustableAction{direction in
                switch direction {
                case .increment:
                    if rating < maxiumRatingNumber { rating += 1}
                case .decrement:
                    if rating > 1 { rating -= 1}
                default:
                    break
                }
            }
    }
}

#Preview {
    Project_11_Bookworm_RatingView(rating: .constant(3))
        .preferredColorScheme(.dark)
}
