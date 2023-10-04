import SwiftUI
import FirebaseStorage

struct ArtDisplayScreen: View {
    var svg: MySvg
    
    @State private var uiImage: UIImage?
    
    func svgTagsString() -> String {
        var string = ""
        for aTag in svg.tags {
            string += "#\(aTag) "
        }
        
        return String(string.dropLast())
    }
    
    var body: some View
    {
        VStack
        {
            ZStack
            {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.2),
                            radius: 4,
                            x: 0,
                            y: 2)
                
                VStack(alignment: .leading)
                {
                    if let image = uiImage
                    {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    
                    Text(svg.author)
                        .font(.headline)
                    
                    HStack
                    {
                        Text(svgTagsString())
                            .font(.subheadline)
                    }
                    
                    StarRatingView(rating: svg.rating)
                    Text("Uploaded on: \(formattedUploadDate())")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.top, 8)
                }
                .padding()
            }
            .padding()
            
            UserRatingView()
            
            Spacer()
            
            HStack {
                NavigationLink(destination: EditSvgScreen(svgName: svg.filePath!))
                {
                    Text("Edit this Art")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(12)
                }
                
                Button(action: {
                    downloadImage()
                })
                {
                    Text("Download SVG")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                }
                .padding()
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .onAppear(perform: loadSVGFromCloud)
    }
    
    // A helper method to format the upload date nicely
        func formattedUploadDate() -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy" // You can customize the date format as needed
            return dateFormatter.string(from: svg.uploadDate)
        }
    
    func downloadImage()
    {
        if let validPath = svg.filePath
        {
            Cloud.inst.fetchSvg(fromPath: validPath)
            {
                (data, error) in
                
                if let error = error
                {
                    print("Error downloading SVG file: \(error)")
                }
                else if let data = data {
                    Cloud.inst.saveImage(data: data, fileName: "\(svg.fileName).svg")
                }
            }
        } else {
            print("Invalid filePath in svg object")
        }
    }

    
    func loadSVGFromCloud() {
        
        if let path = svg.filePath {
            
            Cloud.inst.fetchSvg(fromPath: path)
            {
                (data, error) in
                
                if let error = error
                {
                    print("Error downloading image from cloud: \(error)")
                }
                else if let data = data, let image = UIImage(data: data)
                {
                    self.uiImage = image
                }
            }
        }
        else
        {
            print ("failed to prouce path")
        }
    }
}


struct UserRatingView: View
{
    @State private var rating: Int = 0

    var body: some View
    {
        VStack
        {
            Text("Rate this Art")
                .font(.title)
                .padding()

            HStack
            {
                ForEach(1...5, id: \.self)
                {
                    index in
                    Image(systemName: index <= rating ? "star.fill" : "star")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.yellow)
                        .onTapGesture
                    {
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

    // TODO !!! -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    func saveRating()
    {
        // Perform save rating logic here
        print("Rating saved: \(rating)")
    }
}


struct SvgDisplayScreen_Previews: PreviewProvider
{
    static var previews: some View
    {
        ArtDisplayScreen(svg: AppData.instance.tempSvgs.randomElement()!)
    }
}
