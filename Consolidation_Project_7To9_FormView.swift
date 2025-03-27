//
//  Consolidation_Project_7To9_FormView.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 11/03/25.
//

import SwiftUI

struct Consolidation_Project_7To9_FormView: View {
    @Environment(\.dismiss) var dismiss
    @State private var enterTitle = ""
    @State private var enterDescription = ""
    @State private var isAlert = false
    
    var storageFromClassInstance = DataStorage()
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Activity Title", text: $enterTitle)
                    TextField("Enter description", text: $enterDescription )
                }
                Section{
                    Button("Save"){
                        withAnimation{
                            
                            let userData = Activity(activityTitle: enterTitle, activityDescription: enterDescription)
                            storageFromClassInstance.activities.append(userData)
                            enterTitle = ""
                            enterDescription = ""
                            dismiss()
                        }
                    }
                }.disabled(enterTitle.isEmpty || enterDescription.isEmpty )
            }
            .toolbar{
                ToolbarItem{
                    
                   
                }
            }
            .preferredColorScheme(.dark)
            
        }
    }
}

#Preview {
    Consolidation_Project_7To9_FormView()
}
