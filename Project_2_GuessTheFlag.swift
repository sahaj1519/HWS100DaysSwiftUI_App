//
//  Project-2-GuessTheFlag.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 03/03/25.
//

import SwiftUI

struct FlagImage: View{
    var text: String
    @Binding var  rotateFlag: Bool
    @Binding var  opacityFlag: Double
    var body: some View{
        Image(text)
            .clipShape(.capsule)
            .shadow(radius: 5)
            .rotation3DEffect(.degrees(rotateFlag ? 360 : 0), axis: (x: 0, y: 1, z: 0))
            .animation(.easeInOut(duration: 0.5), value: rotateFlag)
            .opacity(opacityFlag)
             
       
    }
}

struct Project_2_GuessTheFlag: View {
    @State  var countriesNameArray = ["Estonia", "Germany", "France", "Italy", "Ireland", "Monaco", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var indexOfCountryNameOnScreen = Int.random(in: 0...2)
    
    @State private var isAlertOnButtonPress = false   // flags are buttons
    @State private var alertTitleOfAnswerWrongOrCorrect = ""
    @State private var totalScore = 0
    @State private var gameCount  = 0
    @State private var flagOfCountryAlertMessage = 0
    
    @State private var rotateFlags  = [false, false, false]
    @State private var opacityArray  = [1.0, 1.0, 1.0]
    // lables dictionary for accessibility with flag name as a key
    let labels = [
        "Estonia": "Flag with three horizontal stripes. Top stripe blue, middle stripe black, bottom stripe white.",
        "France": "Flag with three vertical stripes. Left stripe blue, middle stripe white, right stripe red.",
        "Germany": "Flag with three horizontal stripes. Top stripe black, middle stripe red, bottom stripe gold.",
        "Ireland": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe orange.",
        "Italy": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe red.",
        "Nigeria": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe green.",
        "Poland": "Flag with two horizontal stripes. Top stripe white, bottom stripe red.",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red.",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background.",
        "Ukraine": "Flag with two horizontal stripes. Top stripe blue, bottom stripe yellow.",
        "US": "Flag with many red and white stripes, with white stars on a blue background in the top-left corner."
    ]

   
    
    func actionOnButtonTap(_ number: Int){
        // action on pressing flags
       
        if number == indexOfCountryNameOnScreen{
            alertTitleOfAnswerWrongOrCorrect = "You are correct"
            totalScore += 1
        }else{
            alertTitleOfAnswerWrongOrCorrect = "You are wrong"
            totalScore -= 1
        }
        isAlertOnButtonPress = true
    }
    func startingGameAgain(){
        // action after pressing continue in alert
        rotateFlags = [false, false, false]
        countriesNameArray.shuffle()
        indexOfCountryNameOnScreen = Int.random(in: 0...2)
       // totalScore = totalScore
        opacityArray  = [1.0, 1.0, 1.0]
     
    }
    
    
    func resetGame(){
        // ressting game after 6 questions i.e. after 6 times starting game again function called
       
        countriesNameArray.shuffle()
        indexOfCountryNameOnScreen = Int.random(in: 0...2)
        totalScore = 0
        gameCount = 0
        isAlertOnButtonPress = false
        opacityArray  = [1.0, 1.0, 1.0]
    }
    
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color:  Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 150, endRadius: 700)
            .ignoresSafeArea()
            
            VStack(spacing: 15){
                Spacer()
                Text("Guess The Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                VStack{
                    
                    Text("Tap the flag of")
                        .font(.subheadline.weight(.heavy))
                        .foregroundColor(.secondary)
                    
                    Text("\(countriesNameArray[indexOfCountryNameOnScreen])") //shows country name on screen
                        .font(.largeTitle.weight(.semibold))
                   
                        ForEach(0..<3){name in
                            Button{
                              
                                    flagOfCountryAlertMessage = name
                                rotateFlags[name].toggle()
                            opacityArray = [0.25, 0.25, 0.25]
                                opacityArray[name] = 1
                                    actionOnButtonTap(name)
                             
                            }label:{
                                FlagImage(text: "\(countriesNameArray[name])", rotateFlag: $rotateFlags[name], opacityFlag: $opacityArray[name]) // custom structure for flag image
                                   
 // earlier method                 Image("\(countriesNameArray[name])")     // shows countries flag images on screen
                                   
                            }.accessibilityLabel(labels[countriesNameArray[name], default: "Unknown flag"])
                            .alert(alertTitleOfAnswerWrongOrCorrect, isPresented: $isAlertOnButtonPress){
                                Button{

                                    if gameCount == 7{
                                        resetGame()
                                    }else{
                                       
                                        startingGameAgain()
                                       
                                    }
                                    gameCount += 1
                                  
                                    
                                }label:{
                                    if gameCount == 7 {
                                        
                                        Text("Reset the game")
                            
                                            
                                    }else{
                                        Text("continue")
                                    }
                                }
                               
                                   
                            }message:{
                              
                              Text(" That's the flag of \(countriesNameArray[flagOfCountryAlertMessage]) \n " + "Your total score is \(totalScore)")
                                    .font(.title3.weight(.bold))
                                  //  Text("Your total score is \(totalScore)")
                               
                                
                            }
                           
                            
                           
                        }
                
                   
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
               
                Spacer()
               
                
                Text("Your Score is \(totalScore)")
                    .foregroundColor(.white)
                    .font(.title2)
                
                Spacer()
                Spacer()
                Spacer()
                
                
            }
            .padding()
        }
    }
}

#Preview {
    Project_2_GuessTheFlag()
}
