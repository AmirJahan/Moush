import Foundation

struct MySvg: Identifiable, Hashable
{
    let id = UUID()
    let fileName: String
    let thumbName: String
    let author: String
    let tags: [String]
    let rating: Float
    let uploadDate: Date
    var filePath: String?
    
    // The main initializer that includes all properties
    init(fileName: String, thumbName: String, author: String, tags: [String], rating: Float, filePath: String? = nil) {
        self.fileName = fileName
        self.thumbName = thumbName
        self.author = author
        self.tags = tags
        self.rating = rating
        self.filePath = filePath
    }
    
    // Another initializer without filePath
    init(fileName: String, thumbName: String, author: String, tags: [String], rating: Float)
    {
        self.init(fileName: fileName, thumbName: thumbName, author: author, tags: tags, rating: rating, filePath: nil)
    }
}
