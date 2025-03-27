//
//  Project_11_Bookworm_BookDetailView.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 14/03/25.
//
import SwiftData
import SwiftUI

struct Project_11_Bookworm_BookDetailView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var isAlert = false
    
    let data: Project_11_Bookworm_DataModel
    
    func deletebook(){
        modelContext.delete(data)
        dismiss()
    }
    
    var body: some View {
        
        ScrollView{
            ZStack(alignment: .bottomTrailing){
                Image(data.genre)
                    .resizable()
                    .scaledToFit()
                
                Text(data.genre.uppercased())
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundStyle(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)
                    .offset(x: -5, y: -5)
                
            }
            Text("Written By")
                .font(.subheadline.italic().weight(.semibold))
                .foregroundStyle(.secondary)
                .padding(.top)
            Text(data.author)
                .font(.largeTitle)
                .foregroundStyle(.secondary)
                .shadow(color: .blue ,radius: 10)
                .padding(.bottom, 5)
            Text("Added On : \(data.date?.formatted(date: .long, time: .shortened ) ?? "No Date")")
                .font(.subheadline.italic().weight(.semibold))
                    .foregroundStyle(.secondary)
                    .padding(.bottom)
               
            
            Text(data.review)
                .padding()
            
            Project_11_Bookworm_RatingView(rating: .constant(data.rating))
                .font(.title2)
           
        }.padding(.top)
        .navigationTitle(data.title)
        .navigationBarTitleDisplayMode(.inline)
        .preferredColorScheme(.dark)
        .scrollBounceBehavior(.basedOnSize)
        .toolbar{
            Button("Delete this book", systemImage: "trash"){
                isAlert = true
            }
            
        }
        .alert("Delete this book", isPresented: $isAlert){
            Button("Delete", role: .destructive, action: deletebook)
            Button("Cancel", role: .cancel, action: { })
            
        }message: {
            Text("Are you sure?")
        }
    }
}


#Preview {
     
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
    if let container = try? ModelContainer(for: Project_11_Bookworm_DataModel.self, configurations: config){
        let example = Project_11_Bookworm_DataModel(title: "Test Book", author: "Test Author", review: "This was a great book; I really enjoyed it.", genre: "Fantasy", rating: 4)
        
        Project_11_Bookworm_BookDetailView(data: example)
            .modelContainer(container)
       
    }else{
        Text("Failed to create preview")
    }
   
}
