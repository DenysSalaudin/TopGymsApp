//
//  LocationDetailsModel.swift
//  TopGyms
//
//  Created by Denis on 5/25/23.
//

import Foundation

// MARK: - LocationDetails
struct LocationDetails: Codable {
    let htmlAttributions: [String]?
    let result: DetailsResult?
    let status: String?

    enum CodingKeys: String, CodingKey {
        case htmlAttributions = "html_attributions"
        case result, status
    }
}

// MARK: - Result
struct DetailsResult: Codable {
    let addressComponents: [AddressComponent]?
    let adrAddress, businessStatus: String?
    let currentOpeningHours: CurrentOpeningHours?
    let formattedAddress, formattedPhoneNumber: String?
    let geometry: Geometry?
    let icon: String?
    let iconBackgroundColor: String?
    let iconMaskBaseURI: String?
    let internationalPhoneNumber, name: String?
    let openingHours: OpeningHours?
    let photos: [Photo]?
    let placeID: String?
    let plusCode: PlusCode?
    let rating: Double?
    let reference: String?
    let reviews: [Review]?
    let types: [String]?
    let url: String?
    let userRatingsTotal, utcOffset: Int?
    let vicinity: String?
    let website: String?
    let wheelchairAccessibleEntrance: Bool?

    enum CodingKeys: String, CodingKey {
        case addressComponents = "address_components"
        case adrAddress = "adr_address"
        case businessStatus = "business_status"
        case currentOpeningHours = "current_opening_hours"
        case formattedAddress = "formatted_address"
        case formattedPhoneNumber = "formatted_phone_number"
        case geometry, icon
        case iconBackgroundColor = "icon_background_color"
        case iconMaskBaseURI = "icon_mask_base_uri"
        case internationalPhoneNumber = "international_phone_number"
        case name
        case openingHours = "opening_hours"
        case photos
        case placeID = "place_id"
        case plusCode = "plus_code"
        case rating, reference, reviews, types, url
        case userRatingsTotal = "user_ratings_total"
        case utcOffset = "utc_offset"
        case vicinity, website
        case wheelchairAccessibleEntrance = "wheelchair_accessible_entrance"
    }
}

// MARK: - AddressComponent
struct AddressComponent: Codable {
    let longName, shortName: String?
    let types: [String]?

    enum CodingKeys: String, CodingKey {
        case longName = "long_name"
        case shortName = "short_name"
        case types
    }
}

// MARK: - CurrentOpeningHours
struct CurrentOpeningHours: Codable {
    let openNow: Bool?
    let periods: [CurrentOpeningHoursPeriod]?
    let weekdayText: [String]?

    enum CodingKeys: String, CodingKey {
        case openNow = "open_now"
        case periods
        case weekdayText = "weekday_text"
    }
}

// MARK: - CurrentOpeningHoursPeriod
struct CurrentOpeningHoursPeriod: Codable {
    let close, periodOpen: PurpleClose?

    enum CodingKeys: String, CodingKey {
        case close
        case periodOpen = "open"
    }
}

// MARK: - PurpleClose
struct PurpleClose: Codable {
    let date: String?
    let day: Int?
    let time: String?
}

// MARK: - Geometry
struct Geometry2: Codable {
    let location: Location?
    let viewport: Viewport?
}

// MARK: - Location
struct Location2: Codable {
    let lat, lng: Double?
}

// MARK: - Viewport
struct Viewport2: Codable {
    let northeast, southwest: Location?
}

// MARK: - OpeningHours
struct OpeningHours2: Codable {
    let openNow: Bool?
    let periods: [OpeningHoursPeriod]?
    let weekdayText: [String]?

    enum CodingKeys: String, CodingKey {
        case openNow = "open_now"
        case periods
        case weekdayText = "weekday_text"
    }
}

// MARK: - OpeningHoursPeriod
struct OpeningHoursPeriod: Codable {
    let close, periodOpen: FluffyClose?

    enum CodingKeys: String, CodingKey {
        case close
        case periodOpen = "open"
    }
}

// MARK: - FluffyClose
struct FluffyClose: Codable {
    let day: Int?
    let time: String?
}

// MARK: - Photo
struct Photo2: Codable {
    let height: Int?
    let htmlAttributions: [String]?
    let photoReference: String?
    let width: Int?

    enum CodingKeys: String, CodingKey {
        case height
        case htmlAttributions = "html_attributions"
        case photoReference = "photo_reference"
        case width
    }
}

// MARK: - PlusCode
struct PlusCode2: Codable {
    let compoundCode, globalCode: String?

    enum CodingKeys: String, CodingKey {
        case compoundCode = "compound_code"
        case globalCode = "global_code"
    }
}

// MARK: - Review
struct Review: Codable {
    let authorName: String?
    let authorURL: String?
    let language, originalLanguage: String?
    let profilePhotoURL: String?
    let rating: Int?
    let relativeTimeDescription, text: String?
    let time: Int?
    let translated: Bool?

    enum CodingKeys: String, CodingKey {
        case authorName = "author_name"
        case authorURL = "author_url"
        case language
        case originalLanguage = "original_language"
        case profilePhotoURL = "profile_photo_url"
        case rating
        case relativeTimeDescription = "relative_time_description"
        case text, time, translated
    }
}

