import SwiftUI
import PocketSVG
import Foundation
import UIKit

struct AmazonPath
{
    let path: Path?
    let fill: Color?
    let stroke: Color?
    let strokeWidth: Float?
    
    var visible = true
}

struct SwiftUI_SVG: View
{
    
    @StateObject
    var vm = ViewModel()
    
    var body: some View
    {
        VStack
        {
            ZStack {
                ForEach(vm.paths.indices, id: \.self) { index in
                    
                    let thisPath = vm.paths[index]
                    
                    if thisPath.visible {
                        
                        if let f = thisPath.fill {
                            thisPath.path?.fill(f)
                        }
                        
                        if let s = thisPath.stroke,
                           let sw = thisPath.strokeWidth
                        {
                            thisPath.path?.stroke (s, lineWidth: CGFloat(sw))
                        }
                    }
                }
            }
            
            
            
            Button {
                vm.paths[0].visible.toggle()
            } label: {
                Text("Hide")
            }
        }
    }
}


class ViewModel: ObservableObject
{
    
    @Published
    var paths: [AmazonPath] = []
        
    init ()
    {
        readFromLocalUrlAndConverToArrayOfPaths()
    }
    
    func readFromLocalUrlAndConverToArrayOfPaths ()
    {
        let localUrl = Bundle.main.url(forResource: "amazon", withExtension: "svg")!
        
        let cgPaths: [SVGBezierPath] = SVGBezierPath.pathsFromSVG(at: localUrl)
        
        if let fill = cgPaths[0].svgAttributes["stroke-width"]
        {
            let f = fill as! CGColor
            print ("stroke-width: \(f )")
        }
        
        // clear the array
        paths = []
        
        for cgP in cgPaths
        {
            var myFill: CGColor?
            
            if let fill = cgP.svgAttributes["fill"]
            {
                myFill = (fill as! CGColor)
            }
            
            var myStroke: CGColor?
            
            if let stroke = cgP.svgAttributes["stroke"]
            {
                myStroke = (stroke as! CGColor)
            }
            
            let amazonPath = AmazonPath(path: Path( cgP.cgPath),
                                        fill: Color(myFill ?? UIColor.black.cgColor),
                                        stroke: Color(myStroke ?? UIColor.clear.cgColor),
                                        strokeWidth: 2.5)
            
            paths.append(amazonPath)
        }
    }
}


struct SwiftUI_SVG_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUI_SVG()
    }
}

