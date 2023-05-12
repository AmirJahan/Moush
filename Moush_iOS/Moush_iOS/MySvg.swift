//
//  MySvg.swift
//  Moush_iOS
//
//  Created by The Odd Institute on 2023-05-12.
//

import Foundation


struct MySvg: Identifiable, Hashable // to replace by the one that Nav makes
{
    let id = UUID()
    
    let image: String
    let author: String
    let tags: [String]
    let rating: Float
}
