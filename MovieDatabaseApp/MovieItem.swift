//
//  MovieItem.swift
//  MovieDatabaseApp
//
//  Created by Narayana on 30/06/24.
//

import Foundation
struct RatingItem: Codable {
    var source: String?
    var value: String?
    enum CodingKeys:String, CodingKey {
        case source = "Source"
        case value = "Value"
    }
}
struct MovieItem: Codable {
    var title, year, rated, released, runtime, director, writer, actors, plot, language, country, awards, poster, metascore, imdbRating, imdbVotes, imdbID, type, dvd, boxOffice, production, website, response, genre : String?
    var ratings: [RatingItem]?
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case awards = "Awards"
        case poster = "Poster"
        case ratings = "Ratings"
        case metascore = "Metascore"
        case imdbRating
        case imdbVotes
        case imdbID
        case type = "Type"
        case dvd = "DVD"
        case boxOffice = "BoxOffice"
        case production = "Production"
        case website = "Website"
        case response = "Response"
    }
    
}
