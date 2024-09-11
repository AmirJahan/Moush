import SwiftUI

struct TextAttrView: View {
    @State
    var inputSentence: String = "Hello"

    let colorArray: [Color] = [.red, .green, .blue, .orange, .purple]

    var body: some View {
        VStack {
            Text("Input Sentence:")
                .font(.headline)

            ZStack(alignment: .topLeading) {
                TextEditor(text: $inputSentence)
                    .frame(height: 96)
                    .padding()
                    .foregroundColor(.white)
                    .font(.system(size: 24))

                HStack {
                    coloredTextForHashtags()
                        .font(.system(size: 24))
                        .padding(.leading, 20)
                        .padding(.top, 24)
                }
            }
        }
    }

    func coloredTextForHashtags() -> Text {
        let words = inputSentence.components(separatedBy: CharacterSet.whitespacesAndNewlines)
        var coloredText = Text("")

        var colIndex = 0

        for word in words {
            if word.hasPrefix("#") {
                // it's a hashtag
                let hashtag = word

                // let's find the color we want
                let color = colorArray[colIndex]
                coloredText = coloredText + Text(word + " ").foregroundColor(color)

                colIndex += 1
                colIndex %= colorArray.count
            } else {
                coloredText = coloredText + Text(word + " ")
            }
        }

        return coloredText
    }
}

struct TextAttrView_Previews: PreviewProvider {
    static var previews: some View {
        TextAttrView()
    }
}
