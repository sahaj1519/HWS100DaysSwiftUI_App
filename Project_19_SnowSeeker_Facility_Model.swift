//
//  Project_19_SnowSeeker_Facility_Model.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 23/03/25.
//

import SwiftUI

struct Project_19_SnowSeeker_Facility_Model: Identifiable{
    let id = UUID()
    var name: String
    
    private let icons = [
        "Accommodation": "house",
        "Beginners": "1.circle",
        "Cross-country": "map",
        "Eco-friendly": "leaf.arrow.circlepath",
        "Family": "person.3"
    ]
    
    private let alertMessages = [
        "Accommodation": "This resort has popular on-site accommodation.",
            "Beginners": "This resort has lots of ski schools.",
            "Cross-country": "This resort has many cross-country ski routes.",
            "Eco-friendly": "This resort has won an award for environmental friendliness.",
            "Family": "This resort is popular with families."
    ]
    
    var alertMessage: String {
        if let message = alertMessages[name]{
            message
        }else{
            fatalError("Unknown facility type: \(name)")
        }
    }
    
    
    var icon: some View{
        if let iconName = icons[name]{
            Image(systemName: iconName)
                .accessibilityLabel(name)
                .foregroundStyle(.secondary)
        }else{
            fatalError("Unknown faility type: \(name)")
        }
    }
    
    
    
}
