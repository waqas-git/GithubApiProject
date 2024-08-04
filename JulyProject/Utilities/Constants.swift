//
//  Constants.swift
//  JulyProject
//
//  Created by waqas ahmed on 03/08/2024.
//

import UIKit

enum Images{
    static let gh_Logo = UIImage(named: "gh-logo")
    static let avatar_placeholder = UIImage(named: "avatar-placeholder")
    static let empty_state_logo = UIImage(named:"empty-state-logo")
}

enum ScreenSize {
    static let width        = UIScreen.main.bounds.size.width
    static let height       = UIScreen.main.bounds.size.height
    static let maxLength    = max(ScreenSize.width, ScreenSize.height)
    static let minLength    = min(ScreenSize.width, ScreenSize.height)
}

enum DeviceTypes {
    static let idiom                    = UIDevice.current.userInterfaceIdiom
    static let nativeScale              = UIScreen.main.nativeScale
    static let scale                    = UIScreen.main.scale

    static let isiPhoneSE               = idiom == .phone && ScreenSize.maxLength == 568.0
    static let isiPhone8Standard        = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale == scale
    static let isiPhone8Zoomed          = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale > scale
    static let isiPhone8PlusStandard    = idiom == .phone && ScreenSize.maxLength == 736.0
    static let isiPhone8PlusZoomed      = idiom == .phone && ScreenSize.maxLength == 736.0 && nativeScale < scale
    static let isiPhoneX                = idiom == .phone && ScreenSize.maxLength == 812.0
    static let isiPhoneXsMaxAndXr       = idiom == .phone && ScreenSize.maxLength == 896.0

    // Newer iPhone models
    static let isiPhone12Mini           = idiom == .phone && ScreenSize.maxLength == 812.0 && nativeScale == 3.0
    static let isiPhone12And12Pro       = idiom == .phone && ScreenSize.maxLength == 844.0
    static let isiPhone12ProMax         = idiom == .phone && ScreenSize.maxLength == 926.0
    static let isiPhone13Mini           = idiom == .phone && ScreenSize.maxLength == 812.0 && nativeScale == 3.0
    static let isiPhone13And13Pro       = idiom == .phone && ScreenSize.maxLength == 844.0
    static let isiPhone13ProMax         = idiom == .phone && ScreenSize.maxLength == 926.0
    static let isiPhone14               = idiom == .phone && ScreenSize.maxLength == 844.0
    static let isiPhone14Plus           = idiom == .phone && ScreenSize.maxLength == 926.0
    static let isiPhone14Pro            = idiom == .phone && ScreenSize.maxLength == 844.0 && nativeScale == 3.0
    static let isiPhone14ProMax         = idiom == .phone && ScreenSize.maxLength == 926.0 && nativeScale == 3.0
    static let isiPhone15               = idiom == .phone && ScreenSize.maxLength == 844.0 && nativeScale == 2.0
    static let isiPhone15Plus           = idiom == .phone && ScreenSize.maxLength == 926.0 && nativeScale == 2.0
    static let isiPhone15Pro            = idiom == .phone && ScreenSize.maxLength == 844.0 && nativeScale == 3.0
    static let isiPhone15ProMax         = idiom == .phone && ScreenSize.maxLength == 926.0 && nativeScale == 3.0

    static let isiPad                   = idiom == .pad && ScreenSize.maxLength >= 1024.0

    static func isiPhoneXAspectRatio() -> Bool {
        return isiPhoneX || isiPhoneXsMaxAndXr || isiPhone12Mini || isiPhone13Mini || isiPhone12And12Pro || isiPhone12ProMax || isiPhone13And13Pro || isiPhone13ProMax || isiPhone14 || isiPhone14Plus || isiPhone14Pro || isiPhone14ProMax || isiPhone15 || isiPhone15Plus || isiPhone15Pro || isiPhone15ProMax
    }
}
