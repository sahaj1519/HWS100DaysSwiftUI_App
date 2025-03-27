//
//  Consolidation_Project_16To18.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 22/03/25.
//
import SwiftData
import SwiftUI
import Combine

struct Consolidation_Project_16To18: View {
    @Environment(\.modelContext) var modelContext
    
    
    @State private var diceSides = 6
    let diceOptions = [4, 6, 8, 10, 12, 20]
    
    @State private var rolledNumber = 0
    @State private var rolledNumberDuplicate = 0
    @State private var rollTime = 0.0
    @State private var noOfRolls = 0
    @State private var isShowRolls = false
   
    
    @State private var timer: AnyCancellable?
    
    
  
    func savePreviousRolledNumber(){
        let newData = Consolidation_Project_16To18_DataModel(sideInDice: diceSides, rolledNumber: rolledNumberDuplicate, date: .now)
        
        modelContext.insert(newData)
        do{
            try modelContext.save()
            print("Dice roll saved: \(rolledNumberDuplicate) on \(diceSides)-sided dice")
        }catch{
            print(" failed to save previous number in database \(error.localizedDescription)")
        }
      
    }
    
    
    
    var body: some View {
        NavigationStack{
            
            VStack(spacing: 30){
                Text("\(rolledNumber)")
                    .font(.system(size: 100))
                    .fontWeight(.black)
                    .foregroundStyle(.white.opacity(0.8))
                    .padding(.horizontal, 70)
                    .padding(.vertical, 50)
                    .background(.regularMaterial)
                    .clipShape(.rect(cornerRadius: 10))
                
               
                    HStack{
                        Text("Dice Rolled \(noOfRolls) Times")
                            .font(.subheadline)
                            .fontWeight(.black)
                            .foregroundStyle(.secondary)
                    }
                
                HStack{
                   Text("Select Dice")
                        .fontWeight(.bold)
                        .foregroundStyle(.white.opacity(0.8))
                        .padding(.horizontal, 15)
                    Spacer()
                        Picker("Select No Of Faces", selection: $diceSides){
                            ForEach(diceOptions, id: \.self){ side in
                                Text("\(side)-sided dice")
                            }
                        }.pickerStyle(.menu)
                        .padding(.horizontal, 10)
                   
                }
                Button("Roll", systemImage: "dice"){
                    rollTime = 0.0
                    
                    timer?.cancel()
                    
                    timer = Timer.publish(every: 0.15, on: .main, in: .common).autoconnect()
                        .sink{ _ in
                            
                            if rollTime < 3.5{
                               
                                withAnimation{
                                    rolledNumber = Int.random(in: 1...diceSides)
                                }
                               
                                rollTime += 0.15
                                
                                let rollingHaptic = UIImpactFeedbackGenerator(style: .light)
                                rollingHaptic.prepare()
                                rollingHaptic.impactOccurred()
                                
                                
                            }else{
                               
                                timer?.cancel()
                                rolledNumber = Int.random(in: 1...diceSides)
                                rolledNumberDuplicate = rolledNumber
                                
                                savePreviousRolledNumber()
                              
                                
                            }
                            
                            
                        }
                    
                }
                .font(.largeTitle.bold())
                .foregroundStyle(.black)
                .padding()
                .background(.yellow.opacity(0.7))
                .clipShape(.rect(cornerRadius: 15))
                
                
            }.padding(2)
            
            
          .preferredColorScheme(.dark)
          .navigationTitle("Dice Roll")
          .toolbar{
              ToolbarItem{
                 
                      NavigationLink{
                          Consolidation_Project_16To18_DetailView()
                      }label:{
                         Text("Previously Rolled")
                              .foregroundStyle(.yellow)
                      }
                 
              }
          }
          
        }
        
    }
}

#Preview {
    Consolidation_Project_16To18()
        
}
