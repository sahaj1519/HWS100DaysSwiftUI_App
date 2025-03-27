//
//  Project_17_Flashzilla.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 20/03/25.
//

import SwiftUI

extension View{
    func stacked(at position: Int, for count: Int) -> some View{
        let offset = Double(count - position)
        return self.offset(y: offset * 10)
    }
}

struct Project_17_Flashzilla: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
    @Environment(\.scenePhase) var  scenePhase
    @Environment(\.accessibilityVoiceOverEnabled) var accessibilityVoiceOverEnabled
    
    
    @State private var cardArray = [Project_17_Flashzilla_DataModel]()
    
    @State private var timeRemaining = 100
    @State private var isTimerActive = true
    @State private var isAddCard = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    func remove(id: UUID, saveForReview: Bool) {
        if let index = cardArray.firstIndex(where: { $0.id == id }) {
            let card = cardArray.remove(at: index) // Remove correctly
            
            if saveForReview {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    if !cardArray.contains(where: { $0.id == card.id }) {
                        cardArray.insert(card, at: 0) // ✅ Reinsert correctly at end, not at the start
                    }
                }
            }
        }
        
        if cardArray.isEmpty {
            isTimerActive = false
        }
    }

   
    func resetCard(){
        
        isTimerActive = true
        timeRemaining = 100
        loadData()
        
    }
    func loadData(){
      
        do{
            let data = try Data(contentsOf: URL.documentsDirectory.appending(path: "FlashZilla"))
            let decoder = try JSONDecoder().decode([Project_17_Flashzilla_DataModel].self, from: data)
                    cardArray = decoder
                
        }catch{
            print("failed to decode data \(error.localizedDescription)")
        }
    }
    func saveData(){
        do{
            let encoded = try JSONEncoder().encode(cardArray)
            try encoded.write(to: URL.documentsDirectory.appending(path: "FlashZilla"))
            
        }catch{
            print("failed to save data \(error.localizedDescription)")
        }
            
    }
    
    
    // body
    var body: some View {
        ZStack{
            
        
            VStack{
               
                Text("Time : \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundStyle(.primary)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.regularMaterial)
                    .clipShape(.capsule)
                   
                   
             
                
                ZStack{
                    ForEach(Array(cardArray.enumerated()), id: \.element.id) { index, card in
                        Project_17_Flashzilla_CardView(dataInstance: card, id: card.id) { id, saveForReview in
                            withAnimation {
                                remove(id: id, saveForReview: saveForReview)
                            }
                        }
                        .stacked(at: index, for: cardArray.count)
                        .allowsHitTesting(index == cardArray.count - 1) // ✅ Only allow the topmost card to be swiped
                    .accessibilityHidden(index != cardArray.count - 1) // ✅ Only expose topmost card to accessibility
                    }
                    
                    if cardArray.isEmpty{
                        Button("Try Again"){
                            resetCard()
                        }
                        .font(.title)
                        .foregroundStyle(.white)
                        .padding(10)
                        .background(.regularMaterial)
                        .clipShape(.rect(cornerRadius: 10))
                        
                    }
                    
                    
                }.allowsHitTesting(timeRemaining > 0)
               
            }
            
            VStack{
                HStack{
                    Spacer()
                    Button{
                        isAddCard = true
                    }label:{
                        Image(systemName: "plus.circle")
                            .font(.title)
                    }
                    .padding(.horizontal, 20)
                }
                Spacer()
            }
            
            if accessibilityDifferentiateWithoutColor || accessibilityVoiceOverEnabled {
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    
                    Button {
                        if let lastCard = cardArray.last {
                            remove(id: lastCard.id, saveForReview: true)
                        }
                    }label:{
                    Image(systemName: "xmark.circle")
                        .padding()
                        .background(.black.opacity(0.7))
                        .clipShape(.circle)
                        .accessibilityLabel("Wrong")
                        .accessibilityHint("mark your answer as being incorrect")
                }
                    Spacer()
                    
                    Button {
                        if let lastCard = cardArray.last {
                            remove(id: lastCard.id, saveForReview: false)
                        }
                    }label: {
                        Image(systemName: "checkmark.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(.circle)
                            .accessibilityLabel("Correct")
                            .accessibilityHint("Mark your answer as being correct.")
                    }
                    Spacer()
                    
                }.foregroundStyle(.white)
                    .font(.largeTitle)
                    .padding()
            }
          }
            
          
        }
        .onReceive(timer) { time in
            guard isTimerActive else{ return}
                if timeRemaining > 0 {
                    timeRemaining -= 1
                }
           
        }
        .onChange(of: scenePhase){
            if scenePhase == .active{
                if cardArray.isEmpty{
                    isTimerActive = true
                }
            }else{
                isTimerActive = false
            }
              
        }
        .sheet(isPresented: $isAddCard, onDismiss: resetCard, content: Project_17_Flashzilla_CardAddView.init)
        .onAppear(perform: resetCard)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    Project_17_Flashzilla()
}
