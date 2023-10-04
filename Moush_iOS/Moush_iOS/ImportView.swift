//
//  ImportView.swift
//  Moush_iOS
//
//  Created by Micaella Langit on 2023-09-11.
//

import SwiftUI

struct ImportView: View
{
    var body: some View
    {
        VStack (spacing: 15) {
            
            Button {
                //code to import from google drive
            } label: {
                
                Text("Import From Google Drive")
                    .foregroundColor(.myPrimaryColor)
                    .edgesIgnoringSafeArea(.all)
            }
            
            Button {
                //code to open camera
            } label: {
            
                Text("Take Photo")
                    .foregroundColor(.myPrimaryColor)
                    .edgesIgnoringSafeArea(.all)
            }
            
            Button {
                //code to open gallery
            } label: {
            
                Text("Open Gallery")
                    .foregroundColor(.myPrimaryColor)
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
}

struct ImportView_Previews: PreviewProvider
{
    static var previews: some View
    {
        ImportView()
    }
}
