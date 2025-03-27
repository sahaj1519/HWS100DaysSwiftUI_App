//
//  Project_11_Bookworm_DataModel.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 14/03/25.
//

import SwiftData
import SwiftUI

@Model
class Project_11_Bookworm_DataModel {
   
    var title: String
    var author: String
    var review: String
    var genre: String
    var rating: Int
    var date: Date?
    
    init(title: String, author: String, review: String, genre: String, rating: Int, date: Date? = nil) {
        self.title = title
        self.author = author
        self.review = review
        self.genre = genre
        self.rating = rating
        self.date = date
        
       
    }
}
