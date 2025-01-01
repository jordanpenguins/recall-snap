//
//  Person.swift
//  SnapRecall
//
//  Created by Jordan Ng on 03/02/2024.
//

import Foundation
import SwiftUI
import UIKit
import MapKit
import PhotosUI


struct Person: Identifiable, Codable, Comparable, Hashable{
    var id = UUID()
    var name: String
    var image: String
    
    var longitude: Double?
    var latitude: Double?
    
    var coordinate: CLLocationCoordinate2D? {
        if ((longitude != nil) && (latitude != nil)){
            return CLLocationCoordinate2D(latitude: latitude ?? 0.0, longitude: longitude ?? 0.0)
        } else{
            return nil
        }
    }
    
    var UIImage: UIImage{
        if let rebornImg = image.imageFromBase64{
            return rebornImg
        }
        
        // default ui image
        return UIKit.UIImage(systemName: "exclamationmark.warninglight.fill") ?? UIKit.UIImage()
            
    }
    
    static func <(lhs: Person, rhs: Person) -> Bool {
        lhs.name < rhs.name
    }
    
   
    
    
    
    
}
