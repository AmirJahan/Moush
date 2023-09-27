//
//  Cloud+Downloading.swift
//  Moush_iOS
//
//  Created by Gavin Van Hussen on 2023-09-27.
//

import UIKit
import Foundation

extension Cloud {
    func saveImage(data: Data, fileName: String)
    {
        let fileManager = FileManager.default
        let documentsDirectory = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)

        if let documentsDirectory = documentsDirectory
        {
            let filePath = documentsDirectory.appendingPathComponent(fileName)
            // Make sure our document directory and our file path are valid
            
            do
            {
                // Using file popup menu,
                try data.write(to: filePath)
                let documentPicker = UIDocumentPickerViewController(url: filePath, in: .exportToService)
                documentPicker.allowsMultipleSelection = false
                UIApplication.shared.windows.first?.rootViewController?.present(documentPicker, animated: true, completion: nil)
                // ignore these warnings 😅😅😅 If this isn't working later you're going to have to do file saving popup in a separate view
                
                print("File saved at \(filePath)")
            }
            catch
            {
                print("Error saving file: \(error)")
            }
        }
    }
}
