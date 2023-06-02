import Foundation
import SwiftUI

struct ColorEditorView: View {
    @Binding var selectedColor: Color
    var onSave: (Color) -> Void
    
    var body: some View {
        VStack {
            ColorPicker("Select color", selection: $selectedColor, supportsOpacity: false)
                .padding()
            
            Button(action: {
                onSave(selectedColor)
            }) {
                Text("Save")
            }
        }
        .padding()
    }
}






