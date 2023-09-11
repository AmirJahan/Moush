//
//  Uploadvg.swift
//  Moush_iOS
//
//  Created by Navpreet Singh on 2023-05-17.
//


import SwiftUI
import Foundation


struct UploadSvg: View
{
    @State var isShowing = false
    var body: some View
    {
        
        // on upload svg open the files folder and upload the file from there
        Button
        {
            isShowing.toggle()
        } label: {
            Text("Upload SVG")
        }.fileImporter(isPresented: $isShowing, allowedContentTypes: [.item]) { result in
            
            switch result {
                case .success(let url):
                
                // upload file using the url form the files folder
                // also, upload the files in a folder in the form of user/img.svg ex-> w123456789/fish.svg in the storage
                Cloud.inst.uploadFile(fileURL: url) { result in
                        switch result {
                        case .success(let downloadURL):
                            print("File uploaded successfully: \(downloadURL)")
                        case .failure(let error):
                            print("An error occurred: \(error)")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
        }
    }
}


struct UploadSvg_Previews: PreviewProvider {
    static var previews: some View {
        UploadSvg()
    }
}



