//
//  Consolidation_Project_7To9_DetailView.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 11/03/25.
//

import SwiftUI
struct AnotherView: View {
    
     var activityInstance: Activity
    var storageInstance = DataStorage()
   
   
    
    
    func updateActivity(_ updateActivityCount: Activity){
        if let index = storageInstance.activities.firstIndex(where: {$0.id == updateActivityCount.id }){
            storageInstance.activities[index] = updateActivityCount
        }
    }
    
    func resetActivityCount(_ updateActivityCount: Activity){
        if let index = storageInstance.activities.firstIndex(where: {$0.id == updateActivityCount.id }){
            storageInstance.activities[index] = updateActivityCount
        }
    }
    
    var body: some View {
        NavigationStack{
            ZStack{
                
                Color(red: 0.1, green: 0.4, blue: 0.6)
                    .ignoresSafeArea()
                Rectangle()
                    .fill(Color(red: 0.5, green: 0.8, blue: 0.1))
                    .blur(radius: 100)
                    .frame(width: 400, height: 150)
                    .offset(x: 0, y: -400)
                
                
                Circle()
                    .fill(Color(red: 0.8, green: 0.8, blue: 0.3))
                    .blur(radius: 100)
                
                VStack{
                    VStack(alignment: .center, spacing: 20){
                        
                        
                        Text(activityInstance.activityTitle)
                            .font(.largeTitle.bold())
                            .foregroundStyle(.white)
                            .shadow(color: .blue ,radius: 30)
                            .padding(.top, 50)
                        
                        Rectangle()
                            .frame(height: 1)
                            .padding(.horizontal, 60)
                            .foregroundStyle(.white.opacity(0.4))
                        
                        
                        Text(activityInstance.activityDescription)
                            .font(.title.bold())
                            .foregroundStyle(.secondary)
                            .padding(.vertical,10)
                        Spacer()
                        VStack(alignment: .leading,spacing: 30){
                            Text("HOW MANY TIMES YOU DONE THIS ACTIVITY")
                                .font(.subheadline.italic().weight(.bold))
                                .foregroundStyle(.secondary)
                                .frame(maxWidth: .infinity)
                                .padding([.top, .leading, .trailing] , 2)
                            // .background(.ultraThinMaterial)
                            
                                .cornerRadius(5)
                            
                            
                            
                            HStack{
                                
                                Text("\(activityInstance.count)")
                                    .font(.title.bold())
                                
                                Spacer()
                                
                                Button{
                                    ///check this
                                    var copyOfActivity = activityInstance
                                    copyOfActivity.count += 1
                                    updateActivity(copyOfActivity)
                                    
                                }label:{
                                    Image(systemName: "plus")
                                        .resizable()
                                        .foregroundStyle(.primary)
                                        .shadow(color: .blue ,radius: 50)
                                        .frame(width: 25, height: 25)
                                        .shadow(color: .blue, radius: 200)
                                }
                                
                                
                                
                            }.padding(.horizontal)
                                .background(.regularMaterial)
                                .cornerRadius(10)
                            HStack{
                                Spacer()
                                Button{
                                    ///check this
                                    var copyOfActivity = activityInstance
                                    copyOfActivity.count = 0
                                    resetActivityCount(copyOfActivity)
                                    
                                }label:{
                                    Text("Reset")
                                        .foregroundStyle(.white)
                                        .padding(8)
                                        .background(.red)
                                        .cornerRadius(8)
                                    
                                    
                                    
                                    // .frame(width: 25, height: 25)
                                    
                                }
                                Spacer()
                            }
                            
                        }.padding()
                        Spacer()
                        
                    }.background(.regularMaterial)
                        .cornerRadius(20)
                }.padding()
                   
                    .background(.black)
                    .labelsHidden()
            }
        }
    }
}

#Preview {
   // let Storage = DataStorage()
    let activity = Activity(activityTitle: "Title", activityDescription: "descritption")
    AnotherView(activityInstance: activity)
        .preferredColorScheme(.dark)
}

