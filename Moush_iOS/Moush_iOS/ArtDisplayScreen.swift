import SwiftUI
import UIKit

struct ArtDisplayScreen: View {
    var svg: MySvg
    
    func svgTagsString() -> String {
        var string = ""
        for aTag in svg.tags {
            string += "#\(aTag) "
        }
        
        return String(string.dropLast())
    }
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.2),
                            radius: 4,
                            x: 0,
                            y: 2)
                
                VStack(alignment: .leading) {
                    if let imageURL = Bundle.main.url(forResource: svg.fileName, withExtension: "jpg"),
                       let imageData = try? Data(contentsOf: imageURL),
                       let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    
                    Text(svg.author)
                        .font(.headline)
                    
                    HStack {
                        Text(svgTagsString())
                            .font(.subheadline)
                    }
                    
                    StarRatingView(rating: svg.rating)
                }
                .padding()
            }
            .padding()
            
            UserRatingView()
            
            Spacer()
            
            HStack {
                NavigationLink(destination: EditSvgScreen(svgName: svg.fileName)) {
                    Text("Edit this Art")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(12)
                }
                
                Button(action: {
                    downloadImage()
                }) {
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
    }
    
    func downloadImage() {
        // Get the URL of the SVG file in the app bundle
        if let svgURL = Bundle.main.url(forResource: svg.fileName, withExtension: "svg") {
            let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent(svg.fileName).appendingPathExtension("svg")
            
            do {
                // Copy the file to the temp directory
                try FileManager.default.copyItem(at: svgURL, to: tempURL)
                
                // Create a document interaction controller for the SVG file
                let controller = UIDocumentInteractionController(url: tempURL)
                controller.delegate = nil
                
                // Present the Share Sheet
                controller.presentOptionsMenu(from: .zero, in: UIApplication.shared.windows.first { $0.isKeyWindow }!.rootViewController!.view, animated: true)
            } catch {
                print("Error saving the SVG file: \(error)")
            }
        }
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
