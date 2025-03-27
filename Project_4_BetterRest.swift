//
//  Project_4_BetterRest.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 05/03/25.
//

import CoreML
import SwiftUI

struct Project_4_BetterRest: View{
   
    @State private var wakeUpTime = defaultWakeUpTime
    @State private var sleepHours = 8.0
    @State private var cupOfCoffee = 1
    
    @State private var isShowAlert = false
   // @State private var alertTitle = ""
  //  @State private var alertMessage = ""
  
    static  var defaultWakeUpTime: Date {
        
        var component = DateComponents()
            component.hour = 7
            component.minute = 0
        
        return Calendar.current.date(from: component) ?? .now
        
        
    }
    
    var showBedTime: Date{
       
        do{
            let component = Calendar.current.dateComponents([.hour, .minute], from: wakeUpTime)
            
            let hour = (component.hour ?? 0) * 60 * 60
            let minutes = (component.minute ?? 0) * 60
            
            let config = MLModelConfiguration()
            
            let  model = try SleepCalculator(configuration: config)
            
            let prediction = try model.prediction(wake: Double(hour + minutes), estimatedSleep: sleepHours, coffee: Double(cupOfCoffee))
            
            let sleepTimeInterval = TimeInterval(prediction.actualSleep)
            let bedTime = wakeUpTime - sleepTimeInterval
            return bedTime
        }catch{
            return Date()
        }
        
       
    }

 /**   func calculateBedTime(){
        // calculation of bed time using toolbar button
        do{
            let component = Calendar.current.dateComponents([.hour, .minute], from: wakeUpTime)
            
            let hour = (component.hour ?? 0) * 60 * 60
            let minutes = (component.minute ?? 0) * 60
            
            let config = MLModelConfiguration()
            
            let  model = try SleepCalculator(configuration: config)
            
            let prediction = try model.prediction(wake: Double(hour + minutes), estimatedSleep: sleepHours, coffee: Double(cupOfCoffee))
            
            let sleepTime = wakeUpTime - prediction.actualSleep
            
        
         alertTitle = "Your ideal sleep time is"
            alertMessage = "\(sleepTime.formatted(date: .omitted, time: .shortened))"
          
           
        }catch{
            alertTitle = "Error"
            alertMessage = "Sorry there was a problem calculating your bed time."
        }
       isShowAlert = true
       
    }
    **/
    var body: some View{
        
        NavigationStack{
            Form{
            //    VStack(alignment: .leading){
                Section("When do you want to wake up?"){
                    //Text("When do you want to wake up?")
                      //  .font(.headline)
                    DatePicker("enter wake up time", selection: $wakeUpTime, displayedComponents: .hourAndMinute )
                        .labelsHidden()
                }
              //  VStack(alignment: .leading){
                Section("How much time you want to sleep?"){
                   // Text("How much time you want to sleep?")
                    //    .font(.headline)
                    
                    Stepper("\(sleepHours.formatted()) hours", value: $sleepHours, in: 4...12 ,  step: 0.25)
                }
          
              //  VStack(alignment: .leading){
                Section("Daily intake of cofee?"){
                   // Text("Daily intake of cofee?")
                     //   .font(.headline)
                   // Stepper("^[\(cupOfCoffee) cup](inflect: true)", value: $cupOfCoffee, in: 0...20)
                    Picker("Select number of cups", selection: $cupOfCoffee){
                        ForEach(0..<21){
                           Text("^[\($0) cup](inflect: true)")
                        }
                    }
                }
                Section{
                    Text(" Your ideal sleep time is \n \(showBedTime.formatted(date: .omitted, time: .shortened))")
                        .font(.title2.weight(.heavy))
                    
                 
                        
                }
               
                
              
                
            }
            
            
        
            .navigationTitle("BetterRest")
            .navigationBarTitleDisplayMode(.large)
           /** .toolbar{
                Button("calculate", action: calculateBedTime)
                    .alert(alertTitle, isPresented: $isShowAlert){
                        Button("OK"){ }
                    }message: {
                        Text("\(alertMessage)")
                    }
            }**/
            
        }
   
    }
}


#Preview {
    Project_4_BetterRest()
}
