//
//  ImageConverter.swift
//  SnapRecall
//
//  Created by Jordan Ng on 05/02/2024.
//

import Foundation
import PhotosUI

// source: 


// this extention allows UIImage type to be converted into base64 String

extension UIImage {
    var base64: String? {
        self.jpegData(compressionQuality: 1)?.base64EncodedString()
    }
}

// this extention allows base64 String type to be converted into UIImage type 


extension String {
    var imageFromBase64: UIImage? {
        guard let imageData = Data(base64Encoded: self, options: .ignoreUnknownCharacters) else {
            return nil
        }
        return UIImage(data: imageData)
    }
}

//let img = //get UIImage from wherever
//let base64 = img.base64
//let rebornImg = base64?.imageFromBase64
