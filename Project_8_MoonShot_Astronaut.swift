//
//  Astraunaut.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 09/03/25.
//

import SwiftUI

struct Project_8_MoonShot_Astronaut: Codable, Identifiable, Hashable{
   let id: String
    let name: String
    let description: String
}
extension Bundle {
 
 func decode<T: Codable>(_ file: String) -> T {
 guard let url = self.url(forResource: file, withExtension: nil) else{
 fatalError("failed to locate \(file) in  bundle.")
 }
 guard let loadFile = try? Data(contentsOf: url) else{
 fatalError("failed to load \(file) from bundle.")
 }
 
 
 let formatter = DateFormatter()
 formatter.dateFormat = "yyyy-MM-dd"
 formatter.timeZone = TimeZone(secondsFromGMT: 0)
 
 let decoder = JSONDecoder()
 decoder.dateDecodingStrategy = .formatted(formatter)
 
 do{
 return try decoder.decode(T.self, from: loadFile)
 }catch DecodingError.keyNotFound(let key, let context) {
 fatalError("failed to decode \(file) from bundle due to missing value \(key.stringValue) - \(context.debugDescription)")
 }catch DecodingError.typeMismatch(_, let context){
 fatalError("failed to decode \(file) from bundle due to type mismatch - \(context.debugDescription)")
 }catch DecodingError.valueNotFound(let value, let context){
 fatalError("failed to load \(file) from bundle due to missing \(value) value - \(context.debugDescription)")
 }catch DecodingError.dataCorrupted(_){
 fatalError("failed to decode \(file) from bundle because it appears to be invalid JSON")
 }catch {
 fatalError(" failed to load \(file) from bundle : \(error.localizedDescription)")
 }
 
 }
 
 }
 
