import SwiftUI

// test
struct HomeScreen: View {
    init() {
        setupNavBar()
    }
    
    // Replace the userName with actual current Cloud user ID:
    let userName = "Jane Smith";
    
    @State
    var searchFilter: SearchFilter = AppData.instance.searchFilter
    
    @State private var filteredSvgs: [MySvg] = AppData.instance.tempSvgs
    
    @State
    private var searchText = ""
    
    @State
    var showSearchFilter = false
    
    @State
    var showImportSettings = false;
    
    let screenWidth = UIScreen.main.bounds.size.width - 20
    
    let space: CGFloat = 8
    
    var colHeight: CGFloat {
        return screenWidth / 2.0 * 1.25
    }
    
    //    var cellWidth: CGFont {
    //        return (screenWidth - 20.0) / 2.0
    //    }
    
    var columns : [GridItem] {
        return Array(repeating: .init(.flexible(),
                                      spacing: space),
                     count: 2)
    }
    
    let countries = ["🇨🇦", "🇩🇿", "🇦🇲", "🇦🇷", "🇧🇹", "🇧🇮", "🇮🇨", "🇰🇲"]
    
    @State private var svgs: [MySvg] = []
    
    @State var img: UIImage?
    
    var body: some View {
        
        NavigationView {
            ZStack {
                // usually you put a grid within a Scroll View
                ScrollView {
                    VStack {
                        HStack {
                            SearchBar(text: $searchText, onSearch: performSearch)
                            
                            // This is the settings menu.
                            Button(action: {
                                self.showSearchFilter.toggle()
                                // performSearch();
                            }) {
                                Image(systemName: "slider.horizontal.3")
                                    .imageScale(.large)
                                    .foregroundColor(.blue)
                            }
                        }
                        .onChange(of: showSearchFilter) { newValue in
                            performSearch()
                            
                        }
                        
                        Spacer()
                        
                        LazyVGrid(
                            columns: columns,
                            spacing: space
                        ) {
                            ForEach(filteredSvgs, id: \.self) { mySvg in
                                NavigationLink {
                                    ArtDisplayScreen(svg: mySvg)
                                } label: {
                                    ArtCellView(svg: mySvg)
                                }
                            }
                            .padding(.top, 8)
                                VStack {
                                    if let img = img {
                                        Image(uiImage: img)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                    } else {
                                        ProgressView()  // show a loading spinner while the image is loading
                                    }
                                }
                                .onAppear(perform: {
                                    
                                    // THIS IS HARDCODED, JUST TO SHOW HOW IT COULD WORK.
                                    // get the file and display that file.
                                    // This should also display the user name and the
                                    Cloud.inst.fetchImage(fromPath: "Svgs/acvarium.jpg")
                                    { (data, error) in
                                        if let error = error {
                                            print("Error downloading file: \(error)")
                                        } else if let data = data {
                                            self.img = UIImage(data: data)
                                        }
                                    }
                                })
                                
                                ForEach (svgs, id: \.self) { mySvg in
                               // ForEach(AppData.instance.tempSvgs, id: \.self) { mySvg in
                                    NavigationLink {
                                        
                                        //                                    Text("HI")
                                        ArtDisplayScreen(svg: mySvg)
                                        
                                    } label: {
                                        ArtCellView(svg: mySvg)
                                    }
                                }
                            }.padding(.top, 8)
                        }.padding(16)
                        
                    }  //
                    .navigationBarTitle("", displayMode: .large)
                    .navigationBarItems(
                        
                        leading:
                            
                            VStack(alignment: .leading) {
                                Text("Moush")
                                    .font(.custom("HelveticaNeue-Bold", size: 34))
                                    .foregroundColor(.white)
                                    .padding(.top, 24)
                                Text("The Ultimate SVG Editor")
                                    .font(.custom("HelveticaNeue-Italic", size: 16))
                                    .foregroundColor(.white.opacity(0.75))
                                    .padding(.top, 0)
                                
                            },
                        trailing:
                            VStack(alignment: .trailing) {
                                // This is the one at the top.
                                Button(action: {
                                    self.showSearchFilter.toggle()
                                    performSearch()
                                }) {
                                    Image(systemName: "archivebox.fill")
                                        .imageScale(.large)
                                        .foregroundColor(.white.opacity(0.75))
                                }
                                
                            })
                    if self.showImportSettings
                    {
                        ImportView()
                    }
                    
                    // This must always be at the end. This is the Filters view. Overlayed on top of others
                    if self.showSearchFilter {
                        FiltersView(
                            searchFilter: $searchFilter,
                            showSearchFilter: $showSearchFilter,
                            onFilterSelected: performSearch)
                        
                    }
                }
            }.onAppear(perform: loadSvgs)
        }
    
    func loadSvgs() {
        Cloud.inst.fetchPosts { result in
            switch result {
            case .success(let fetchedSvgs):
                self.svgs = fetchedSvgs
            case .failure(let error):
                print("Error fetching SVGs: \(error)")
            }
        }
    }
    
    func performSearch() {
        print("called")
        if searchText.isEmpty {
            // If the search text is empty, show all SVGs and reset the location
            filteredSvgs = AppData.instance.tempSvgs
        } else {
            // Filter the SVGs based on the search text
            filteredSvgs = AppData.instance.tempSvgs.filter { mySvg in
                let lowercaseSearchText = searchText.lowercased()
                return mySvg.fileName.lowercased().contains(lowercaseSearchText) ||
                mySvg.author.lowercased().contains(lowercaseSearchText) ||
                mySvg.tags.contains { tag in
                    tag.lowercased().contains(lowercaseSearchText)
                }
            }
        }
        
        // Sort by rating if the "Popular" filter is selected
        if searchFilter.name == "Popular" {
            filteredSvgs.sort { $0.rating > $1.rating }
        } else if searchFilter.name == "Recent" {
            filteredSvgs.sort { $0.uploadDate > $1.uploadDate }
        } else if searchFilter.name == "My Files" {
            // Replace "YourUserName" with the actual user name
            filteredSvgs = filteredSvgs.filter { $0.author == userName }
        } else if searchFilter.name == "Default" {
            filteredSvgs = AppData.instance.tempSvgs.filter { mySvg in
                let lowercaseSearchText = searchText.lowercased()
                return mySvg.fileName.lowercased().contains(lowercaseSearchText) ||
                mySvg.author.lowercased().contains(lowercaseSearchText) ||
                mySvg.tags.contains { tag in
                    tag.lowercased().contains(lowercaseSearchText)
                }
            }
        }
        
        print(searchFilter.name)
    }
    
    struct SearchBar: View {
        @Binding var text: String
        var onSearch: () -> Void
        
        var body: some View {
            ZStack {
                TextField("Search", text: $text)
                    .frame(maxWidth: .infinity)
                    .textFieldStyle(.roundedBorder)
                    .onChange(of: text) { newValue in
                        onSearch() // Call the onSearch function whenever the text changes
                    }
                
                if !text.isEmpty {
                    Button(action: {
                        text = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.secondary)
                            .opacity(text.isEmpty ? 0 : 1)
                    }
                    .padding(.trailing, 8) // Adjust the padding as needed
                }
            }
        }
    }
}

    extension HomeScreen {
      func setupNavBar() {
        // Customize the appearance of the navigation bar
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(Color.myPrimaryColor)
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]  // Customize the large title text color

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
      }
    }

    struct HomeScreen_Previews: PreviewProvider {
      static var previews: some View {
        HomeScreen()
      }
    }
        
        struct FiltersView: View {
            @Binding
            var searchFilter: SearchFilter
            
            @Binding
            var showSearchFilter: Bool
            
            var onFilterSelected: () -> Void
            
            var body: some View {
                VStack {
                    HStack {
                        Spacer()
                        FilterPopOverView(
                            searchFilter: $searchFilter,
                            showSearchFilter: $showSearchFilter,
                            onFilterSelected: {
                                onFilterSelected()
                                print("Filter tapped")
                            }
                        )
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white)
                                .shadow(
                                    color: .black.opacity(0.2),
                                    radius: 5,
                                    x: -3,
                                    y: 3
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(
                                            .gray.opacity(0.25),
                                            lineWidth: 2))
                        )
                        .padding()
                    }.padding(.top, 64)
                    Spacer()
                }
            }
        }
