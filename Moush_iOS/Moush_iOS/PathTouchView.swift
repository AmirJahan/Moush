import SwiftUI
import PocketSVG

struct PathTouchView: View {
    @StateObject var vm = TouchViewModel()
    
    var body: some View {
        ZStack {
            ForEach(vm.paths.indices, id: \.self) { index in
                var myPath = vm.paths[index]
                
                if let path = myPath.path {
                    Group {
                        path.stroke(myPath.stroke!, style: myPath.strokeStyle)
                        path.fill(myPath.fill)
                    }
                    .onTapGesture {
                        vm.setSelectedPathIndex(index)
                    }
                }
            }
        }
    }
}

class TouchViewModel: ObservableObject {
    @Published var paths: [PathModel] = []
    
    init() {
        // Initialize paths data
        let yellowPath = PathModel(path: createYellowPath(), fill: .yellow, stroke: .yellow, strokeWidth: 0.2, strokeStyle: StrokeStyle())
        let blackPath = PathModel(path: createBlackPath(), fill: .black, stroke: .black, strokeWidth: 0.2, strokeStyle: StrokeStyle())
        
        paths = [yellowPath, blackPath]
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
    
    func createYellowPath() -> Path {
        let yellowPath = Path { path in
            path.move(to: CGPoint(x: 50, y: 50))
            path.addLine(to: CGPoint(x: 100, y: 50))
            path.addLine(to: CGPoint(x: 100, y: 100))
            path.addLine(to: CGPoint(x: 50, y: 100))
            path.closeSubpath()
        }
        
        return yellowPath
    }
    
    func createBlackPath() -> Path {
        let blackPath = Path { path in
            path.move(to: CGPoint(x: 150, y: 150))
            path.addLine(to: CGPoint(x: 200, y: 150))
            path.addLine(to: CGPoint(x: 200, y: 200))
            path.addLine(to: CGPoint(x: 150, y: 200))
            path.closeSubpath()
        }
        
        return blackPath
    }
}
