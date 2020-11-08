//
//  moviesModel.swift
//  MovieBuzz
//
//  Created by GOQii-Subhojit on 07/11/20.
//  Copyright © 2020 SpcaeTown-Subhojit. All rights reserved.
//

import UIKit
import ObjectMapper

class MovieResponseModel :NSObject, Mappable {
    public var total_pages: Int? = 0
    public var total_results: Int? = 0
    public var result: [MoviesModel]? = []
    public var page: Int? = 0
    
    required init?(map: Map) {
        result = [MoviesModel(map: map)!]
    }
    
    func mapping(map: Map) {
        total_pages             <- map["total_pages"]
        total_results              <- map["total_results"]
        result               <- map["results"]
        page             <- map["page"]
    }
}

class MoviesModel: Mappable {
    
    public var id : Int? = 0
    public var video : Bool? = false
    public var vote_count : Int? = 0
    public var vote_average : Double? = 0.0
    public var title : String? = ""
    public var release_date : String? = ""
    public var original_language : String? = ""
    public var original_title : String? = ""
    public var genre_ids : [Int] = []
    public var backdrop_path : String? = ""
    public var adult : Bool? = false
    public var overview : String? = ""
    public var poster_path : String? = ""
    public var popularity : Double? = 0.0
    public var media_type : String? = ""
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id             <- map["id"]
        video              <- map["video"]
        vote_count               <- map["vote_count"]
        vote_average             <- map["vote_average"]
        title              <- map["title"]
        release_date               <- map["release_date"]
        original_language             <- map["original_language"]
        original_title              <- map["original_title"]
        genre_ids               <- map["genre_ids"]
        backdrop_path             <- map["backdrop_path"]
        adult              <- map["adult"]
        overview               <- map["overview"]
        poster_path            <- map["poster_path"]
        popularity             <- map["popularity"]
        media_type              <- map["media_type"]
        
    }

}
