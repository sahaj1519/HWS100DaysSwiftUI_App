//
//  Project_16_HotProspects_ProspectView.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 20/03/25.
//

import CodeScanner
import SwiftData
import SwiftUI
import UserNotifications

struct Project_16_HotProspects_ProspectView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query  var dataInstance: [Project_16_HotProspects_DataModel]
    
    enum SortOption: String, CaseIterable {
        case name = "Sort By Name"
        case date = "Most Recent"
    }
    @State private var selectedSort: SortOption = .name
    
    var sortedData: [Project_16_HotProspects_DataModel] {
        switch selectedSort {
        case .name:
            return dataInstance.sorted(using: [SortDescriptor(\.name)])
        case .date:
            return dataInstance.sorted(using: [SortDescriptor(\.date, order: .reverse)])
        }
    }
    
    enum FilterType{
        case none, contacted, uncontacted
    }
    
    let filter: FilterType
    @State private var isShowingScanner = false
    @State private var selectedPerson = Set<Project_16_HotProspects_DataModel>()
   
    var navigationTitle: String{
        switch filter {
        case .none:
            "Everyone"
        case .contacted:
            "Contacted People"
        case .uncontacted:
            "Uncontacted People"
        }
        
    }
    
    init(filter: FilterType){
        
        self.filter = filter
        
        if filter != .none{
            
            let showContactedOnly = filter == .contacted
          
                _dataInstance = Query(filter: #Predicate{
                    $0.isContacted == showContactedOnly
                    
                }, sort: \Project_16_HotProspects_DataModel.name)
           
        }
        
    }
    
    func handleCodeScan(result: Result<ScanResult, ScanError>){
        isShowingScanner = false
        switch result {
        case .success(let success):
            let detail = success.string.components(separatedBy: "\n")
            guard detail.count == 2 else{return}
            
            let newPerson = Project_16_HotProspects_DataModel(name: detail[0], emailAddress: detail[1], isContacted: false, date: Date.now)
            modelContext.insert(newPerson)
            
        case .failure(let failure):
            print("error while scanning code \(failure.localizedDescription)")
        }
    }
    
    func delete(){
        for item in selectedPerson{
            modelContext.delete(item)
        }
    }
    
    func addNotification(for person: Project_16_HotProspects_DataModel){
        let centre = UNUserNotificationCenter.current()
        let addRequest = {
            
            let content = UNMutableNotificationContent()
            content.title = "Contact \(person.name)"
            content.subtitle = "\(person.emailAddress)"
            content.sound = UNNotificationSound.default
//            
//           var timeOfNotification = DateComponents()
//            timeOfNotification.hour = 9
//            let trigger = UNCalendarNotificationTrigger(dateMatching: timeOfNotification, repeats: false)
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            
            centre.add(request)
            
        }
        
        centre.getNotificationSettings{setting in
            if setting.authorizationStatus == .authorized {
                addRequest()
            }else{
                centre.requestAuthorization(options: [.alert, .badge , .sound]){ succes, error in
                    if succes{
                        addRequest()
                    }else if let error{
                        print("\(error.localizedDescription)")
                    }
                }
            }
            
        }
    }
    
    // body start here
    var body: some View {
        NavigationStack{
            
            List(sortedData, selection: $selectedPerson){ item in
                NavigationLink{
                    
                    Project_16_HotProspects_DetailView(data: item)
                }
                label:{
                VStack(alignment: .leading){
                    HStack{
                        Text(item.name)
                            .font(.headline.bold())
                        if item.isContacted{
                            Image(systemName: "checkmark.circle")
                                .foregroundStyle(.green)
                                .font(.subheadline)
                                .padding(.horizontal, 10)
                        }
                    }
                    Text(item.emailAddress)
                        .foregroundStyle(.secondary)
                    
                }.swipeActions{
                    Button("Delete", systemImage: "trash", role: .destructive){
                        modelContext.delete(item)
                    }
                    
                    if item.isContacted {
                        Button("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark"){
                            item.isContacted.toggle()
                        }.tint(.blue)
                    }else{
                        Button("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark"){
                            item.isContacted.toggle()
                        }.tint(.green)
                        
                        Button("Remind Me", systemImage: "bell"){
                            addNotification(for: item)
                            
                        }.tint(.orange)
                    }
                    
                }
                
              }
                .tag(item)
            }
            
            
            
            
                .navigationTitle(navigationTitle)
                .preferredColorScheme(.dark)
                .toolbar{
                    ToolbarItem(placement: .topBarTrailing){
                        Button("Add People", systemImage: "qrcode.viewfinder"){
                            isShowingScanner = true
                        }
                    }
                    ToolbarItem(placement: .topBarLeading){
                        EditButton()
                    }
                    
                    ToolbarItem(placement: .bottomBar){
                        Menu("Sort", systemImage: "arrow.up.arrow.down"){
                            Picker("Sort", selection: $selectedSort) {
                                ForEach(SortOption.allCases, id: \.self) { option in
                                    Text(option.rawValue).tag(option)
                                }
                            }
                        }
                    }
                    ToolbarItem(placement: .bottomBar){
                        
                        if selectedPerson.isEmpty == false {
                            Button("Delete selected", role: .destructive){
                                delete()
                            }
                            .padding(.horizontal, 90)
                        }
                    }
                }
                .sheet(isPresented: $isShowingScanner){
                    CodeScannerView(codeTypes: [.qr], simulatedData: "Akia\nakia@deamland.com", completion: handleCodeScan)                }
        }
    }
}

#Preview {
    Project_16_HotProspects_ProspectView(filter: .none)
        .modelContainer(for: Project_16_HotProspects_DataModel.self)
}
