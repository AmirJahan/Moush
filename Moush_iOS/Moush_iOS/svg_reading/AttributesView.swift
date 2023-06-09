import Foundation
import SwiftUI

struct AttributesView: View
{
    @ObservedObject
    var vm: ViewModel
    
    
    var body: some View
    {
        VStack
        {
            HStack
            {
                ColorPicker("", selection: $vm.paths[vm.selectedPathIndex].fill,
                            supportsOpacity: false)
                .padding()
                
                ColorPicker("", selection:$vm.paths[vm.selectedPathIndex].stroke,
                            supportsOpacity: false)
                .padding()
            }
            .padding()
            
            
            Slider(value: $vm.paths[vm.selectedPathIndex].strokeWidth, in: 0.0...10.0) {
                Text("Stroke Width")
            }
            
            
        }
        
    }
}






