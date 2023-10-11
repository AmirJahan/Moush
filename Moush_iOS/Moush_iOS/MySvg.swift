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
    init(fileName: String, thumbName: String, author: String, tags: [String], rating: Float, uploadDate: Date, filePath: String? = nil) {
        self.fileName = fileName
        self.thumbName = thumbName
        self.author = author
        self.tags = tags
        self.rating = rating
        self.uploadDate = uploadDate
        self.filePath = filePath
    }
    
    // Another initializer without filePath
    init(fileName: String, thumbName: String, author: String, tags: [String], uploadDate: Date, rating: Float)
    {
        self.init(fileName: fileName, thumbName: thumbName, author: author, tags: tags, rating: rating, uploadDate: uploadDate, filePath: nil)
    }
}
