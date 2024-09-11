import Foundation
import SwiftUI
import UIKit

struct PathModel {
    let path: Path
    var fill: Color
    var stroke: Color
    var strokeWidth: Float
    var strokeStyle: StrokeStyle
    var boundingBox: Path?

    var visible = true
    var selected: Bool = false
}
