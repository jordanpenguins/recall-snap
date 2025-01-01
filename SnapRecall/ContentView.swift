//
//  ContentView.swift
//  SnapRecall
//
//  Created by Jordan Ng on 03/02/2024.
//

import SwiftUI

struct ContentView: View {
    
    let savePath = URL.documentsDirectory.appending(path: "savePath")
    @State var person: [Person] = []
    
    var body: some View {
        NavigationStack{
            List {
                ForEach(person) { item in
                    ZStack{
                        VStack(alignment: .leading){
                            Image(uiImage: item.UIImage)
                                .resizable()
                                .scaledToFit()
                    
                            Text(item.name)
                                .fontWeight(.bold)
                                .padding(.bottom)
                                .padding(.leading)
                                
                                
                        }
                        .clipShape(.rect(cornerRadius: 20))
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.gray)
                        )
                        NavigationLink(value: item){
                            EmptyView()
                        }
                        
                    }
                }
                .onDelete(perform: removeImage)
                .listRowSeparator(.hidden)
                
                
            }
            .navigationDestination(for: Person.self){ person in
                DetailView(person: person)
            }

            .listStyle(.plain)
            .padding()
            .navigationTitle("SnapRecall")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink("Add Person"){
                        AddView { newPerson in
                            person.append(newPerson)
                            save()
                        }
                        
                    }
                }
            }
            .onAppear(perform: loadData)
        }
        
    }
    
    // load
    func loadData(){
        do {
            let data = try Data(contentsOf: savePath)
            person = try JSONDecoder().decode([Person].self, from: data)
        } catch {
            person = []
        }
        
    }
    
    // save
    func save(){
        do {
            let data = try JSONEncoder().encode(person)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            //ensure encryption when storing files and atomic writes
        } catch {
            print("Unable to save data.")
        }
    }
    
    //delete
    func removeImage(at offset: IndexSet) {
        // get the sorted data information before deleting
        for element in offset{
            if let index = person.firstIndex(where:{ $0.id == person[element].id}) {
                person.remove(at: index)
                save()
            }
        }
    }
}

#Preview {
    ContentView()
}
