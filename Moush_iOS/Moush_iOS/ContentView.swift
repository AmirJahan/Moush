//
//  ContentView.swift
//  Moush_iOS
//
//  Created by The Odd Institute on 2023-04-30.
//

import SwiftUI

struct ContentView: View {
    var body: some View
    {
        NavigationStack
        {
            NavigationLink {
                SwiftUI_SVG()
            } label: {
                Text("SVG Mercedes")
            }
            
            NavigationLink {
                SVGView()
            } label: {
                Text("SVG og")
            }

            VStack
            {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Hello, world!")
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
