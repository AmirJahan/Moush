import Foundation
import SwiftUI

struct AttributesView: View
{
    @ObservedObject
    var vm: ViewModel
    
    @Binding
    var selectedFillColor: Color
    
    @Binding
    var selectedStrokeColor: Color
    
    let onColorSelected: () -> Void
    
    var body: some View
    {
        VStack
        {
            HStack
            {
                ColorPicker("Fill color", selection: $selectedFillColor,
                            supportsOpacity: false)
                .padding()
                
                ColorPicker("Stroke color", selection:$selectedStrokeColor,
                            supportsOpacity: false)
                .padding()
            }
            .padding()
            
            
//            Slider(value: $vm.paths[vm.selectedPathIndices].strokeWidth, in: 0.0...10.0) {
//                Text("Stroke Width")
//            }
            
            Button {
                onColorSelected()
            } label: {
                Text("Apply")
            }

        }
        
    }
}






