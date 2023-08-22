//
//  Responsable.swift
//  GetYa
//
//  Created by 양승현 on 2023/08/21.
//

import Foundation

protocol Responsable {
    associatedtype ResponseDTO: Decodable
}

enum ResponseType {
    case carRecommendation
    case carRecommendationCustom
    case carSpec
    case carSpecComparison
    case exteriorColor
    case interiorColor
    case trimColor
    case carSpecAdditionalOption(carSpecId: Int)
    case carSpecBasicOptions(carSpecId: Int)
    case optionsActivityLog(optionId: Int)
    case optionsDetails(optionId: Int)
    case packageOptionsActivityLog(optionId: Int)
    case optionPackageDetails(optionId: Int)
    case optionCarSpecIdTagsTagId(carSpecId: Int, tagId: Int)
    
    var path: String {
        switch self {
        case .carRecommendation:
            return "car-recommendation"
        case .carRecommendationCustom:
            return "car-recommendation/custom"
        case .carSpec:
            return "car-spec"
        case .carSpecAdditionalOption(let carSpecId):
            return "car-spec/\(carSpecId)/additional-options"
        case .trimColor:
            return "color/trim-colors"
        default:
            break
        }
        return ""
    }
}
