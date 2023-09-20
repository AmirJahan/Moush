import SwiftUI

struct FilterPopOverView : View
{
            
    @Binding var searchFilter: SearchFilter
    @Binding var showSearchFilter : Bool
    var onFilterSelected: () -> Void
    
//    var onSearch: () -> Void  // Action closure
    
    var recent = SearchFilter(name: "Recent",
                              imageName: "arrow.clockwise.circle.fill")
    var popular = SearchFilter(name: "Popular",
                               imageName: "star.circle.fill")
    var myFiles = SearchFilter(name: "My Files",
                               imageName: "doc.circle.fill")
    
    var defaultSort = SearchFilter(name: "Default",
                                   imageName: "")

    var body : some View
    {
        VStack(alignment: .leading, spacing: 12)
        {
            FilterButton(searchFilter: $searchFilter,
                         showSearchFilter: $showSearchFilter,
                         filter: recent,
                         onFilterSelected: {})
            .onTapGesture {
                searchFilter = recent
                withAnimation { showSearchFilter.toggle() }
                onFilterSelected()
            }
            Divider()
            
            FilterButton(searchFilter: $searchFilter,
                                     showSearchFilter: $showSearchFilter,
                                     filter: popular,
                         onFilterSelected: {})
                            .onTapGesture {
                                searchFilter = popular
                                withAnimation { showSearchFilter.toggle() }
                                onFilterSelected() // Call the callback when "Popular" is tapped
                            }
            Divider()
            
            FilterButton(searchFilter: $searchFilter,
                         showSearchFilter: $showSearchFilter,
                         filter: myFiles,
                         onFilterSelected: {})
            .onTapGesture {
                searchFilter = myFiles
                withAnimation { showSearchFilter.toggle() }
                onFilterSelected()
            }
        }
        .frame(width: 120)
        .padding(6)
        .padding(.bottom, 0)
    }
}


struct FilterPopOverView_Previews: PreviewProvider {
    static var previews: some View {
        FilterPopOverView(
            searchFilter: .constant(AppData.instance.searchFilter),
            showSearchFilter: .constant(true),
            onFilterSelected: {}
        )
    }
}

struct FilterButton: View
{
    // this is the filter we pass along
    @Binding var searchFilter: SearchFilter
    @Binding var showSearchFilter : Bool
    
    // this is the filter for this view
    var filter : SearchFilter
    
    
    var onFilterSelected: () -> Void
    
    var body: some View {
        Button {
            searchFilter = filter
            withAnimation { showSearchFilter.toggle() }
            onFilterSelected()
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
