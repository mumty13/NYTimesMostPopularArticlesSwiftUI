import Foundation

// MARK: - MPArticlesResponse
struct MPArticlesResponse: Codable, Hashable {
    let status, copyright: String?
    let numResults: Int?
    let results: [Article]?

    enum CodingKeys: String, CodingKey {
        case status, copyright
        case numResults = "num_results"
        case results
    }
}

// MARK: - Article
struct Article: Codable, Hashable {
    let uri: String?
    let url: String?
    let id, assetID: Int?
    let source: Source?
    let publishedDate, updated, section, subsection: String?
    let nytdsection, adxKeywords: String?
    let column: String?
    let byline: String?
    let type: ResultType?
    let title, abstract: String?
    let desFacet, orgFacet, perFacet, geoFacet: [String]?
    let media: [Media]?
    let etaID: Int?

    enum CodingKeys: String, CodingKey {
        case uri, url, id
        case assetID = "asset_id"
        case source
        case publishedDate = "published_date"
        case updated, section, subsection, nytdsection
        case adxKeywords = "adx_keywords"
        case column, byline, type, title, abstract
        case desFacet = "des_facet"
        case orgFacet = "org_facet"
        case perFacet = "per_facet"
        case geoFacet = "geo_facet"
        case media
        case etaID = "eta_id"
    }
}

// MARK: - Media
struct Media: Codable, Hashable {
    let type: MediaType?
    let subtype: Subtype?
    let caption, copyright: String?
    let approvedForSyndication: Int?
    let mediaMetadata: [MediaMetadatum]?

    enum CodingKeys: String, CodingKey {
        case type, subtype, caption, copyright
        case approvedForSyndication = "approved_for_syndication"
        case mediaMetadata = "media-metadata"
    }
}

// MARK: - MediaMetadatum
struct MediaMetadatum: Codable, Hashable {
    let url: String?
    let format: Format?
    let height, width: Int?
}

enum Format: String, Codable, Hashable {
    case mediumThreeByTwo210 = "mediumThreeByTwo210"
    case mediumThreeByTwo440 = "mediumThreeByTwo440"
    case standardThumbnail = "Standard Thumbnail"
}

enum Subtype: String, Codable, Hashable {
    case empty = ""
    case photo = "photo"
}

enum MediaType: String, Codable, Hashable {
    case image = "image"
}

enum Source: String, Codable, Hashable {
    case newYorkTimes = "New York Times"
}

enum ResultType: String, Codable, Hashable {
    case article = "Article"
    case interactive = "Interactive"
}
