//
//  Project_14_BucketList.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 17/03/25.
//
import MapKit
import SwiftUI

struct Project_14_BucketList: View {
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
                           span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
                          )
                        )
    
   
    @State private var viewModel = ViewModel()
    
    
    var body: some View {
        NavigationStack{
            if viewModel.isUnlocked{
                MapReader { proxy in
                    Map(initialPosition: startPosition){
                        
                        ForEach(viewModel.locationArray) { item in
                            Annotation(item.locationName, coordinate: item.locationCoordinates){
                                Image(systemName: "star.circle")
                                    .resizable()
                                    .foregroundStyle(.red)
                                    .frame(width: 44, height: 44)
                                    .background(.white)
                                    .clipShape(.circle)
                                    .simultaneousGesture(
                                        LongPressGesture().onEnded{ _ in
                                            viewModel.longPressLocation = item
                                        }
                                    )
                                
                            }
                        }
                    }
                    
                    .mapStyle(viewModel.whichMapViewArray[viewModel.whichMapView] ?? .standard)
                    .onTapGesture { tapPosition in
                        if let coordinates = proxy.convert(tapPosition, from: .local){
                            viewModel.addLocation(location: coordinates)
                        }
                    }
                    .sheet(item: $viewModel.longPressLocation){ place in
                        Project_14_BucketList_DetailView(dataInstance: place){
                            viewModel.updateLocation(at: $0)
                        }
                    }
                    
                } 
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Menu("Map View", systemImage: "map"){
                                Picker("choose Map View", selection: $viewModel.whichMapView){
                                    ForEach(viewModel.whichMapViewArray.keys.sorted(), id: \.self){ key in
                                        Text(key)
                                            .tag(key)
                                    }
                                }
                                
                                
                            }
                        }
                    }
            }else{
                
                Button("Unlock Location"){
                    viewModel.authenticate()
                }
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.capsule)
                
            }
               
        }.onAppear(perform: viewModel.authenticate)
            .alert("Authentication Failed", isPresented: $viewModel.isAlert){
                
            }
        message:{
            Text("Try pressing Unlock Location  ")
        }
    }
}

#Preview {
    Project_14_BucketList()
        .preferredColorScheme(.dark)
}
