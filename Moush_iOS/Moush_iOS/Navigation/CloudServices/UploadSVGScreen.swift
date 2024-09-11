//
//  Uploadvg.swift
//  Moush_iOS
//
//  Created by Navpreet Singh on 2023-05-17.
//

import SwiftUI
import Foundation

struct UploadSvg: View {
    @State private var tags: [String] = []
    @State private var newTag: String = ""

    @State var isShowing = false

    var body: some View {
        NavigationView {
            VStack {
                Spacer()

                // on upload svg open the files folder and upload the file from there
                Button {
                    isShowing.toggle()
                } label: {
                    Text("Upload SVG")
                }.fileImporter(isPresented: $isShowing, allowedContentTypes: [.item]) { result in
                    switch result {
                    case .success(let url):
                        // upload file using the url form the files folder
                        // also, upload the files in a folder in the form of user/img.svg ex-> w123456789/fish.svg in the storage

                        let svgInstance = MySvg(fileName: "changethislater",
                                                thumbName: "",
                                                author: "",
                                                tags: tags,
                                                rating: 3,
                                                uploadDate: Date())

                        Cloud.inst.uploadFile(fileURL: url, svg: svgInstance) { result in
                            switch result {
                            case .success(let downloadURL):
                                print("File uploaded successfully: \(downloadURL)")
                            case .failure(let error):
                                print("An error occurred: \(error)")
                            }
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }

                Text("Tag your SVG!")
                    .font(.title)
                    .padding()

                HStack {
                    TextField("Enter a new tag", text: $newTag)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    Button(action: {
                        if !newTag.isEmpty {
                            tags.append(newTag)
                            newTag = ""
                        }
                    }) {
                        Text("Add")
                    }
                    .padding()
                }

                List {
                    ForEach(tags, id: \.self) { tag in
                        HStack {
                            Text(tag)
                                .font(.headline)
                            Spacer()
                            Button(action: {
                                if let index = tags.firstIndex(of: tag) {
                                    tags.remove(at: index)
                                }
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                        }
                        .padding()
                    }
                    .onDelete(perform: deleteTags)
                }
            }
            .padding()
            .navigationBarTitle("", displayMode: .inline)
        }
    }

    func deleteTags(at offsets: IndexSet) {
        tags.remove(atOffsets: offsets)
    }
}

struct UploadSvg_Previews: PreviewProvider {
    static var previews: some View {
        UploadSvg()
    }
}
