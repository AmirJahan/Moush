import SwiftUI

struct LayerCellView: View
{
    @Binding
    var pathModel: PathModel
        
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
