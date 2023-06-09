//
//  UndoRedoClasses.swift
//  Moush_iOS
//
//  Created by Carlos Astengo Macias on 2023-06-09.
//

import Foundation
import SwiftUI

class ChangeFillColorCommand: Command
{
    var SelectedItem : PathModel
    var PreviousColor : Color
    var CurrentColor : Color
    
    init(selectedItem : PathModel, previousColor : Color, currentColor : Color) {
        SelectedItem = selectedItem
        PreviousColor = previousColor
        CurrentColor = currentColor
    }
    
    func execute() {
        SelectedItem.fill = CurrentColor
    }
    
    func undo() {
        SelectedItem.fill = PreviousColor
    }
}

class ChangeStrokeColorCommand: Command
{
    var SelectedItem : PathModel
    var PreviousColor : Color
    var CurrentColor : Color
    
    init(selectedItem : PathModel, previousColor : Color, currentColor : Color) {
        SelectedItem = selectedItem
        PreviousColor = previousColor
        CurrentColor = currentColor
    }
    
    func execute() {
        SelectedItem.stroke = CurrentColor
    }
    
    func undo() {
        SelectedItem.stroke = PreviousColor
    }
}

class ChangeStrokeWithCommand: Command
{
    var SelectedItem : PathModel
    var PreviousWidth : Float
    var CurrentWidth : Float
    
    init(selectedItem : PathModel, previousWidth : Float, currentWidth : Float) {
        SelectedItem = selectedItem
        PreviousWidth = previousWidth
        CurrentWidth = currentWidth
    }
    
    func execute() {
        SelectedItem.strokeWidth = CurrentWidth
    }
    
    func undo() {
        SelectedItem.strokeWidth = PreviousWidth
    }
}
