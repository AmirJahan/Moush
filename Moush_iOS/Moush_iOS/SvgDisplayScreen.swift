import SwiftUI

struct SvgDisplayScreen: View
{
    var svg: MySvg
//    var cellWidth: CGFont

    
    func svgTagsString () -> String
    {
        var string = ""
        for aTag in svg.tags
        {
            string += "#\(aTag) "
        }
        
        return String (string.dropLast())
    }
    
    
    var body: some View
    {
        
        Text("Detail View")
                    .navigationBarTitle("Detail", displayMode: .inline)
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(false)
                    
        
//
//        ZStack
//        {
//            RoundedRectangle(cornerRadius: 8)
//                .foregroundColor(.white)
//                .shadow(color: .black.opacity(0.2),
//                        radius: 4,
//                        x: 0,
//                        y: 2)
//
//            VStack (alignment: .leading)
//            {
//                Image (systemName: svg.image)
//                    .font(.system(size: 96))
////                    .background(Color.myPrimaryColor)
//
//                Text (svg.author)
//                    .font(.headline)
//
//
//                HStack
//                {
//                    Text (svgTagsString())
//                        .font(.subheadline)
//                }
//
//                StarRatingView(rating: svg.rating)
//            }.padding()
//        }
////        .frame(width: 200, height: 300)
//        .padding()
    
    }
}

struct SvgDisplayScreen_Previews: PreviewProvider {
    static var previews: some View {
        SvgDisplayScreen(svg: AppData.instance.tempSvgs.randomElement()!)
    }
}
