import Foundation
import SwiftUI
import PocketSVG

struct SVGView: UIViewRepresentable
{
    func makeUIView(context: Context) -> SVGImageView {
        let url = Bundle.main.url(forResource: "amazon", withExtension: "svg")!
        let svgImageView = SVGImageView.init(contentsOf: url)
        svgImageView.contentMode = .scaleAspectFill
        
        svgImageView.strokeColor = .black
        svgImageView.fillColor = .brown
                
        return svgImageView
    }
    
    func updateUIView(_ uiView: SVGImageView, context: Context) {
        uiView.frame = UIScreen.main.bounds
    }
}

struct SVGView_Previews: PreviewProvider {
    static var previews: some View {
        SVGView()
    }
}
