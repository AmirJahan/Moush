//
//  ContentView.swift
//  GoogleDriveAPI
//
//  Created by Micaella Langit on 2023-09-13.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack (spacing: 20) {
            Button {
                //this is where we put the functionality
            } label: {
                Text("Import from Google Drive")
            }
            
            Button {
                //this is where we put the functionality
            } label: {
                Text("Take Photo")
            }
            
            Button {
                //this is where we put the functionality
            } label: {
                Text("Open Gallery")
            }
            
            Button {
                //this is where we put the functionality
            } label: {
                Text("Save to Google Drive")
            }
        }
        .padding(10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
