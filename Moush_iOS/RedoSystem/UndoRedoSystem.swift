//
//  UndoRedoSystem.swift
//  Moush_iOS
//
//  Created by Carlos Astengo Macias on 2023-06-02.
//

import Foundation

// interface, all undoable actions must conform to it
protocol Command
{
    func execute()
    func undo()
}

class UndoRedoSystem
{
    private var commandStack : [Command] = []
    private var head : Int = -1

    func invoke(command: Command)
    {
        // needs to erase all commands after the execution
        if(head != commandStack.count - 1)
        {
            commandStack.removeLast(commandStack.count - head - 1)
        }
        if commandStack.count == 20
        {
            commandStack.removeFirst()
            head -= 1
        }
        command.execute()
        commandStack.append(command)
        head += 1
    }

    func undo()
    {
        if(head >= 0)
        {
            commandStack[head].undo()
            head -= 1
        }
    }

    func redo()
    {
        if(head < commandStack.count - 1)
        {
            head += 1
            commandStack[head].execute()
        }
    }
}
