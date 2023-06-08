import SwiftUI

import Foundation
import UIKit

struct EditSvgScreen: View
{
    @StateObject
    var vm = ViewModel()
       
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
