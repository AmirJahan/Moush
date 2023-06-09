import SwiftUI
import PocketSVG

class ViewModel: ObservableObject
{
    
    
    @Published
    var paths: [PathModel] = []
    
    @Published
    var selectedPathIndices: [Int] = []
    
    @Published
    var selectedPathFill: Color = .clear
    
    @Published
    var selectedPathStroke: Color = .clear
    
    
    
    func toggleSelectedPathIndex(_ index: Int) {
        if index >= 0 && index < paths.count {
            paths[index].selected.toggle()  //toggle the selected state
            
            if paths[index].selected {
                let boundingBox = paths[index].path.boundingRect
                let insetBoundingBox = boundingBox.insetBy(dx: -5, dy: -5)
                let boundsPath = Path(insetBoundingBox)
                paths[index].boundingBox = boundsPath // Store the bounding box path in the model
            } else {
                paths[index].boundingBox = nil // Clear the bounding box path
            }
            
            if let existingIndex = selectedPathIndices.firstIndex(of: index) {
                selectedPathIndices.remove(at: existingIndex)
            } else {
                selectedPathIndices.append(index)
            }
        }
    }
    
    func updateSelectedPathColors(newFillColor: Color, newStrokeColor: Color)
    {
        for(_, pathIndex) in selectedPathIndices.enumerated() {
            paths[pathIndex].fill = newFillColor
            paths[pathIndex].stroke = newStrokeColor
        }
    }
    
    init(resourceName: String)
    {
        
        let localUrl = Bundle.main.url(forResource: resourceName, withExtension: "svg")!
        
        let cgPaths: [SVGBezierPath] = SVGBezierPath.pathsFromSVG(at: localUrl)
        
        
        //        dump(cgPaths[0].svgAttributes)
        
        //        if let fill = cgPaths[0].svgAttributes["fill"]
        //        {
        //            let f = fill as! CGColor
        //            print ("stroke-width: \(f )")
        //        }
        
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
                                 strokeWidth: 2.5,
                                 strokeStyle: StrokeStyle())
            
            paths.append(path)
        }
    }
}
