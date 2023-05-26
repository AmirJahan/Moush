// Define the Command protocol
import SwiftUI

// struct to create shapes
struct SquareShape: Shape, Hashable {
    var color : Color
    var width : CGFloat
    var height : CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let square = CGRect(x: 0, y: 0, width: width, height: height)
        path.addRect(rect)
        return path
    }
}

// interface, all undoable actions must conform to it
protocol Command {
    func execute()
    func undo()
}

// Define a class for each operation
// This class is made to modify the array of shapes
class AddSquareCommand: Command {
    var reciver : DrawList
    var createdObject : SquareShape

    init(reciverChanged : DrawList, shapeAdded : SquareShape) {
        reciver = reciverChanged
        createdObject = shapeAdded
    }

    func execute() {
        reciver.shapes.append(createdObject)
    }

    func undo() {
        if let index = reciver.shapes.firstIndex(of: createdObject)
        {
            reciver.shapes.remove(at: index)
        }
    }
}

// List of all shapes that should be drawn
// Was made into a class so that it can be passsed by reference
class DrawList : ObservableObject
{
    @Published var shapes : Array<SquareShape> = [
        SquareShape(color: .blue, width: 100, height: 100),
        SquareShape(color: .red, width: 50, height: 50)
    ]
}

class UndoRedoSystem {
    private var undoStack: [Command] = []
    private var redoStack: [Command] = []

    func invoke(command: Command) {
        command.execute()
        undoStack.append(command)
        redoStack.removeAll()
    }

    func undo() {
        guard let command = undoStack.popLast() else { return }
        command.undo()
        redoStack.append(command)
    }

    func redo() {
        guard let command = redoStack.popLast() else { return }
        command.execute()
        undoStack.append(command)
    }
}

struct RedoView: View {
    @State var textAdded = false
    @State var textColor = Color.red
    @State var textSize: CGFloat = 24.0

    private var invoker = UndoRedoSystem()
    @StateObject var shapes = DrawList()


    var body: some View {
        
        ZStack
        {
            ForEach(shapes.shapes, id: \.self) { shape in
                shape
                    .fill(shape.color)
                    .frame(width:shape.width, height: shape.height)
            }
        }
        
        Button("Add") {
            invoker.invoke(command: AddSquareCommand(reciverChanged: shapes, shapeAdded: SquareShape(color: .cyan, width: 100, height: 100)))
            //shapes.shapes.append(SquareShape(color: .cyan, width: 100, height: 100))
        }
        
        Button("Undo")
        {
            invoker.undo()
        }
        
        Button("Redo")
        {
            invoker.redo()
        }
    }
}
