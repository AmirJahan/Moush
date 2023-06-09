import Foundation
import SwiftUI
import UIKit




struct PathModel
{
    let path: Path?
    var fill: Color
    var stroke: Color?
    let strokeWidth: Float?
    var strokeStyle: StrokeStyle
    
    var visible = true
    var selected: Bool = false
}
