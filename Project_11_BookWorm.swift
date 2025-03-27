//
//  Project_11_BookWorm.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 13/03/25.
//

import SwiftData
import SwiftUI

struct Project_11_BookWorm: View {
  
    @Environment(\.modelContext) var modelContext
    @Query var dataModelArray: [Project_11_Bookworm_DataModel]
  
    
    @State private var isAddBook = false
    
    func deleteBooks(_ indexes: IndexSet ){
        for i in indexes{
            let book = dataModelArray[i]
            modelContext.delete(book)
        }
    }
  
    func updateMissingDates() {
        for book in dataModelArray where book.date == nil {
                book.date = Date()  // Assign current date to missing values
            }
            try? modelContext.save()  // Save updated books
        }
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(dataModelArray){ item in
                    NavigationLink(value: item){
                        HStack(spacing: 20){
                             
                            VStack(alignment: .leading){
                                Text(item.title)
                                    .foregroundStyle(item.rating == 1 ? .red : .white)
                                    .font(.title.bold())
                                Text("by \(item.author)")
                                    .foregroundStyle(.secondary)
                            }
                            
                            Project_11_Bookworm_EmojiRatingView(rating: item.rating)
                                .font(.system(size: 10))
                                
                        }
                    }
                }.onDelete(perform: deleteBooks)
            }
    
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                      EditButton()
                }
                ToolbarItem( placement: .topBarTrailing){
                    Button("Add Book", systemImage: "plus" ){
                        isAddBook.toggle()
                    }
                }
            }
            .navigationTitle("Bookworm")
            .preferredColorScheme(.dark)
            .navigationDestination(for: Project_11_Bookworm_DataModel.self){ book in
                Project_11_Bookworm_BookDetailView(data: book)
            }
            .sheet(isPresented: $isAddBook){
                Project_11_Bookworm_AddBook()
            }
            .onAppear{
                updateMissingDates()
            }
        }
    }
}

#Preview {
       Project_11_BookWorm()
           
}

