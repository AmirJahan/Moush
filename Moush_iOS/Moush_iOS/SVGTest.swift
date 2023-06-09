import SwiftUI
import PocketSVG
import Foundation
import UIKit

struct SwiftUI_SVG: View
{
    @StateObject
    var vm = ViewModel()
    
    var body: some View
    {
        VStack
        {
            ZStack
            {
                ForEach(vm.paths.indices, id: \.self) { index in
                    let thisPath = vm.paths[index]
                    
                    if thisPath.visible
                    {
                        if let f = thisPath.fill,
                           let path = thisPath.path
                        {
                            path.fill(f)
                                .onTapGesture {
                                    vm.setSelectedPathIndex(index)
                                }
                        }
                        
                        if let s = thisPath.stroke,
                           let sw = thisPath.strokeWidth,
                           let path = thisPath.path {
                            path.stroke(s, lineWidth: CGFloat(sw))
                                .onTapGesture {
                                    vm.setSelectedPathIndex(index)
                                }
                        }
                    }
                }
            }
            
            //ListView(vm: vm)
        }
    }
}

struct ListView: View {
    @ObservedObject var vm: ViewModel

    var body: some View {
        List {
            ForEach(vm.paths.indices, id: \.self) { i in
                PathCellView(path: $vm.paths[i])
                    .listRowSeparatorTint(.black)
                    .listRowInsets(EdgeInsets())
                    .onTapGesture {
                        vm.setSelectedPathIndex(i)
                    }
            }
        }
    }
}


class ViewModel: ObservableObject
{
    
    @Published
    var paths: [PathModel] = []
    @Published
    var selectedPathIndex: Int? = nil
    
    
    init ()
    {
        readFromLocalUrlAndConverToArrayOfPaths()
    }
    
    func setSelectedPathIndex(_ index: Int) {
        if index >= 0 && index < paths.count {
            paths[index].selected.toggle() // Toggle the selected state
            if paths[index].selected {
                paths[index].strokeStyle = StrokeStyle(lineWidth: 4, dash: [5, 5], dashPhase: 0)
            } else {
                paths[index].strokeStyle = StrokeStyle() // Restore default stroke style
            }
        }
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
            
            let path = PathModel(path: Path( cgP.cgPath),
                                 fill: Color(myFill ?? UIColor.black.cgColor),
                                 stroke: Color(myStroke ?? UIColor.clear.cgColor),
                                 strokeWidth: 2.5,
                                 strokeStyle: StrokeStyle(
                                    lineWidth: 5,
                                    lineCap: .round,
                                    lineJoin: .miter,
                                    miterLimit: 0,
                                    dash: [5, 10],
                                    dashPhase: 0
                                ))
            
            paths.append(path)
        }
    }
}


struct SwiftUI_SVG_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUI_SVG()
    }
}

