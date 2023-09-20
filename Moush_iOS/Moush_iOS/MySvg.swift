import Foundation


struct MySvg: Identifiable, Hashable // to replace by the one that Nav makes
{
    let id = UUID()
    let fileName: String
    let thumbName: String
    let author: String
    let tags: [String]
    let rating: Float
    let uploadDate: Date
}
