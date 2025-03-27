//
//  Project_6_Animation.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 06/03/25.
//

import SwiftUI

struct ourRotateTransition: ViewModifier{
    var amount: Double
    var anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
           .clipped()
    }
}
extension AnyTransition {
    static var pivot: AnyTransition{
        .modifier(active: ourRotateTransition(amount: -90, anchor: .topLeading), identity: ourRotateTransition(amount: 0, anchor: .topLeading))
    }
}

struct Project_6_Animation: View {
   
    //@State private var dragAmount = CGSize.zero
    @State private var isShowRectangle = false
    
    var body: some View {
        
        ZStack{
            Color.yellow
                .ignoresSafeArea()
            Rectangle()
                .fill(.blue)
                .frame(width: 220, height: 200)
            
            if isShowRectangle{
                Rectangle()
                    .fill(.red)
                    .frame(width: 220, height: 200)
                    .transition(.pivot)
            }
        }.onTapGesture {
            withAnimation{
                isShowRectangle.toggle()
            }
          
        }
       
      
        
        
        /**
        HStack(spacing: 0){
            ForEach(0..<letters.count, id: (\.self)){ num in
                Text(String(letters[num]))
                    .padding(5)
                    .font(.title)
                    .background(enable ? .blue : .red)
                    .offset(dragAmount)
                    .animation(.linear.delay(Double(num) / 20), value: dragAmount)
                
            }
        }.gesture(
            DragGesture()
                .onChanged{dragAmount = $0.translation}
                .onEnded{ _ in
                    dragAmount = .zero
                    enable.toggle()
                }
        )
         **/
    }
}

#Preview {
    Project_6_Animation()
}
