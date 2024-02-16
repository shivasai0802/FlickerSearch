//
//  FlickerData.swift
//  FlickerSearch
//
//  Created by shiva on 2/15/24.
//

import Foundation

struct FlickerData: Codable, Hashable {
    var title: String
    var link: String
    var description: String
    var modified: String
    var generator: String
    var items: [Item]
}

struct Item: Codable, Hashable {
    var title: String
    var link: String
    var media: Media
    var date_taken: String
    var description: String
    var published: String
    var author: String
    var author_id: String
    var tags: String
}

struct Media: Codable, Hashable {
    var m: String
}


public func getFormattedDate(input: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    if let date = dateFormatter.date(from: input) {
        return date.formatted(date: .abbreviated, time: .complete)
    }
    return "Unable to format given Date"
}
