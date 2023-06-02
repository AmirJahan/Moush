//
//  TextEditor.swift
//  Moush_iOS
//
//  Created by Melissa Osorio Tavera on 2023-05-17.
//

import Foundation
import SwiftUI

struct TextAttrView: View {
    @State private var inputSentence: String = ""
    let colorArray: [Color] = [.red, .green, .blue, .orange, .purple] // Example color array
    
    var coloredText: Text {
        let hashtags = findHashtags(in: inputSentence)
        return coloredTextForHashtags(in: inputSentence, hashtags: hashtags)
    }
    
    var body: some View {
        VStack {
            Text("Input Sentence:")
                .font(.headline)
            ZStack(alignment: .topLeading)
            {
                TextEditor(text: $inputSentence)
                    .padding()
                    .foregroundColor(.white)
                coloredText
                    .padding()
            }
        }
    }
    
    func findHashtags(in sentence: String) -> [String] {
        let words = sentence.components(separatedBy: CharacterSet.whitespacesAndNewlines)
        
        var hashtags: [String] = []
        
        for word in words {
            if word.hasPrefix("#") {
                hashtags.append(word)
            }
        }
        
        return hashtags
    }
    
    func coloredTextForHashtags(in sentence: String, hashtags: [String]) -> Text {
        let words = sentence.components(separatedBy: CharacterSet.whitespacesAndNewlines)
        
        var coloredText = Text("")
        
        for word in words {
            if word.hasPrefix("#") {
                let hashtag = word
                let color = colorForHashtag(hashtag)
                coloredText = coloredText + Text(word + " ").foregroundColor(color)
            } else {
                coloredText = coloredText + Text(word + " ")
            }
        }
        
        return coloredText
    }
    
    func colorForHashtag(_ hashtag: String) -> Color {
        let index = findHashtags(in: inputSentence).firstIndex(of: hashtag) ?? 0
        let colorIndex = index % colorArray.count
        return colorArray[colorIndex]
    }
}


/// extension to make applying AttributedString even easier
extension Text {
    init(_ string: String, configure: ((inout AttributedString) -> Void)) {
        var attributedString = AttributedString(string) /// create an `AttributedString`
        configure(&attributedString) /// configure using the closure
        self.init(attributedString) /// initialize a `Text`
    }
}


