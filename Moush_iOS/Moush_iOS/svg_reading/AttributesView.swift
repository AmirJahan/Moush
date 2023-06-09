import Foundation
import SwiftUI

struct AttributesView: View
{
    @ObservedObject
    var vm: ViewModel
    
    //Added state variables to change the attribute through the UndoRedoSystem instead of throught the color picker
    @State var selectedFillColor: Color = .black
    @State var selectedStrokeColor: Color = .black
    @State var selectedStorkeWidth: Float = 0
    
    var body: some View
    {
        VStack
        {
            HStack
            {
                ColorPicker("", selection: $selectedFillColor,
                            supportsOpacity: false)
                    .padding()
                    .onChange(of: selectedFillColor) { color in
                        //Create a instance of the command with the necesary information
                        //When added the stack executes the command
                        vm.UndoRedoStack.invoke(command:
                            ChangeFillColorCommand(selectedItem: $vm.paths[vm.selectedPathIndex],
                                 previousColor: vm.paths[vm.selectedPathIndex].fill,
                                 currentColor: selectedFillColor))
                    }
                
                ColorPicker("", selection: $selectedStrokeColor,
                            supportsOpacity: false)
                .padding()
                .onChange(of: selectedStrokeColor) { color in
                    //Create a instance of the command with the necesary information
                    //When added the stack executes the command
                    vm.UndoRedoStack.invoke(command:
                        ChangeStrokeColorCommand(selectedItem: $vm.paths[vm.selectedPathIndex],
                             previousColor: vm.paths[vm.selectedPathIndex].fill,
                             currentColor: selectedStrokeColor))
                }
            }
            .padding()
            
            
            Slider(value: $selectedStorkeWidth, in: 0.0...10.0) {
                Text("Stroke Width")
            }
            .onChange(of: selectedStorkeWidth) { newValue in
                //Create a instance of the command with the necesary information
                //When added the stack executes the command
                vm.UndoRedoStack.invoke(command:
                    ChangeStrokeWithCommand(selectedItem: $vm.paths[vm.selectedPathIndex],
                         previousWidth: vm.paths[vm.selectedPathIndex].strokeWidth,
                         currentWidth: newValue))
            }
            
            
        }
        
    }
}






