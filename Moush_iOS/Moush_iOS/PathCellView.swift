import SwiftUI

struct PathCellView: View
{
    @Binding
    var path: PathModel
    
    var body: some View
    {
        let col: Color = path.visible ? .gray : .clear

        HStack
        {
            let img = path.visible ? "checkmark.square.fill" : "square"
            Image (systemName: img)
                .padding(12)
            
            Text ("")
                .strikethrough(path.visible)
                .font(.system(size: 22))
        }
        .frame(maxWidth: .infinity, minHeight: 64, alignment: .leading)
        .contentShape(Rectangle()) // clickable area
        .background(col)
        .onTapGesture
        {
            self.path.visible.toggle()
        }
    }
}

struct PathCellView_Previews: PreviewProvider {
    static var previews: some View {
        PathCellView(path: .constant(StaticData.examplePath))
    }
}
