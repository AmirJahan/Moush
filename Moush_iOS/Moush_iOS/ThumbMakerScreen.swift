//
//  ThumbMakerScreen.swift
//  Moush_iOS
//
//  Created by Amir Jahanlou on 2023-10-04.
//

import SwiftUI


struct ThumbMakerScreen: View
{
    var rectangle: some View
    {
        Rectangle()
            .fill(.red)
            .frame(width: 200, height: 200)
    }

    var body: some View
    {
        ZStack
        {
            rectangle
                .onTapGesture {
                    
              
                    if let data = body.asImage.pngData()
                {
                        // send to firebase instead of writing locally
                    let filename = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("capture.png")
                    try? data.write(to: filename)
                    print("Image saved to: \(filename)")
                }
            }
            
            Rectangle()
                .fill(.blue)
                .frame(width: 150, height: 150)
        }
    }


    
}


extension View
{
    var asImage: UIImage
    {
        let controller = UIHostingController(rootView: self.edgesIgnoringSafeArea(.top))
        let view = controller.view
        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: CGPoint(x: 0, y: 0), size: targetSize)
        view?.backgroundColor = .clear

        let format = UIGraphicsImageRendererFormat()
        format.scale = 3 // Ensures 3x-scale images. You can customise this however you like.
        let renderer = UIGraphicsImageRenderer(size: targetSize, format: format)
        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}


struct ThumbMakerScreen_Previews: PreviewProvider {
    static var previews: some View {
        ThumbMakerScreen()
    }
}
