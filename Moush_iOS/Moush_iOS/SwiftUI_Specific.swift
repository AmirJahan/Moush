
import SwiftUI

struct SwiftUI_Specific: View
{
    @State private var string: String = "Dumble Dore!"
    
    var body: some View {
        
        CustomTextFieldView(titleKey: "Enter your text here ...", dropIndex: 7, string: $string)
        
    }
    
}




struct CustomTextFieldView: View {
    
    let titleKey: LocalizedStringKey
    let dropIndex: Int
    @Binding var string: String
    
    var body: some View {
        
        HStack(spacing: 0.0) {
            
            Text(string.dropLast((string.count >= dropIndex) ? (string.count - dropIndex) : 0)).foregroundColor(Color(UIColor.darkGray)).lineLimit(1)
            
            Text(string.dropFirst(dropIndex)).foregroundColor(Color(UIColor.lightGray)).lineLimit(1)
            
            Spacer()
        }
        .overlay(TextField(titleKey, text: $string).foregroundColor(.clear), alignment: .topLeading)
        
    }    
}

struct SwiftUI_Specific_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUI_Specific()
    }
}
