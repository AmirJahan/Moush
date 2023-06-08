import SwiftUI

struct LayerCellView: View
{
    @Binding
    var pathModel: PathModel
    
    @State private var isEditingColor = false
    
    var body: some View
    {
        HStack
        {
            Image(systemName: pathModel.visible ? "eye.circle.fill" : "eye.slash.circle")
                .padding(12)
                .onTapGesture {
                    self.pathModel.visible.toggle()
                }
            
            Text("")
                .strikethrough(pathModel.visible)
                .font(.system(size: 22))
            
//            Button(action: {
//                isEditingColor = true
//            }) {
//                Text("Change Color")
//            }
//            .onTapGesture {
//                isEditingColor.toggle()
//            }
        }
        .sheet(isPresented: $isEditingColor)
        {
//            ColorEditorView(selFillColor: $pathModel.fill,
//                            selStrokeColor: $pathModel.stroke,
//                            selStrokeWidth: $pathModel.strokeWidth)

        }
        .frame(maxWidth: .infinity, minHeight: 64, alignment: .leading)
        .contentShape(Rectangle()) // clickable area
    }
}


struct LayerCellView_Previews: PreviewProvider {
    static var previews: some View {
        LayerCellView(pathModel: .constant(StaticData.examplePath))
    }
}
