//
//  UndoRedoClasses.swift
//  Moush_iOS
//
//  Created by Carlos Astengo Macias on 2023-06-09.
//

import Foundation
import SwiftUI

class ChangeFillColorCommand: Command {
    //Made the variables Binding to pass by reference
    var SelectedItem: Binding<PathModel>
    var PreviousColor: Color
    var CurrentColor: Color

    init(selectedItem: Binding<PathModel>, previousColor: Color, currentColor: Color) {
        SelectedItem = selectedItem
        PreviousColor = previousColor
        CurrentColor = currentColor
    }

    func execute() {
        SelectedItem.wrappedValue.fill = CurrentColor
    }

    func undo() {
        SelectedItem.wrappedValue.fill = PreviousColor
    }
}

class ChangeStrokeColorCommand: Command {
    //Made the variables Binding to pass by reference
    var SelectedItem: Binding<PathModel>
    var PreviousColor: Color
    var CurrentColor: Color

    init(selectedItem: Binding<PathModel>, previousColor: Color, currentColor: Color) {
        SelectedItem = selectedItem
        PreviousColor = previousColor
        CurrentColor = currentColor
    }

    func execute() {
        SelectedItem.wrappedValue.stroke = CurrentColor
    }

    func undo() {
        SelectedItem.wrappedValue.stroke = PreviousColor
    }
}

class ChangeStrokeWithCommand: Command {
    //Made the variables Binding to pass by reference
    var SelectedItem: Binding<PathModel>
    var PreviousWidth: Float
    var CurrentWidth: Float

    init(selectedItem: Binding<PathModel>, previousWidth: Float, currentWidth: Float) {
        SelectedItem = selectedItem
        PreviousWidth = previousWidth
        CurrentWidth = currentWidth
    }

    func execute() {
        SelectedItem.wrappedValue.strokeWidth = CurrentWidth
    }

    func undo() {
        SelectedItem.wrappedValue.strokeWidth = PreviousWidth
    }
}
