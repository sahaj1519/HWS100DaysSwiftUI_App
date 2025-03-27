//
//  Consolidation_Project_13To15_DetailView_Map.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 19/03/25.
//
import MapKit
import SwiftUI

struct Consolidation_Project_13To15_DetailView_Map: View {
    
    @Bindable var data: Consolidation_Project_13To15_DataModel
    var imageId: UUID
    
    @State var tapCoordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
  
    var body: some View {
        MapReader{ proxy in
            Map(initialPosition: MapCameraPosition.region(
                MKCoordinateRegion(
                    center: data.returnPosition(id: imageId),
                    span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                ))){ // map body start here
                    
                    Marker("", coordinate: tapCoordinate)
                    Annotation("",coordinate: data.returnPosition(id: imageId)){
                        Image(systemName: "star.circle")
                            .resizable()
                            .foregroundStyle(.red)
                            .frame(width: 44, height: 44)
                            .background(.white)
                            .clipShape(.circle)
                    }
                    MapCircle(center: data.returnPosition(id: imageId), radius: 3000)
                        .foregroundStyle(.blue.opacity(0.3))
                   
                    
                }.onTapGesture{ tapPosition in
                    if let coordinate = proxy.convert(tapPosition, from: .local){
                        tapCoordinate = coordinate
                    }
                }

        }
    }
}

#Preview {
    Consolidation_Project_13To15_DetailView_Map(data: Consolidation_Project_13To15_DataModel(), imageId: UUID())
}
