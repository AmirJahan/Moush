import SwiftUI

struct FilterPopOverView : View
{
            
    @Binding var searchFilter: SearchFilter
    @Binding var showSearchFilter : Bool
//    var onSearch: () -> Void  // Action closure
    
    var recent = SearchFilter(name: "Recent",
                              imageName: "arrow.clockwise.circle.fill")
    var popular = SearchFilter(name: "Popular",
                               imageName: "star.circle.fill")
    var myFiles = SearchFilter(name: "My Files",
                               imageName: "doc.circle.fill")

    var body : some View
    {
        VStack(alignment: .leading, spacing: 12)
        {
            FilterButton(searchFilter: $searchFilter,
                         showSearchFilter: $showSearchFilter,
                         filter: recent)
            Divider()
            
            FilterButton(searchFilter: $searchFilter,
                         showSearchFilter: $showSearchFilter,
                         filter: popular)
            Divider()
            
            FilterButton(searchFilter: $searchFilter,
                         showSearchFilter: $showSearchFilter,
                         filter: myFiles)
        }
        .frame(width: 120)
        .padding(6)
        .padding(.bottom, 0)
    }
}


struct FilterPopOverView_Previews: PreviewProvider {
    static var previews: some View {
        FilterPopOverView(searchFilter: .constant(AppData.instance.searchFilter),
                          showSearchFilter: .constant(true))
    }
}

struct FilterButton: View
{
    // this is the filter we pass along
    @Binding var searchFilter: SearchFilter
    @Binding var showSearchFilter : Bool
    
    // this is the filter for this view
    var filter : SearchFilter
    
    var body: some View {
        Button {
            searchFilter = filter
            withAnimation { showSearchFilter.toggle() }
        } label: {
            
            HStack(spacing : 15)
            {
                Image(systemName: filter.imageName)
                    .font(.headline)
                    .foregroundColor(.myPrimaryColor)
                Text(filter.name)
                    .foregroundColor(.myPrimaryColor)
            }
        }
    }
}
