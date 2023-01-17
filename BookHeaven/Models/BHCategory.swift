//
//  BHCategories.swift
//  BookHeaven
//
//  Created by Ahmet Buğra Özcan on 17.01.2023.
//

import Foundation

/// A struct that holds category name and request string. It could be basic string array but maybe i18n can be added in the future so its better i guess.
struct BHCategory{
    let requestString: String
    let displayString: String
}


extension BHCategory {
    static let categories = [
        BHCategory(requestString: "animal", displayString: "Animal"),
        BHCategory(requestString: "children", displayString: "Children"),
        BHCategory(requestString: "classics", displayString: "Classics"),
        BHCategory(requestString: "countries", displayString: "Countries"),
        BHCategory(requestString: "crime", displayString: "Crime"),
        BHCategory(requestString: "education", displayString: "Education"),
        BHCategory(requestString: "fiction", displayString: "Fiction"),
        BHCategory(requestString: "geography", displayString: "Geography"),
        BHCategory(requestString: "history", displayString: "History"),
        BHCategory(requestString: "literature", displayString: "Literature"),
        BHCategory(requestString: "law", displayString: "Law"),
        BHCategory(requestString: "music", displayString: "Music"),
        BHCategory(requestString: "periodicals", displayString: "Periodicals"),
        BHCategory(requestString: "psychology", displayString: "Psychology"),
        BHCategory(requestString: "philosophy", displayString: "Philosophy"),
        BHCategory(requestString: "religion", displayString: "Religion"),
        BHCategory(requestString: "romance", displayString: "Romance"),
        BHCategory(requestString: "science", displayString: "Science"),
    ]
}

