//
//  Project_18_LayoutAndGeometry.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 22/03/25.
//

import SwiftUI

struct Project_18_LayoutAndGeometry: View {
    
    let colors: [Color] = [.pink, .red, .yellow, .purple, .orange, .green, .blue]
    
    
    var body: some View {
    GeometryReader{ fullView in
        ScrollView{
            
            ForEach(0..<50){ i in
                GeometryReader{ proxy in
                    Text("Row : \(i)")
                        .font(.title)
                        .frame(maxWidth: .infinity)
                        .background(colors[abs(Int(proxy.frame(in: .global).minY / 100) % colors.count)])
                        .scaleEffect(max(0.5 ,min(1.2 , 1 + (proxy.frame(in: .global).midY - fullView.size.height / 2) / 1000)))
                        .opacity(
                            max(0.0, min(1.0, (proxy.frame(in: .global).minY - 50.0) / 100)) )                        .rotation3DEffect(
                            .degrees(proxy.frame(in: .global).midY - fullView.size.height / 2) / 5,
                            axis: (x: 0, y: 1, z: 0))
                    
                }.frame(height: 40)
                
            }
            
        }
    }
    .preferredColorScheme(.dark)
    }
}

#Preview {
    Project_18_LayoutAndGeometry()
}
