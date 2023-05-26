//
//  TextEditor.swift
//  Moush_iOS
//
//  Created by Melissa Osorio Tavera on 2023-05-17.
//

import Foundation
import SwiftUI

struct AttributedTextView: UIViewRepresentable
{
    let attributedString: NSAttributedString
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.attributedText = attributedString
    }
}

struct TextEditorView: View {
    @State var inputText = ""
    @State var attributedString = NSMutableAttributedString(string: "")

    var body: some View {
        VStack {
            TextField("change me...", text: $inputText)
                .background(Color.gray)
                .padding()
                .onChange(of: inputText) { newValue in
                    updateAttributedString()
                }

            AttributedTextView(attributedString: attributedString)
                .font(.system(size: 14))
                .multilineTextAlignment(.center)
                .padding()
        }
        .onAppear {
            updateAttributedString()
        }
    }

    private func updateAttributedString() {
        let text = inputText
        let regex = try! NSRegularExpression(pattern: "#\\w+")

        attributedString = NSMutableAttributedString(string: text)

        let matches = regex.matches(in: text, range: NSRange(text.startIndex..., in: text))
        for match in matches {
            let matchRange = match.range
            attributedString.addAttribute(.foregroundColor, value: UIColor.red, range: matchRange)
        }

        attributedString.addAttribute(.foregroundColor, value: UIColor.gray, range: NSRange(location: 0, length: text.count))

        let hashtagRanges = regex.matches(in: text, range: NSRange(text.startIndex..., in: text)).map { $0.range }
        for range in hashtagRanges {
            let wordRange = NSRange(location: range.location, length: range.length)
            attributedString.addAttribute(.foregroundColor, value: UIColor.red, range: wordRange)
        }
    }
}


struct TextEditorView_Previews: PreviewProvider {
    static var previews: some View {
        TextEditorView()
    }
}







