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
                if vm.selectedPathIndices != []
                {
                    AttributesView(vm: vm, selectedFillColor: $vm.selectedPathFill, selectedStrokeColor: $vm.selectedPathStroke) {
                        vm.updateSelectedPathColors(newFillColor: vm.selectedPathFill, newStrokeColor: vm.selectedPathStroke)
                    }
                }
            }
        }
    }
}
