import SwiftUI
import PocketSVG

struct PathTouchView: View {
    @StateObject var vm = TouchViewModel()
    @State private var isEditingColor = false
    
    var body: some View {
        HStack {
            ZStack {
                ForEach(vm.paths.indices, id: \.self) { index in
                    let myPath = vm.paths[index]
                    
                    if let path = myPath.path {
                        Group {
                            path.stroke(myPath.stroke!, style: myPath.strokeStyle)
                            path.fill(myPath.fill)
                        }
                        .onTapGesture {
                            vm.toggleSelectedPathIndex(index)
                        }
                    }
                }
            }
            
            Button {
                isEditingColor = true
            } label: {
                Text("Change color")
            }
            
        }
        //.sheet(isPresented: $isEditingColor) {
          //  if let selectedPathIndices = vm.selectedPathIndices {
            //    ColorEditorView(selectedColor: $vm.getSelectedPathColors) { newColor in
              //      vm.updateSelectedPathColors(newColor)
                //}
            //}
        //}
    }
}

class TouchViewModel: ObservableObject {
    @Published var paths: [PathModel] = []
    @Published var selectedPathIndices: [Int] = []

    init() {
        // Initialize paths data
        let yellowPath = PathModel(path: createYellowPath(), fill: .yellow, stroke: .yellow, strokeWidth: 0.2, strokeStyle: StrokeStyle())
        let blackPath = PathModel(path: createBlackPath(), fill: .black, stroke: .black, strokeWidth: 0.2, strokeStyle: StrokeStyle())

        paths = [yellowPath, blackPath]
    }

    func toggleSelectedPathIndex(_ index: Int) {
        if index >= 0 && index < paths.count {
            paths[index].selected.toggle() // Toggle the selected state
            if paths[index].selected {
                paths[index].strokeStyle = StrokeStyle(lineWidth: 4, dash: [5, 5], dashPhase: 0)
            } else {
                paths[index].strokeStyle = StrokeStyle() // Restore default stroke style
            }
            if selectedPathIndices.contains(index) {
                selectedPathIndices.remove(at: index)
            } else {
                selectedPathIndices.append(index)
            }
        }
        
        print(selectedPathIndices)
    }

    func isPathSelected(_ index: Int) -> Bool {
        return selectedPathIndices.contains(index)
    }

    func getSelectedPathColors() -> [Color] {
        return selectedPathIndices.map { paths[$0].fill }
    }

    func updateSelectedPathColors(_ newColor: Color) {
        let selectedIndices = Array(selectedPathIndices)
        for (_, pathIndex) in selectedIndices.enumerated() {
            paths[pathIndex].fill = newColor
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
