//
//  Project_14_BucketList_WikipediaResult.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 17/03/25.
//

import SwiftUI

struct Project_14_BucketList_WikipediaResult: Codable{
    let query: WikiQuery
}

struct WikiQuery: Codable{
    let pages: [Int: WikiPage]
}

struct WikiPage: Codable,Comparable{
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
    
    static func <(lhs: WikiPage, rhs: WikiPage) -> Bool{
        lhs.title < rhs.title
    }
    
    var description: String{
        terms?["description"]?.first ?? "No further information"
    }
}
