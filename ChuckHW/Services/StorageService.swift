//
//  StorageService.swift
//  ChuckHW
//
//  Created by Guy Cohen on 27/06/2022.
//

import UIKit

class StorageService {
    
    static func getDocumentsFolder() -> URL {
//        FileManager.default.urls(for: .cachesDirectory, in: .localDomainMask)
        // Back up to iCloud
        let urls = FileManager.default.urls(for: .documentDirectory, in: .allDomainsMask)
        return urls[0] // Only 1 documentDirectory
    }
    
    static func getImage(imageName: String) -> UIImage? {
        let imageName: URL = getDocumentsFolder().appendingPathComponent(imageName)
        if let mainImage = UIImage(contentsOfFile: imageName.path) {
            return mainImage
        }
        return nil
    }
    
    static func saveImage(data: Data, imageName: String) {
        let chuckNorrisFileName: URL = getDocumentsFolder().appendingPathComponent(imageName)
        do {
            try data.write(to: chuckNorrisFileName)
        } catch (let error) {
            print("Error:\(error)")
        }
    }
    
}
