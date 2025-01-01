//
//  DetailView.swift
//  SnapRecall
//
//  Created by Jordan Ng on 09/02/2024.
//

import SwiftUI

struct DetailView: View {
    
    var person: Person
    
    @State private var showMap = false
    
    
    var body: some View {
        VStack{
            Image(uiImage: person.UIImage)
                .resizable()
                .scaledToFit()
            
            Button("View location"){
                showMap = true
            }
            
        }
        .sheet(isPresented: $showMap){
            MapView(person: person)
        }
        
        
    }
}

#Preview {
    
    
    guard let testImage = UIImage(named: "test") else {
        return Text("Unable to find image")
    }
    // Convert the testImage into base64 String
    if let testImageBase64 = testImage.base64 {
        let person = Person(id: UUID(), name: "Jordan", image: testImageBase64)
        return DetailView(person: person)
    } else {
        print("Unable to convert into base64")
        return Text("Error: Unable to convert image into base64")
    }
}
