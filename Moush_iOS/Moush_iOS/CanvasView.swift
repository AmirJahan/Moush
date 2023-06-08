import SwiftUI

struct EditCanvasView: View
{
    @ObservedObject
    var vm: ViewModel
    
    var body: some View
    {
        ZStack
        {
            ForEach(vm.paths.indices, id: \.self) { index in
                let thisPath = vm.paths[index]
                
                if thisPath.visible
                {
                    if let f = thisPath.fill,
                       let path = thisPath.path {
                        path.fill(f)
                    }
                    
                    if let s = thisPath.stroke,
                       let sw = thisPath.strokeWidth,
                       let path = thisPath.path {
                        path.stroke(s, lineWidth: CGFloat(sw))
                    }
                }
            }
        }
    }
}

struct EditCanvasView_Previews: PreviewProvider {
    static var previews: some View {
        EditCanvasView(vm: ViewModel())
    }
}
