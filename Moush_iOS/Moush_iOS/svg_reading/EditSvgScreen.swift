import SwiftUI



struct EditSvgScreen: View
{
    var svgName: String

        @StateObject
        var vm: ViewModel
        
        init(svgName: String) {
            self.svgName = svgName
            _vm = StateObject(wrappedValue: ViewModel(resourceName: svgName))
        }
    
    
    var body: some View
    {
        VStack
        {
            EditCanvasView(vm: vm)
                .background(.gray)
                .padding()
            
            HStack
            {
                SvgLayersView(vm: vm)
                
                if vm.selectedPathIndex != -1
                {
                    AttributesView(vm: vm)
                }
            }
        }
    }
}
