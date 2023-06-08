import SwiftUI

struct ArtCellView: View
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
        ZStack
        {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.2),
                        radius: 4,
                        x: 0,
                        y: 2)
            
            VStack (alignment: .leading)
            {
                Image (systemName: svg.image)
                    .font(.system(size: 96))
//                    .background(Color.myPrimaryColor)
                
                Text (svg.author)
                    .font(.headline)
                
                
                HStack
                {
                    Text (svgTagsString())
                        .font(.subheadline)
                }
                
                StarRatingView(rating: svg.rating)
            }.padding()
        }
//        .frame(width: 200, height: 300)
        .padding()
    
    }
}


struct StarRatingView: View {
    let rating: Float
    
    var body: some View {
        HStack(spacing: 5) {
            ForEach(0..<5) { index in
                Image(systemName: index < Int(rating) ? "star.fill" : "star")
                    .foregroundColor(index < Int(rating) ? .yellow : .gray)
            }
        }
    }
}

struct SvgCellView_Previews: PreviewProvider {
    static var previews: some View {
        ArtCellView(svg: AppData.instance.tempSvgs.randomElement()!)
    }
}
