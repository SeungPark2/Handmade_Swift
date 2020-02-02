//
//  ServiceData.swift
//  Handmade_Swift
//
//  Created by PST on 2020/01/29.
//  Copyright © 2020 PST. All rights reserved.
//

import Foundation

struct ServiceData: Codable {
    
    let resultCount: Int
    let results: [ServiceList]
}

struct ServiceList: Codable {
    
    var screenshotUrls: [String]
       var ipadScreenshotUrls: [String]
       var appletvScreenshotUrls: [String]
       
       var isGameCenterEnabled: Bool
       
       var artworkUrl512: String
       var artworkUrl100: String
       var artistViewUrl: String
       
       var supportedDevices: [String]
       
       var advisories: [String]
       var kind: String
       var features: [String]
       var trackCensoredName: String
       
       var languageCodesISO2A: [String]
       var fileSizeBytes: String
       var sellerUrl: String?
       
       var averageUserRatingForCurrentVersion: Float?
       var userRatingCountForCurrentVersion: Int?
       
       var trackViewUrl: String
       var trackContentRating: String
       var contentAdvisoryRating: String
       var minimumOsVersion: String
       var releaseNotes: String?
       
       var isVppDeviceBasedLicensingEnabled: Bool
       
       var primaryGenreName: String
       var genreIds: [String]
       var primaryGenreId: Int
       var formattedPrice: String
       var trackName: String
       var trackId: Int
       
       var currentVersionReleaseDate: String
       var releaseDate: String
       var sellerName: String
       var currency: String
       var version: String
       var wrapperType: String
       
       var artistId: Int
       var artistName: String
       var genres: [String]
       var price: Float
       var description: String
       
       var bundleId: String
       var averageUserRating: Float?
       var userRatingCount: Int?

}
