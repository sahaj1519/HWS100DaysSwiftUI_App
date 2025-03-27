//
//  Project_19_SnowSeeker_Snow_Information.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 23/03/25.
//

import SwiftUI

struct Project_19_SnowSeeker_Snow_Information: View {
    var data: Project_19_SnowSeeker_DataModel
    
    var body: some View {
        
        Group{
            VStack{
                Text("Elevation")
                    .font(.caption.bold())
                
                Text("\(data.elevation)m")
                    .font(.title3)
            }
                VStack{
                    Text("Depth")
                        .font(.caption.bold())
                    Text("\(data.snowDepth)cm")
                        .font(.title3)
                }
        }.frame(maxWidth: .infinity)
    }
}

#Preview {
    Project_19_SnowSeeker_Snow_Information(data: .example)
}
