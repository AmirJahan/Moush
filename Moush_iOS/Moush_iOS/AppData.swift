//
//  AppData.swift
//  Moush_iOS
//
//  Created by The Odd Institute on 2023-05-11.
//

import Foundation
import SwiftUI

class AppData
{
    static let instance = AppData()
    init () { }
    
    
    
    let searchFilter = SearchFilter(name: "Recent", imageName: "arrow.clockwise.circle.fill")
    
    
    
    
    
    
    
    let tempSvgs = Array(repeating: MySvg(image: getRandomImage(),
                                          author: getRandomAuthor(),
                                          tags: getRandomTags(),
                                          rating: getRandomRating()), count: 60)

}
func getRandomImage() -> String {
    // Add code to generate a random image from Apple's SF Library
    let images = ["square.and.arrow.up", "square.and.arrow.up.fill", "square.and.arrow.down", "square.and.arrow.down.fill", "square.and.arrow.up.on.square", "square.and.arrow.up.on.square.fill", "square.and.arrow.down.on.square", "square.and.arrow.down.on.square.fill", "pencil", "pencil.circle", "pencil.circle.fill", "pencil.slash", "square.and.pencil", "rectangle.and.pencil.and.ellipsis", "scribble", "scribble.variable", "highlighter", "pencil.and.outline", "pencil.tip", "pencil.tip.crop.circle", "pencil.tip.crop.circle.badge.plus", "pencil.tip.crop.circle.badge.minus", "pencil.tip.crop.circle.badge.arrow.forward", "lasso", "lasso.sparkles", "trash", "trash.fill", "trash.circle", "trash.circle.fill", "trash.slash"]
    return images.randomElement() ?? ""
}

func getRandomAuthor() -> String {
    // Add code to generate a random author name
    let authors = [
        "John Doe",
        "Jane Smith",
        "Alex Johnson",
        "David Wilson",
        "Emily Brown",
        "Michael Davis",
        "Olivia Taylor",
        "Daniel Anderson",
        "Sophia Clark",
        "Matthew Martinez",
        "Abigail Thompson",
        "Jacob White",
        "Mia Lee",
        "Ethan Lewis",
        "Charlotte Turner",
        "William Walker",
        "Ava Rodriguez",
        "James Green",
        "Isabella Hall",
        "Benjamin Adams",
        "Grace Hill",
        "Alexander Moore",
        "Sofia Brooks",
        "Joseph Wright",
        "Chloe Davis",
        "Daniel Martin",
        "Lily Young",
        "Henry King",
        "Zoe Harris",
        "Samuel Garcia"
    ]

    return authors.randomElement() ?? ""
}

func getRandomTags() -> [String] {
    // Add code to generate a random array of meaningful words
    let tags = [
        "Great", "Red", "Weird",
        "Awesome", "Blue", "Fun",
        "Creative", "Yellow", "Exciting",
        "Amazing", "Green", "Cool",
        "Fantastic", "Purple", "Innovative",
        "Epic", "Orange", "Unique",
        "Excellent", "Pink", "Adventurous",
        "Brilliant", "Teal", "Inspiring",
        "Magical", "Silver", "Mysterious",
        "Spectacular", "Gold", "Energetic",
        "Marvelous", "Cyan", "Vibrant",
        "Wonderful", "Lime", "Playful",
        "Terrific", "Indigo", "Dynamic",
        "Phenomenal", "Amber", "Captivating",
        "Outstanding", "Turquoise", "Imaginative",
        "Impressive", "Magenta", "Whimsical",
        "Stunning", "Sapphire", "Fascinating",
        "Extraordinary", "Ruby", "Enchanting",
        "Astounding", "Emerald", "Mesmerizing",
        "Breathtaking", "Topaz", "Delightful"]

    // Get a random number between 3 and 5
    let randomCount = Int.random(in: 3...5)

    // Shuffle the array
    let shuffledArray = tags.shuffled()

    // Take a random slice of the shuffled array
    let randomTags = Array(shuffledArray.prefix(randomCount))
    
    return randomTags
    
}

func getRandomRating() -> Float {
    // Add code to generate a random floating number between 1 and 5
    return Float.random(in: 1...5)
}

