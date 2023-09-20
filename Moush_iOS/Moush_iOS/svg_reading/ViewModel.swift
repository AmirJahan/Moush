import SwiftUI
import PocketSVG
import FirebaseStorage

class ViewModel: ObservableObject {
    var UndoRedoStack = UndoRedoSystem()
    
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
    
    func updateSelectedPathColors(newFillColor: Color, newStrokeColor: Color) {
        for(_, pathIndex) in selectedPathIndices.enumerated() {
            paths[pathIndex].fill = newFillColor
            paths[pathIndex].stroke = newStrokeColor
        }
    }
    
    init(svgName: String) {
            fetchSVGFromCloud(svgFileName: svgName)
    }
    
    func fetchSVGFromCloud(svgFileName: String) {
        Cloud.inst.fetchFile(fromPath: "\(svgFileName)") { (data, error) in
            if let error = error {
                print("Error downloading SVG file: \(error)")
            } else if let data = data, let svgString = String(data: data, encoding: .utf8) {
                self.parseSVG(svgString: svgString)
            }
        }
    }
    
    func parseSVG(svgString: String) {
        // Parse the SVG string using PocketSVG
        let cgPaths = SVGBezierPath.paths(fromSVGString: svgString)
        
        // clear the array
        paths = []
        
        for cgP in cgPaths {
            var myFill: CGColor?
            
            if let fill = cgP.svgAttributes["fill"] {
                myFill = (fill as! CGColor)
            }
            
            var myStroke: CGColor?
            
            if let stroke = cgP.svgAttributes["stroke"] {
                myStroke = (stroke as! CGColor)
            }
            
            let path = PathModel(path: Path(cgP.cgPath),
                                 fill: Color(myFill ?? UIColor.black.cgColor),
                                 stroke: Color(myStroke ?? UIColor.clear.cgColor),
                                 strokeWidth: 2.5,
                                 strokeStyle: StrokeStyle())
            
            paths.append(path)
        }
    }
}

