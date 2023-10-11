import SwiftUI


struct EditSvgScreen: View {
    var svgName: String

    @StateObject
    var vm: ViewModel
    
    init(svgName: String) {
        self.svgName = svgName
        _vm = StateObject(wrappedValue: ViewModel(svgName: svgName))
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
                // TODO: Make the foreground color change when the undoredostack is at the beggining or the end
                Button {
                    vm.UndoRedoStack.undo()
                } label: {
                    Image(systemName:"arrowshape.turn.up.left")
                        .foregroundColor(.blue)
                }
                Button {
                    vm.UndoRedoStack.redo()
                } label: {
                    Image(systemName: "arrowshape.turn.up.right")
                        .foregroundColor(.blue)
                }
            }
            .padding()
            
            HStack
            {
                if vm.selectedPathIndices != []
                {
                    
                    AttributesView(vm: vm, selectedFillColor: vm.paths[vm.selectedPathIndices.last!].fill, selectedStrokeColor: vm.paths[vm.selectedPathIndices.last!].stroke, selectedStorkeWidth: vm.paths[vm.selectedPathIndices.last!].strokeWidth) {
                        vm.updateSelectedPathColors(newFillColor: vm.selectedPathFill, newStrokeColor: vm.selectedPathStroke)
                    }
                }
            }
            
            
            
        }
    }
}
