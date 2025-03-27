//
//  Project_19_SnowSeeker_WelcomeView.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 23/03/25.
//

import SwiftUI

struct Project_19_SnowSeeker_WelcomeView: View {
    var body: some View {
        VStack {
                   Text("Welcome to SnowSeeker!")
                       .font(.largeTitle)

                   Text("Please select a resort from the left-hand menu; swipe from the left edge to show it.")
                       .foregroundStyle(.secondary)
               }
    }
}

#Preview {
    Project_19_SnowSeeker_WelcomeView()
}
