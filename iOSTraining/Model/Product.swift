//
//  Product.swift
//  iOSTraining
//
//  Created by FDC-LOURDES-NC-WEB on 7/11/25.
//

import Foundation

struct ProductResponse: Codable {
    let products: [Product]
    let total: Int?
    let skip: Int?
    let limit: Int?
}

struct Product: Codable,Identifiable {
    let id: Int
    var title: String?
    let description: String?
    let rating: Double?
    let category: String?
    let price : Double?
    let thumbnail : String?
    let images: [String]?
}


//struct Dimensions: Codable {
//    let width: String
//    let height: String
//    let depth: String
//}
//
//struct Meta: Codable {
//    let barcode: Int
//    let qrCode: String
//    let createdAt: String
//    let updatedAt: String
//}
//
//struct Review: Codable {
//    let reviewerName: String
//    let reviewerEmail: String
//    let rating: Int
//    let comment: String
//    let date: String
//}
