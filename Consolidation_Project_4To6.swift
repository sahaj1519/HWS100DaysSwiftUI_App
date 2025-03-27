//
//  Consolidation_Project_4To6.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 07/03/25.
//

import SwiftUI
struct Consolidation_Project_4To6: View {
    
    @State private var selectTable = 0
    @State private var noOfQuestions = 10
    @State private var difficultylevelArray = ["Basic", "Intermediate", "Advance"]
    @State private var defaultDifficultyLevel = "Basic"
    @State private var isGameStart = false  // changing layout of ui
    @State private var tableMultiplier = Int.random(in: 1...10)
    @State private var userAnswer = 0   //textField from user entering

    @State private var wrongAnswer = 0     // counting every wrong answer from user
    @State private var isGameEnded = false  // end the game and show user how many wrong answers
    @State private var isUserAnswerWrong = false    //condition showing and hiding text box everytime for answers result
    @State private var alertingUserForRightAndWrongAnswer = ""         //what to show in textbox for result
    @State private var gameCount = 0  // counting round for no of question selected to end/ reset the game
    @State private var isresultUI = false  // result ui
    @FocusState  private var isFocusTextField: Bool
    
   
    func onUSerSubmit(){
      
        if (selectTable + 2) * tableMultiplier == userAnswer {
            alertingUserForRightAndWrongAnswer = "You are Right"
                        
        }else{
       
            alertingUserForRightAndWrongAnswer = "You are wrong"
            wrongAnswer += 1

        }
        isUserAnswerWrong = true
        
    
    }
    func gameStarted(){
        
        if defaultDifficultyLevel == "Basic"{
            tableMultiplier = Int.random(in: 1...20)
        }
        if defaultDifficultyLevel == "Intermediate"{
            tableMultiplier = Int.random(in: 21...50)
        }
        if defaultDifficultyLevel == "Advance"{
            tableMultiplier = Int.random(in: 51...150)
        }
    
    }
    func nextQuestion(){
        isUserAnswerWrong = false
        userAnswer = 0
        if defaultDifficultyLevel == "Basic"{
            tableMultiplier = Int.random(in: 1...20)
        }
        if defaultDifficultyLevel == "Intermediate"{
            tableMultiplier = Int.random(in: 21...50)
        }
        if defaultDifficultyLevel == "Advance"{
            tableMultiplier = Int.random(in: 51...150)
        }
        alertingUserForRightAndWrongAnswer = ""
        
        
    }
    func reset(){
        gameCount = 0
        noOfQuestions = 0
        wrongAnswer = 0
        isGameStart = false
        isresultUI = false
        alertingUserForRightAndWrongAnswer = ""
        difficultylevelArray = ["Basic", "Intermediate", "Advance"]
        isUserAnswerWrong = false
        selectTable = 4
        noOfQuestions = 10
        defaultDifficultyLevel = "Basic"
        tableMultiplier = Int.random(in: 1...10)
    }
    
    
    var body: some View {
        
        
        NavigationStack{
            if !isGameStart {
                
                List{
                    
                    Section("which table you want to learn today?"){
                        Picker("Select multiplication table", selection: $selectTable){
                            ForEach(2..<13){
                                Text("\($0)")
                            }
                        }.pickerStyle(.navigationLink)
                    }
                    Section("how many question you want to be asked?"){
                        Stepper("\(noOfQuestions)", value: $noOfQuestions, in: 5...50, step: 5)
                    }
                    Section("choose difficulty level for questions"){
                        Picker("Difficulty level", selection: $defaultDifficultyLevel){
                            ForEach(difficultylevelArray, id:(\.self)){
                                Text("\($0)")
                            }
                            
                        }
                    }
                    HStack{
                        
                        Spacer()
                        Button("Start"){
                            isGameStart = true
                            gameStarted()
                        }
                        .font(.title3.weight(.bold))
                        Spacer()
                    }
                    
                    
                    
                }
                .navigationTitle("Learn Tables")
                .navigationBarTitleDisplayMode(.large)
            }else{
        
                ZStack{
                    Color.yellow
                        .ignoresSafeArea()
                    VStack{
                        Spacer()
                        
                        VStack(spacing: 15){
                            Text("Your Question is ")
                                .font(.headline.weight(.heavy))

                                Text("\(selectTable + 2) x \(tableMultiplier)")
                                .font(.system(size: 60))
                                .padding(50)
                                .background(.regularMaterial)
                                .clipShape(.rect(cornerRadius: 10))
                                
                            
                          
                          Spacer()
                            
                            Text("Enter Your Answer")
                                .font(.headline.weight(.heavy))
                                .padding(.trailing, 160)
                            TextField("Enter your answer", value: $userAnswer, format: .number)
                                   .keyboardType(.numberPad)
                                    .font(.largeTitle.bold())
                                    .foregroundStyle(.black)
                                    .padding()
                                    .background(.regularMaterial)
                                    .clipShape(.rect(cornerRadius: 10))
                                    
                                    .padding(.horizontal, 10)
                                    .focused($isFocusTextField)
                                    
                                    .onSubmit {
                                       
                                        onUSerSubmit()
                                        
                                        
                                    }
                                    
                            if isUserAnswerWrong{
                                Text(alertingUserForRightAndWrongAnswer)
                                    .font(.largeTitle.weight(.heavy))
                                    .padding()
                                   .background(.ultraThinMaterial)
                                    .clipShape(.rect(cornerRadius: 10))
                                    .padding(.vertical, 30)
                                Button{
                                  
                                    if gameCount == noOfQuestions - 1  {
                                       // isGameStart = false
                                          isresultUI = true
                                       
                                    }else{
                                        nextQuestion()
                                       
                                    }
                                   
                                    gameCount += 1
                                   
                                    
                                    
                                }label: {
                                    if gameCount != noOfQuestions - 1 {
                                        Text("Next")
                                    }else{
                                        Text("See result")
                                    }
                                    
                                }.font(.title3.weight(.bold))
                                    .foregroundStyle(.white)
                                    .padding()
                                    .background(.secondary)
                                    .clipShape(.rect(cornerRadius: 10))
                                    .padding(.vertical, 30)
                            }else{
                                Text("")
                                    .font(.largeTitle.weight(.heavy))
                                    .padding()
                                   //.background(.ultraThinMaterial)
                                    .clipShape(.rect(cornerRadius: 10))
                                    .padding(.vertical, 30)
                            }
                               
                           
                                   
                           Spacer()
                          
                                
                           
                            
                        }.padding(.vertical, 20)
                        
                    }.padding()
                    
                      if isresultUI {
                         
                          ZStack{
                              LinearGradient(colors: [.yellow, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
                                  .ignoresSafeArea()
                              VStack{
                                  VStack{
                                      Text("Your Result")
                                          .font(.largeTitle.weight(.heavy))
                                          .foregroundStyle(.primary)
                                          .padding(.vertical, 50)
                                      Text("you did \(wrongAnswer) wrong answers ")
                                          .font(.title.bold())
                                          .foregroundStyle(.primary)
                                          .padding()
                                      Button("Play again"){
                                          reset()
                                      }.font(.title3.weight(.bold))
                                          .padding()
                                          .background(.secondary)
                                          .clipShape(.rect(cornerRadius: 10))
                                          .padding(.vertical, 30)
                                          
                                  }.frame(maxWidth: .infinity )
                                  .background(.ultraThinMaterial)
                                      .clipShape(.rect(cornerRadius: 15))
                                      
                                      
                                      
                              }.padding()
                          }
                      }
                    
                }
                
            }
        
        }.toolbar{
            if isFocusTextField {
                Button("Done"){
                    isFocusTextField = false
                }
            }
        }
    }
}

#Preview {
    Consolidation_Project_4To6()
}
