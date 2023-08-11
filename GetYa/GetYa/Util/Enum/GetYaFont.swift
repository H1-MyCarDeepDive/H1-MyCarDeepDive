//
//  GetYaFont.swift
//  GetYa
//
//  Created by 양승현 on 2023/08/04.
//

import UIKit

enum GetYaFont: CaseIterable {
    /// 22 pt | 28 lineheight
    case boldHead1
    ///  20 pt | 26 lineheight
    case mediumHead2
    ///  18 pt | 24 lineheight
    case mediumHead3
    ///  16 pt | 22 lineheight
    case mediumHead4
    ///  20 pt | ? lineheight
    case regularHead2
    ///  20 pt | 28 lineheight
    case boldBody1
    ///  20 pt | 28 lineheight
    case mediumBody1
    ///  18pt | 26 lineheight
    case boldBody2
    ///  18 pt | 26 lineheight
    case mediumBody2
    ///  18 pt | 26 lineheight
    case regularBody2
    ///  16 pt | 24 lineheight
    case mediumBody3
    ///  16 pt | 24 lineheight
    case regularBody3
    ///  14 pt | 22 lineheight
    case mediumBody4
    ///  14 pt | 22 lineheight
    case regularBody4
    ///  12 pt | 18 lineheight
    case mediumCaption1
    ///  12 pt | 18 lineheight
    case regularCaption1
  
  var size: CGFloat {
    switch self {
    case .boldHead1:
      return 22
    case .mediumHead2:
        return 20
    case .regularHead2:
      return 20
    case .mediumHead3:
      return 18
    case .mediumHead4:
      return 16
    case .boldBody1:
        return 20
    case .mediumBody1:
      return 20
    case .boldBody2:
        return 18
    case .mediumBody2:
        return 18
    case .regularBody2:
      return 18
    case .mediumBody3:
        return 16
    case .regularBody3:
      return 16
    case .mediumBody4:
        return 14
    case .regularBody4:
      return 14
    case .mediumCaption1:
        return 12
    case .regularCaption1:
      return 12
    }
  }
  
  var kern: CGFloat {
    switch self {
    case .boldHead1:
      return -0.4
    case .mediumHead2:
        return -0.3
    case .mediumHead3:
        return -0.3
    case .mediumHead4:
        return -0.3
    case .regularHead2:
      return -0.3
    case .boldBody1:
        return -0.2
    case .mediumBody1:
        return -0.2
    case .boldBody2:
        return -0.2
    case .mediumBody2:
        return -0.2
    case .regularBody2:
        return -0.2
    case .mediumBody3:
        return -0.2
    case .regularBody3:
        return -0.2
    case .mediumBody4:
        return -0.2
    case .regularBody4:
      return -0.2
    case .mediumCaption1:
        return 0.0
    case .regularCaption1:
      return 0.0
    }
  }
  
  var lineHeight: CGFloat {
    switch self {
    case .boldHead1:
      return 28
    case .mediumHead2:
        return 26
    case .regularHead2:
      return 26
    case .mediumHead3:
      return 24
    case .mediumHead4:
      return 22
    case .boldBody1:
        return 28
    case .mediumBody1:
      return 28
    case .boldBody2:
        return 26
    case .mediumBody2:
        return 26
    case .regularBody2:
      return 26
    case .mediumBody3:
        return 24
    case .regularBody3:
      return 24
    case .mediumBody4:
        return 22
    case .regularBody4:
      return 22
    case .mediumCaption1:
        return 18
    case .regularCaption1:
      return 18
    }
  }
  
  var name: String {
    switch self {
    case .boldHead1:
      return "HyundaiSansHeadKRBold"
    case .mediumHead2:
        return "HyundaiSansHeadKRMedium"
    case .mediumHead3:
        return "HyundaiSansHeadKRMedium"
    case .mediumHead4:
      return "HyundaiSansHeadKRMedium"
    case .regularHead2:
        return "HyundaiSansHeadKRRegular"
    case .boldBody1:
        return "HyundaiSansTextKRBold"
    case .boldBody2:
      return "HyundaiSansTextKRBold"
    case .mediumBody1:
        return "HyundaiSansTextKRMedium"
    case .mediumBody2:
        return "HyundaiSansTextKRMedium"
    case .mediumBody3:
        return "HyundaiSansTextKRMedium"
    case .mediumBody4:
      return "HyundaiSansTextKRMedium"
    case .regularBody2:
        return "HyundaiSansTextKRRegular"
    case .regularBody3:
        return "HyundaiSansTextKRRegular"
    case .regularBody4:
      return "HyundaiSansTextKRRegular"
    case .mediumCaption1:
      return "HyundaiSansTextKRMedium"
    case .regularCaption1:
      return "HyundaiSansTextKRRegular"
    }
  }
    
    var uiFont: UIFont {
        UIFont(name: self.name, size: self.size) ?? .systemFont(ofSize: 16)
    }
}