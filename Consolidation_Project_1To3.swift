//
//  Consolidation_Project_1To3.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 07/03/25.
//

import SwiftUI

struct Consolidation_Project_1To3: View {
    
    @State var movesArray = ["Rock", "Paper", "Scissor"]
    
    @State private var shouldWin = false
    @State private var whichMove = Int.random(in: 0...2)
    @State private var scoreCount = 0
    
   // @State private var textReturnByUserMOve = ""
    @State private var chooseToWinOrLoose = ""
    
    @State private var isAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var noOfGames = 0
    
    func userMoveResult(text: String){
        if noOfGames == 2 {
           alertMessage = "Your Total Score is \(scoreCount)\n Now Start Again"
        }
        if shouldWin {
            if movesArray[whichMove] == "Rock" {
                if text == "Paper" {
                    alertTitle = "You Win!"
                    scoreCount += 1
                }else{
                    alertTitle = "You Loose!"
                    scoreCount -= 1
                }
            }
            if movesArray[whichMove] == "Paper" {
                if text == "Scissor" {
                    alertTitle = "You Win!"
                    scoreCount += 1
                }else{
                    alertTitle = "You Loose!"
                    scoreCount -= 1
                }
            }
            if movesArray[whichMove] == "Scissor" {
                if text == "Rock" {
                    alertTitle = "You Win!"
                    scoreCount += 1
                }else{
                    alertTitle = "You Loose!"
                    scoreCount -= 1
                }
            }
            
        }else{
            if movesArray[whichMove] == "Rock" {
                if text != "Paper" {
                    alertTitle = "You Win!"
                    scoreCount += 1
                  
                }else{
                    alertTitle = "You Loose!"
                    scoreCount -= 1
                }
            }
            if movesArray[whichMove] == "Paper" {
                if text != "Scissor" {
                    alertTitle = "You Win!"
                    scoreCount += 1
                }else{
                    alertTitle = "You Loose!"
                    scoreCount -= 1
                }
            }
            if movesArray[whichMove] == "Scissor" {
                if text != "Rock" {
                    alertTitle = "You Win!"
                    scoreCount += 1
                }else{
                    alertTitle = "You Loose!"
                    scoreCount -= 1
                    
                }
            }
            
        }
        isAlert = true
       
    }
    
    
    func nextRound(){
      
            isAlert = false
            shouldWin = false
            whichMove = Int.random(in: 0...2)
            movesArray = ["Rock", "Paper", "Scissor"]
            chooseToWinOrLoose = ""
        
    }
    func reset(){
        scoreCount = 0
        isAlert = false
        shouldWin = false
        whichMove = Int.random(in: 0...2)
        movesArray = ["Rock", "Paper", "Scissor"]
        noOfGames = 0
        alertTitle = ""
        alertMessage = ""
        chooseToWinOrLoose = ""
    }
    
    var body: some View {
       
            ZStack{
               Group{
                    
                    RadialGradient(stops: [
                        .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
                        .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3)
                        
                    ], center: .topTrailing, startRadius: 150, endRadius: 700)
                    
                    .ignoresSafeArea()
             Circle()
                        .fill(Color(red: 0.6, green: 0.7, blue: 0.2))
                        .frame(width: 530, height: 550)
                        .position(x: 0, y: UIScreen.main.bounds.height - 150)
                        .shadow(color: Color(red: 0.6, green: 0.7, blue: 0.2) ,radius: 10)
                       
                    Circle()
                        .fill(Color(red: 1, green: 0.2, blue: 0.5))
                        .frame(width: 350, height: 300)
                        .shadow(color: Color(red: 0.6, green: 0.7, blue: 1), radius: 30)
                        .blur(radius: 40, opaque: false)
                   
                }
                VStack{
                    VStack{
                        
                        Text(" I Choose")
                            .font(.headline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        Text("\(movesArray[whichMove])")
                            .font(.largeTitle.weight(.heavy))
                        HStack(spacing: 100){
                            Spacer()
                            Button("Win"){
                              
                                shouldWin = true
                                chooseToWinOrLoose = "Win"
                                
                            }
                            .foregroundStyle(.white)
                            .font(.title2.weight(.bold))
                            .padding()
                            .frame(width: 100, height: 50)
                            .background(.primary)
                            .clipShape(.rect(cornerRadius: 10))
                            Button("Loose"){
                              
                                shouldWin = false
                                chooseToWinOrLoose = "Loose"
                            }
                            .foregroundStyle(.white)
                            .font(.title2.weight(.bold))
                            .padding()
                            .frame(width: 100, height: 50)
                            .background(.primary)
                            .clipShape(.rect(cornerRadius: 10))
                            
                            Spacer()
                        }
                        HStack{
                            if chooseToWinOrLoose == "" {
                                
                            }else{
                                
                                
                                Text("Play to \(chooseToWinOrLoose) ")
                                    .padding([.top, .bottom])
                                    .padding(.leading)
                                    .font(.headline.weight(.heavy))
                                    .foregroundStyle(.primary)
                            }
                        }
                        HStack(spacing: 60){
                            if chooseToWinOrLoose == ""{
                                
                            }else{
                                VStack{
                                    Button{
                                        userMoveResult(text: "Rock")
                                        
                                    }label: {
                                        
                                        Text("👊🏻")
                                            .font(.system(size: 60))
                                        
                                    }.alert(alertTitle, isPresented: $isAlert){
                                        Button{
                                            if noOfGames == 2{
                                                reset()
                                            }else{
                                               
                                                nextRound()
                                               
                                            }
                                            noOfGames += 1
                                            
                                        }label: {
                                            if noOfGames == 2{
                                                Text("reset").foregroundStyle(.red)
                                            }else{
                                                Text("OK")
                                            }
                                        }
                                    }message: {
                                        Text(alertMessage)
                                            .font(.headline.weight(.bold))

                                    }
                                    Text("Rock")
                                        .font(.headline.weight(.bold))
                                        .foregroundStyle(.secondary)
                                }
                                VStack{
                                    Button{
                                        userMoveResult(text: "Paper")
                                        
                                    }label: {
                                        
                                        Text("🖐🏻")
                                            .font(.system(size: 60))
                                    }.alert(alertTitle, isPresented: $isAlert){
                                        Button{
                                            if noOfGames == 2{
                                                reset()
                                            }else{
                                               
                                                nextRound()
                                               
                                            }
                                            noOfGames += 1
                                        }label: {
                                            if noOfGames == 2{
                                                Text("reset").foregroundStyle(.red)
                                            }else{
                                                Text("OK")
                                            }
                                        }
                                    }message: {
                                        
                                        Text(alertMessage)
                                            .font(.headline.weight(.bold))
                                    }
                                    Text("Paper")
                                        .font(.headline.weight(.bold))
                                        .foregroundStyle(.secondary)
                                }
                                VStack{
                                    Button{
                                        userMoveResult(text: "Scissor")
                                        
                                    }label: {
                                        
                                        Text("✌🏻")
                                            .font(.system(size: 60))
                                    }.alert(alertTitle, isPresented: $isAlert){
                                        Button{
                                            if noOfGames == 2{
                                                reset()
                                            }else{
                                               
                                                nextRound()
                                               
                                            }
                                            noOfGames += 1
                                        }label: {
                                            if noOfGames == 2{
                                                Text("reset").foregroundStyle(.red)
                                            }else{
                                                Text("OK")
                                            }
                                        }
                                    }message: {
                                        Text(alertMessage)
                                            .font(.headline.weight(.bold))

                                    }
                                    
                                    Text("Scissor")
                                        .font(.headline.weight(.bold))
                                        .foregroundStyle(.secondary)
                                }
                                
                            }
                        }
                        
                    }.frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        .background(.ultraThinMaterial)
                        .clipShape(.rect(cornerRadius: 20))
                    
                    
                    Text("Your Score is : \(scoreCount)")
                        .font(.title2.weight(.heavy))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.ultraThinMaterial)
                      
                }
               
                .padding()
              
            }
          
        }
}


#Preview {
    Consolidation_Project_1To3()
}
