//
//  Project_11_Bookworm_AddBook.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 14/03/25.
//
import SwiftData
import SwiftUI

struct Project_11_Bookworm_AddBook: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    
    @State private var enterTitle = ""
    @State private var enterAuthor = ""
    @State private var enterReview = ""
    @State private var enterRating = 3
    @State private var enterGenre = "Fantasy"
   
    
    @State private var isAlert = false
    
  let genreArray = ["Fantasy", "Horror",  "Romance", "Kids", "Poetry", "Mystry", "Thriller"]
    
    
    var body: some View {
        NavigationStack{
            
            Form{
                Section{
                    TextField("Book Title", text: $enterTitle)
                      //  .textFieldStyle(.roundedBorder)
                    TextField("Book Author Name", text: $enterAuthor)
                       // .textFieldStyle(.roundedBorder)
                }
                    Section("Select Book Genre"){
                        Picker("Genre", selection: $enterGenre){
                            ForEach(genreArray, id: \.self){ item in
                                Text(item)
                            }
                        }.pickerStyle(.menu)
                        
                    }
                
            
                Section("review the book"){
                    TextField("Enter review for book", text: $enterReview, axis: .vertical)
                        //.textFieldStyle(.roundedBorder)
                    
                    Project_11_Bookworm_RatingView(rating: $enterRating)
                    .pickerStyle(.menu)
                        
                        
                
                        
                }
                Section{
                    Button("Save"){
                        guard !enterTitle.isEmpty  || !enterAuthor.isEmpty  else{
                            isAlert = true
                            return
                        }
                        let newBookInstance = Project_11_Bookworm_DataModel(title: enterTitle, author: enterAuthor, review: enterReview, genre: enterGenre, rating: enterRating)
                       modelContext.insert(newBookInstance)
                        
                        dismiss()
                    }
                }
                
            }
            .navigationTitle("Add Book")
            .alert("Please enter \"Title\" and \"Author\"", isPresented: $isAlert){ }
           
        }
    }
}

#Preview {
    Project_11_Bookworm_AddBook()
        .preferredColorScheme(.dark)
}
