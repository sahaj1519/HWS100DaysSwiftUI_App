//
//  Project_9_Navigation.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 10/03/25.
//

import SwiftUI

@Observable
class StorePath {
    
   
   var datafromClass:[Int]{
        didSet{
            save()
        }
    }
    private let saveData = URL.documentsDirectory.appending(path: "savedData")
    init() {
        if let dataFromFile = try? Data(contentsOf: saveData){
            if let decode = try? JSONDecoder().decode([Int].self, from: dataFromFile){
                datafromClass = decode
                return
            }
        }
        datafromClass = []
    }
    func save() {
        do{
            let dataofFile = try? JSONEncoder().encode(datafromClass)
            try dataofFile?.write(to: saveData)
        }catch{
            print("Failed to save navigation data")
        }
    }
}

struct DetailView: View{
   
   
    var number: Int
    @Binding var insideData: [Int]
    var body: some View {
        NavigationLink("generate a random number", value: Int.random(in: 0...10))
            .navigationTitle("number \(number)")
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar{
                Button("Home"){
                    insideData.removeAll()
                }
            }
    }
    
}

struct Project_9_Navigation:View{
  
    @State private var data = StorePath()
    @State private var userInput = 0
    
   
       
    var body: some View {
        NavigationStack(path: $data.datafromClass ){
           
            VStack{
                TextField("Enter number", value: $userInput, format: .number)
                    .font(.largeTitle)
                    .background(.gray.opacity(0.3))
                    .onSubmit {
                        data.datafromClass.append(userInput)
                        userInput = 0
                    }
                
               
            }
            .navigationDestination(for: Int.self){ i in
                DetailView(number: i, insideData: $data.datafromClass )
               
            }
            
            
            }
          
        
    }
}


#Preview {
    Project_9_Navigation()
        .preferredColorScheme(.dark)
}
