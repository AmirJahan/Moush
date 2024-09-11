import SwiftUI

struct SvgLayersView: View {
    @ObservedObject
    var vm: ViewModel

    var body: some View {
        List {
            ForEach(vm.paths.indices, id: \.self) { i in
                LayerCellView(pathModel: $vm.paths[i])
                    .listRowSeparatorTint(.black)
                    .listRowInsets(EdgeInsets())
                    .onTapGesture {
                        vm.toggleSelectedPathIndex(i)
                    }
            }
        }
    }
}

struct SvgLayersView_Previews: PreviewProvider {
    static var previews: some View {
        SvgLayersView(vm: ViewModel(svgName: "sample_01"))
    }
}
