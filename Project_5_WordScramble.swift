//
//  Project_5_WordScramble.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 05/03/25.
//
import SwiftUI

struct Project_5_WordScramble: View{
    
    @State private var wordToEnter = ""
    @State private var navigationTitle = ""
    @State private var storeWordFromUserArray = [String]()
    @State private var scoreCount = 0
    
    @State private var isAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
  
    func startFileFetching(){
        if let urlOfStartFileTxt = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let loadStartFileTxt = try? String(contentsOf: urlOfStartFileTxt, encoding: .utf8){
               let allWordsArrayFromStartFile =  loadStartFileTxt.components(separatedBy: "\n")
  
                navigationTitle = allWordsArrayFromStartFile.randomElement() ?? "silkworm"
                return
            }
          
        }
        fatalError("Failed to load start.txt file from bundle")
    }
    func restartGame(){
        wordToEnter = ""
        storeWordFromUserArray = [String]()
        isAlert = false
        startFileFetching()
        
    }
    
    func SubmitWordFromUser(){
        let wordFromUser = wordToEnter.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard wordFromUser.count > 2 else{
            alertShowFunction(alert: "word not accepted", message: "can't enter word shorter than three lettter ")
            return
        }
       
        guard isDuplicate(word: wordFromUser) else{
            alertShowFunction(alert: "Word used already", message: "Be more original")
            return
        }
        guard isPossibleToMakeAskedWord(word: wordFromUser) else{
            alertShowFunction(alert: "Word not possible", message: "You can't spell that word from '\(navigationTitle)'!")
            return
        }
        guard misspelledWordChecking(word: wordFromUser) else{
            alertShowFunction(alert:"Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        
        withAnimation{
            storeWordFromUserArray.insert(wordFromUser, at: 0)
            scoreCount += 1
            wordToEnter = ""
        }
       
    }
    func isDuplicate(word: String) -> Bool{
        !storeWordFromUserArray.contains(word)
    }
    func isPossibleToMakeAskedWord(word: String) -> Bool{
   var tempword = word
        for letter in word{
            if let pos = tempword.firstIndex(of: letter){
                tempword.remove(at: pos)
            }else{
                return false
            }
         }
        return true
      
    }
    
    func misspelledWordChecking(word: String) -> Bool{
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf8.count)
        let misspelledWordFound = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledWordFound.location == NSNotFound
    }
    
    func alertShowFunction(alert: String, message: String){
        alertTitle = alert
        alertMessage = message
        isAlert = true
       
    }
    
    var body: some View{
        
        NavigationStack{
            
           // VStack{
                        List{
                            Section("Make your word from"){
                                Text(navigationTitle)
                                    .font(.largeTitle.weight(.bold))
                            }
                           
                          
                            Section("Enter the word"){
                                TextField("Enter you word", text: $wordToEnter)
                                    .textInputAutocapitalization(.never)
                                    .onSubmit { SubmitWordFromUser() }
                                    .autocorrectionDisabled(true)
                            }
                            Section("previously used words"){
                                ForEach(storeWordFromUserArray, id: (\.self)){ i in
                                    HStack{
                                        Image(systemName: "\(i.count).circle")
                                          Text(i)
                                    }.accessibilityElement(children: .ignore)
                                        .accessibilityLabel("\(i), \(i.count) letters")
                                }
                            }
                            
                        }
          //  }
            HStack{
                Text("Your score is: \(scoreCount)")
                        .font(.title3.weight(.heavy))
                Spacer()
            }.padding()
            
            
           //.navigationTitle("Make the word from ")
         //  .navigationBarTitleDisplayMode(.inline)
           .foregroundColor(.secondary)
            .onAppear(perform: startFileFetching)
            .toolbar{
                 Button{
                        restartGame()
                        
                    }label: {
                        Text("Reset")
                            .padding(5.0)
                            .foregroundColor(.white)
                            .background(.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                           
                    }
                  
            }
            
            .alert(alertTitle, isPresented: $isAlert){
                Button("OK"){ }
            }message: {
                Text(alertMessage)
            }
            
        }
    }
    
}
    
#Preview {
    Project_5_WordScramble()
}
