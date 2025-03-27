//
//  Project_17_Flashzilla_CardView.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 21/03/25.
//

import SwiftUI

struct Project_17_Flashzilla_CardView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var accessibilityVoiceOverEnabled
    
    @State private var isShowAnser = false
    @State private var offset = CGSize.zero
    
    let dataInstance: Project_17_Flashzilla_DataModel
    let id: UUID
   
    
    
    
    var removeCard: ((_ id: UUID, _ saveForReview: Bool) -> Void)? = nil
    
    
    var body: some View {
        
        ZStack{
            
            RoundedRectangle(cornerRadius: 25)
                .fill(
                    accessibilityDifferentiateWithoutColor
                    ? .radialGradient(stops: [
                        Gradient.Stop(color: Color(red: 1.0, green: 1.0, blue: 1.0), location: 0.1),
                      Gradient.Stop(color: Color(red: 1.0, green: 1.0, blue: 1.0), location: 0.1)
                    ], center: .topLeading, startRadius: 100, endRadius: 600)
                    
                    :  .radialGradient(stops: [
                    Gradient.Stop(color: Color(red: 0.6, green: 0.6, blue: 0.9), location: 0.1),
                    Gradient.Stop(color: Color(red: 0.6, green: 0.5, blue: 0.8), location: 0.1)
                     
                ], center: .topLeading, startRadius: 100, endRadius: 600))
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke()
                        .fill(.black)
                       
                )
               .shadow(color: .black, radius: 2)
               .opacity(1 - Double(abs(offset.width / 94)))
               .background(
                accessibilityDifferentiateWithoutColor
                ? nil
                : RoundedRectangle(cornerRadius: 25)
                    .fill(offset.width > 0 ? .green : .red)
               )
                
            
            VStack{
                if accessibilityVoiceOverEnabled {
                    Text(isShowAnser ? dataInstance.answer : dataInstance.prompt)
                        .font(.largeTitle)
                        .foregroundStyle(.primary)
                }
             
                Text(dataInstance.prompt)
                    .font(.largeTitle)
                    .foregroundStyle(.black)
                
                if isShowAnser {
                    Text(dataInstance.answer)
                        .font(.title)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
            .onTapGesture {
                isShowAnser.toggle()
            }
            .animation(.bouncy, value: offset)
            
        }.frame(width: 380, height: 250)
        .rotationEffect(.degrees(offset.width / 5.0))
        .offset(x: offset.width * 1.2)
        .opacity(max(0, min(1, 1.5 - Double(abs(offset.width / 200)))))
        .accessibilityAddTraits(.isButton)
        .gesture(
            DragGesture()
                .onChanged{ gesture in
                        offset = gesture.translation
                    }
                .onEnded { _ in
                    if offset.width > 150{
                        withAnimation{
                            removeCard?(id, false)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        offset = .zero // ✅ Reset offset after reinsertion
                                    }
                        }
                    }else if offset.width < -100{
                        withAnimation {
                            removeCard?(id, true) // ✅ Incorrect swipe → Save for review
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        offset = .zero // ✅ Reset offset after reinsertion
                                    }
                                   }
                               
                        
                    }else{
                        withAnimation{
                           
                            offset = .zero
                        }
                    }
                }
                
            )
        .onAppear{ offset = .zero}
        .preferredColorScheme(.dark)
    }
}

#Preview {
    Project_17_Flashzilla_CardView(dataInstance: .example, id: UUID())
}
