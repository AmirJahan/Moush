//
//  TextEditor.swift
//  Moush_iOS
//
//  Created by Melissa Osorio Tavera on 2023-05-17.
//

import Foundation
import SwiftUI


//The AttributedTextView struct is responsible for displaying the attributed text.
//It conforms to the UIViewRepresentable protocol, which allows it to be used as a SwiftUI view.
struct AttributedTextView: UIViewRepresentable
{
    let attributedString: NSAttributedString
    //It takes an attributedString as input and displays it using a UITextView.
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
    //plain text input from the user
    @State var inputText = ""
    
    //attributedString to store the attributed text that will be displayed.
    @State var attributedString = NSMutableAttributedString(string: "")

    var body: some View {
        VStack {
            Text("Text Editor")
                .padding()
            UITextViewWrapper(text: $inputText, attributedString: $attributedString)
                .background(Color.gray)
                .padding()
                .onChange(of: inputText) { newValue in
                    updateAttributedString()
                }
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

struct UITextViewWrapper: UIViewRepresentable {
    @Binding var text: String
    @Binding var attributedString: NSMutableAttributedString

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isEditable = true
        textView.isScrollEnabled = true
        textView.delegate = context.coordinator // Set the delegate
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
        uiView.attributedText = attributedString
    }

    // Coordinator to handle UITextViewDelegate methods
    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text, attributedString: $attributedString)
    }

    class Coordinator: NSObject, UITextViewDelegate {
        @Binding var text: String
        @Binding var attributedString: NSMutableAttributedString

        init(text: Binding<String>, attributedString: Binding<NSMutableAttributedString>) {
            _text = text
            _attributedString = attributedString
        }

        func textViewDidChange(_ textView: UITextView) {
            text = textView.text // Update the text binding
            attributedString = NSMutableAttributedString(string: text) // Update the attributed string binding
        }
    }
}



struct TextEditorView_Previews: PreviewProvider {
    static var previews: some View {
        TextEditorView()
    }
}














