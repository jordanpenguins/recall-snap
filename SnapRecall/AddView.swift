//
//  AddView.swift
//  SnapRecall
//
//  Created by Jordan Ng on 03/02/2024.
//

import SwiftUI
import PhotosUI

struct AddView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var name = ""
    @State private var selectedItem: PhotosPickerItem?
    @State private var processedImage: Image?
    @State private var enableLocation: Bool  = false
    @State private var displayError: Bool = false
    
    let locationFetcher = LocationFetcher()
    
    var onSave: (Person) -> Void
    
    
    var body: some View {
        Form {
            Section{
                PhotosPicker(selection: $selectedItem){
                    if let processedImage{
                        processedImage
                            .resizable()
                            .scaledToFit()
                    } else{
                        ContentUnavailableView("Add an Image", systemImage: "photo.badge.plus")
            
                    }
                }
                .onChange(of: selectedItem,loadImage)
            }
            
            Section{
                TextField("Name", text: $name)
            }
            
            Section{
                Toggle("Save Location?", isOn: $enableLocation)
    
            }
        }
        .onChange(of: enableLocation) {
            
            if enableLocation{
                locationFetcher.start()
            } else {
                locationFetcher.lastKnownLocation = nil
            }
        }
        .toolbar{
            Button("Save") {
                // pure binary data
                Task {
                    guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
                    
                    // load data into UI Image
                    guard let inputImage = UIImage(data: imageData) else { return }
                        
                    // convert UIImage into base64
                    if let base64 = inputImage.base64{
                        
                        let location = locationFetcher.lastKnownLocation
                        print(location ?? "Nil")
                        // save the UIImage into base64 binary
                        let person = Person(name: name, image: base64, longitude: location?.longitude, latitude: location?.latitude)
                        onSave(person)
                        dismiss()
                    }
                }
            }
        }
        .navigationTitle("Add Person")
    }
    
    init(onSave: @escaping (Person) -> Void){
        self.onSave = onSave
    }
    
    func loadImage() {
        Task {
            // pure binary data
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
            
            // load data into UI Image
            guard let inputImage = UIImage(data: imageData) else { return }
            processedImage = Image(uiImage: inputImage)
        }
    }
}

#Preview {
    AddView() { _ in
        
    }
}
