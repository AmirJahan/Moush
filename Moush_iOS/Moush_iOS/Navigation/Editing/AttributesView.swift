import Foundation
import SwiftUI

struct AttributesView: View
{
    @ObservedObject
    var vm: ViewModel
    
    //Added state variables to change the attribute through the UndoRedoSystem instead of throught the color picker
    @State var selectedFillColor: Color
    @State var selectedStrokeColor: Color
    @State var selectedStorkeWidth: Float
    
    //Prevents adding twice a command due to a bug in the color picker
    @State var commitTime = Date.now
    
    let onColorSelected: () -> Void
    
    var body: some View
    {
        //TODO: Decople the view of the undoredosystem, as of now the redoundo stack call the execute method to make it but because of that you cant preview it, specially the stroke width
        VStack
        {
            HStack
            {
                ColorPicker("Fill color", selection: $selectedFillColor,
                            supportsOpacity: false)
                .padding()
                .onChange(of: selectedFillColor)
                {
                    color in
                    
                    //Need a variable to use timeIntervalSince method
                    let now = Date.now
                    
                    //Only save the changes done within a second of the last one
                    if(now.timeIntervalSince(commitTime) > 0.1)
                    {
                        //Create an empty command list
                        var Commands : [Command] = []
                        
                        //Add a individual command for each selected layer
                        vm.selectedPathIndices.forEach
                        {
                            currentIndex in
                            
                            Commands.append(ChangeFillColorCommand(selectedItem: $vm.paths[currentIndex],
                                                                   previousColor:vm.paths[currentIndex].fill,
                                                                   currentColor: selectedFillColor))
                        }
                        
                        //Add the command to the stack
                        vm.UndoRedoStack.invoke(commands: Commands)
                        
                        commitTime = Date.now
                    }
                }
                
                ColorPicker("Stroke color", selection: $selectedStrokeColor,
                            supportsOpacity: false)
                .padding()
                .onChange(of: selectedStrokeColor)
                {
                    color in
                    
                    //Need a variable to use timeIntervalSince method
                    let now = Date.now
                    
                    //Only save the changes done within a second of the last one
                    if(now.timeIntervalSince(commitTime) > 0.1)
                    {
                        //Create an empty command list
                        var Commands : [Command] = []
                        
                        //Add a individual command for each selected layer
                        vm.selectedPathIndices.forEach
                        {
                            currentIndex in
                            
                            Commands.append(ChangeStrokeColorCommand(selectedItem: $vm.paths[currentIndex],
                                                                     previousColor: vm.paths[currentIndex].stroke,
                                                                     currentColor: selectedStrokeColor))
                            print(vm.paths[currentIndex].stroke)
                            print(selectedStrokeColor)
                        }
                        //Add the command to the stack
                        vm.UndoRedoStack.invoke(commands: Commands)
                        
                        commitTime = Date.now
                    }
                }
            }
            .padding()
            
            
            Slider(value: $selectedStorkeWidth, in: 0.0...10.0, onEditingChanged: {_ in
                //Need a variable to use timeIntervalSince method
                let now = Date.now
                
                //Only save the changes done within a second of the last one
                if(now.timeIntervalSince(commitTime) > 0.1)
                {
                    
                    //Create an empty command list
                    var Commands : [Command] = []
                    //Add a individual command for each selected layer
                    vm.selectedPathIndices.forEach { currentIndex in
                        Commands.append(ChangeStrokeWithCommand(selectedItem: $vm.paths[currentIndex],
                                                                previousWidth: vm.paths[currentIndex].strokeWidth,
                                                                currentWidth: selectedStorkeWidth))
                    }
                    //Add the command to the stack
                    vm.UndoRedoStack.invoke(commands: Commands)
                    
                    commitTime = Date.now
                }}) {
                Text("Stroke Width")
            }
        }
        
    }
    
}






