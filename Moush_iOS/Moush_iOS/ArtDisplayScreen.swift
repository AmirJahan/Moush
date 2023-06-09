import SwiftUI

struct ArtDisplayScreen: View
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
       
            
            VStack
            {
                

                
                
//                Text("Detail View")
//                    .navigationBarTitle("Detail", displayMode: .inline)
//                    .navigationBarBackButtonHidden(true)
//                    .navigationBarHidden(false)
                
                
                //
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
                        if let imageURL = Bundle.main.url(forResource: svg.fileName, withExtension: "jpg"),
                                   let imageData = try? Data(contentsOf: imageURL),
                           let uiImage = UIImage(data: imageData) {
                            // Create an Image view with the loaded image
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                        
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
                
                
                
                UserRatingView()
                
                Spacer ()
                
                
                
                
                NavigationLink {
                    EditSvgScreen(svgName: svg.fileName)
                } label: {
                    
                    
                    
                    
                    Text ("Edit this Art")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.myPrimaryColor)
                    .cornerRadius(12)
                }
                

                
            }
            .navigationBarTitle("", displayMode: .inline)

        
    
    }
}




struct UserRatingView: View {
    @State private var rating: Int = 0

    var body: some View {
        VStack {
            Text("Rate this Art")
                .font(.title)
                .padding()

            HStack {
                ForEach(1...5, id: \.self) { index in
                    Image(systemName: index <= rating ? "star.fill" : "star")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.yellow)
                        .onTapGesture {
                            rating = index
                        }
                }
            }
            .padding()

            Button(action: {
                // Save the rating
                saveRating()
            }) {
                Text("Save Rating")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
        }
    }

    func saveRating() {
        // Perform save rating logic here
        print("Rating saved: \(rating)")
    }
}


struct SvgDisplayScreen_Previews: PreviewProvider {
    static var previews: some View {
        ArtDisplayScreen(svg: AppData.instance.tempSvgs.randomElement()!)
    }
}
