//
//  Teachers.swift
//  iOSTraining
//
//  Created by FDC-LOURDES-NC-WEB on 7/18/25.
//

import Foundation

struct TeachersResponse: Codable {
    let teachers: [Teacher]
}

// MARK: - Teacher
struct Teacher: Identifiable, Codable {
    let id, teacherChildID: Int?
    let name, nameEng: String?
    let status, teacherReserveCoin: Int?
    let rating, kidsRating: Double?
    let lessons, goods, nationalityID: Int?
    let countryName: String?
    let nativeSpeakerFlg, suitableForChildrenFlg: Int?
    let callanDiscountFlg, favorite: Bool?
    let beginnerTeacherFlg, freeTalkFlg: Int?
    let imageMain: String?
    let residenceInfo: String?
    let residenceImage: String?
    let residenceName, countryInfo: String?
    let countryImage, kidsUICountryImage: String?
    let nativeNowFlg: Int?
    let messageIntroduction, message, messageEng, youtubeTag: String?
    var favoriteCount: Int?
    let coinMin, coinMax, avatarType: Int?
    let avatarFlg, age, evaluationCount, counselingFlg: Int?
    let teacherLampDelay, notificationFlg, teacherTextbookRating, textbookLessonCount: Int?
    let textbookReserveCount: Int?
    let sapuriCoin, favoriteColor: JSONNull?
    let avatarShortMessage: String?
    let customerSupportFlg, birthdayShowFlg, allowShowDetails: Int?
    let avatarImage: String?
    let backgroundColor, shadowColor, strokeColor: String?

    //my local
    var isFavorite: Bool = false
    //var localFavoriteCount: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case teacherChildID = "teacher_child_id"
        case name
        case nameEng = "name_eng"
        case status
        case teacherReserveCoin = "teacher_reserve_coin"
        case rating
        case kidsRating = "kids_rating"
        case lessons, goods, favorite
        case nationalityID = "nationality_id"
        case countryName = "country_name"
        case nativeSpeakerFlg = "native_speaker_flg"
        case suitableForChildrenFlg = "suitable_for_children_flg"
        case callanDiscountFlg = "callan_discount_flg"
        case beginnerTeacherFlg = "beginner_teacher_flg"
        case freeTalkFlg = "free_talk_flg"
        case imageMain = "image_main"
        case residenceInfo = "residence_info"
        case residenceImage = "residence_image"
        case residenceName = "residence_name"
        case countryInfo = "country_info"
        case countryImage = "country_image"
        case kidsUICountryImage = "kids_ui_country_image"
        case nativeNowFlg = "native_now_flg"
        case messageIntroduction = "message_introduction"
        case message
        case messageEng = "message_eng"
        case youtubeTag = "youtube_tag"
        case favoriteCount = "favorite_count"
        case coinMin = "coin_min"
        case coinMax = "coin_max"
        case avatarType = "avatar_type"
        case avatarFlg = "avatar_flg"
        case age
        case evaluationCount = "evaluation_count"
        case counselingFlg = "counseling_flg"
        case teacherLampDelay = "teacher_lamp_delay"
        case notificationFlg = "notification_flg"
        case teacherTextbookRating = "teacher_textbook_rating"
        case textbookLessonCount = "textbook_lesson_count"
        case textbookReserveCount = "textbook_reserve_count"
        case sapuriCoin = "sapuri_coin"
        case favoriteColor = "favorite_color"
        case avatarShortMessage = "avatar_short_message"
        case customerSupportFlg = "customer_support_flg"
        case birthdayShowFlg = "birthday_show_flg"
        case allowShowDetails = "allow_show_details"
        case avatarImage = "avatar_image"
        case backgroundColor = "background_color"
        case shadowColor = "shadow_color"
        case strokeColor = "stroke_color"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

