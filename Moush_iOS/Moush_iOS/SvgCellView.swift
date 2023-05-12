//
//  SvgCellView.swift
//  Moush_iOS
//
//  Created by The Odd Institute on 2023-05-12.
//

import SwiftUI


struct SvgCellView: View
{
    var svg: MySvg
    
    
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
        VStack (alignment: .leading)
        {
            Image (systemName: svg.image)
                .font(.system(size: 128))
                .background(Color.myPrimaryColor)
            
            Text (svg.author)
                .font(.title)
            
            
            HStack
            {
                Text (svgTagsString())
                    .font(.subheadline)
            }
            
            
            StarRatingView(rating: svg.rating)
            
        }
        
        
//        Text(animal)
//            .font(.system(size: 50))
//            .frame(maxWidth: .infinity,
//                   minHeight: colHeight)
//            .background(Color.myPrimaryColor)
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
        SvgCellView(svg: AppData.instance.tempSvgs.randomElement()!)
    }
}
