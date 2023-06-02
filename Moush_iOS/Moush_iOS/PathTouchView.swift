
import SwiftUI
import PocketSVG

//TODO: cambiar el contorno de la figura cuando la tocas

struct PathTouchView: View
{
    @State
    var fill: Color = .red
    
    @State
    var fill2: Color = .yellow
    
    var body: some View
    {
        ZStack
        {
            ForEach (StaticData.myPaths.indices, id: \.self) { index in
                
                var myPath = StaticData.myPaths[index]
                
                myPath.path?.fill(myPath.fill)
                    .onTapGesture {
                        StaticData.myPaths[index].stroke = .purple
                        StaticData.myPaths[index].strokeStyle = StrokeStyle(
                            lineWidth: 5,
                            lineCap: .round,
                            lineJoin: .miter,
                            miterLimit: 0,
                            dash: [5, 10],
                            dashPhase: 0
                        )
                    }
                
            }
                
        }

    }
}

struct PathTouchView_Previews: PreviewProvider {
    static var previews: some View {
        PathTouchView()
    }
}
