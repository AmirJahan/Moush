import SwiftUI
import PocketSVG

class ViewModel: ObservableObject
{
    @Published
    var paths: [PathModel] = []
    
    @Published
    var selectedPathIndex: Int = -1

    
    init ()
    {
        readFromLocalUrlAndConverToArrayOfPaths()
    }
    
    func setSelectedPathIndex(_ index: Int) {
        selectedPathIndex = index
    }
    
    func readFromLocalUrlAndConverToArrayOfPaths ()
    {
        let localUrl = Bundle.main.url(forResource: "sample_01", withExtension: "svg")!
        
        let cgPaths: [SVGBezierPath] = SVGBezierPath.pathsFromSVG(at: localUrl)
        
        
        dump(cgPaths[0].svgAttributes)
        
        if let fill = cgPaths[0].svgAttributes["fill"]
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
            
            let path = PathModel(path: Path( cgP.cgPath),
                                 fill: Color(myFill ?? UIColor.black.cgColor),
                                 stroke: Color(myStroke ?? UIColor.clear.cgColor),
                                 strokeWidth: 2.5)
            
            paths.append(path)
        }
    }
}
