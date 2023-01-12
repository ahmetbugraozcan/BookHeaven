//
//  Formats.swift
//  BookHeaven
//
//  Created by Ahmet Buğra Özcan on 9.01.2023.
//

import Foundation


// MARK: - Formats
/// Book type formats 
struct BHFormats: Codable {
    let textPlain: String?
    let applicationXMobipocketEbook, textHTML: String?
    let applicationOctetStream: String?
    let textPlainCharsetUsASCII: String?
    let applicationEpubZip: String?
    let imageJPEG: String?
    let applicationRDFXML: String?

    enum CodingKeys: String, CodingKey {
        case textPlain = "text/plain"
        case applicationXMobipocketEbook = "application/x-mobipocket-ebook"
        case textHTML = "text/html"
        case applicationOctetStream = "application/octet-stream"
        case textPlainCharsetUsASCII = "text/plain; charset=us-ascii"
        case applicationEpubZip = "application/epub+zip"
        case imageJPEG = "image/jpeg"
        case applicationRDFXML = "application/rdf+xml"
    }
}
