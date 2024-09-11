//
//  UndoRedoSystem.swift
//  Moush_iOS
//
//  Created by Carlos Astengo Macias on 2023-06-02.
//

import Foundation

// interface, all undoable actions must conform to it
protocol Command {
    func execute()
    func undo()
}

//The commandStack needs to be an array of arrays since now the user has the ability to select various layers and make changes to thems
class UndoRedoSystem {
    var commandStack: [[Command]] = [[]]
    var head: Int = -1

    func invoke(commands: [Command]) {
        // needs to erase all commands after the execution
        if head != commandStack.count - 1 {
            commandStack.removeLast(commandStack.count - head - 1)
        }
        if commandStack.count == 20 {
            commandStack.removeFirst()
            head -= 1
        }
        commands.forEach { currentComand in
            currentComand.execute()
        }
        commandStack.append(commands)
        head += 1
    }

    func undo() {
        if head >= 0 {
            commandStack[head].forEach { currentComand in
                currentComand.undo()
            }
            head -= 1
        }
    }

    func redo() {
        if head < commandStack.count - 1 {
            head += 1
            commandStack[head].forEach { currentComand in
                currentComand.execute()
            }
        }
    }
}
