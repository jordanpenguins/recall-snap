//
//  MapView.swift
//  SnapRecall
//
//  Created by Jordan Ng on 14/02/2024.
//

import SwiftUI
import PhotosUI
import MapKit

struct MapView: View {
    @Environment(\.dismiss) private var dismiss
    let person: Person
    let position: MapCameraPosition
    
    var body: some View {
        
        ZStack(alignment: .topTrailing){
            Map(initialPosition: position) {
                if let coordinate = person.coordinate {
                    Annotation("", coordinate: coordinate) {
                        Image(uiImage: person.UIImage)
                            .resizable()
                            .frame(width: 75, height: 75)
                            .cornerRadius(37.5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 37.5)
                                    .stroke(.red, lineWidth: 4)
                            )
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)
            
            Button(action: {
                dismiss()
                
            }) {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .foregroundColor(.red)
                    .frame(width: 30, height: 30)
                    .padding()
                    // Adjust the padding as needed
            }
            
           
            
        }
        
    }
    
    init(person: Person){
        self.person = person
        self.position = MapCameraPosition.region(
            MKCoordinateRegion(
                center: person.coordinate ?? CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0),
                span: MKCoordinateSpan(latitudeDelta: (person.coordinate != nil) ? 0.1 : 100.0, longitudeDelta: (person.coordinate != nil) ? 0.1 : 100.0)
            )
        )
    }
    
}

#Preview {
    guard let testImage = UIImage(named: "test") else {
        return Text("Unable to load Image")
    }
    // Convert the testImage into base64 String
    
    guard let testImageBase64 = testImage.base64 else{
        return Text("Unable to conver image")
    }
    
    let person = Person(id: UUID(), name: "Jordan", image: testImageBase64, longitude: 2.2945, latitude: 48.8584)
    

    return MapView(person: person)
}
