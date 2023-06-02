import SwiftUI

struct PathCellView: View {
    @Binding var path: PathModel
    @State private var isEditingColor = false
    
    var body: some View {
        HStack {
            Image(systemName: path.visible ? "checkmark.square.fill" : "square")
                .padding(12)
                .onTapGesture {
                    self.path.visible.toggle()
                }
            
            Text("")
                .strikethrough(path.visible)
                .font(.system(size: 22))
            
            Button(action: {
                isEditingColor = true
            }) {
                Text("Change Color")
            }
            .onTapGesture {
                isEditingColor.toggle()
            }
        }
        .sheet(isPresented: $isEditingColor) {
            ColorEditorView(selectedColor: $path.fill) { newColor in
                // Update the path.fill with the newColor
                path.fill = newColor
            }
        }
        .frame(maxWidth: .infinity, minHeight: 64, alignment: .leading)
        .contentShape(Rectangle()) // clickable area
    }
}


struct PathCellView_Previews: PreviewProvider {
    static var previews: some View {
        PathCellView(path: .constant(StaticData.examplePath))
    }
}
