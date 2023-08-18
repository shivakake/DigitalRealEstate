//
//  RealEstateDataModels.swift
//  RealEstate
//
//  Created by PGK Shiva Kumar on 30/05/23.
//

import Foundation

public struct CategoriesDataModel {
    
    public var title: String?
    public var isSelected: Bool?
    
    public init() { }
    public init(title: String? , isSelected: Bool?) {
        self.title = title
        self.isSelected = isSelected
    }
}

public struct FeaturesDataModel {
    
    public var featureTitle: String?
    public var featureImage: String?
    
    public init() { }
    public init(title: String?, image: String?) {
        self.featureTitle = title
        self.featureImage = image
    }
}

public struct LikedListDataModel {
    
    public var name: String?
    public var profileImage: String?
    public var liked: Bool?
    public var address: String?
    public var sqft: String?
    public var rating: String?
    public var price: String?
    
    public init() { }
    public init(name: String?, profileImage: String?, liked: Bool?, address: String?, sqft: String?, rating: String?, price: String?) {
        self.name = name
        self.profileImage = profileImage
        self.liked = liked
        self.address = address
        self.sqft = sqft
        self.rating = rating
        self.price = price
    }
}

public struct VisitsDetailsDataModel {
    
    public var name: String?
    public var dateAndTime: String?
    public var checked: Bool?
    
    public init() { }
    public init(visitName: String? , visitDateAndTime: String?, checked: Bool?) {
        self.name = visitName
        self.dateAndTime = visitDateAndTime
        self.checked = checked
    }
}

public struct InstallmentDataModel {
    
    public var title: String?
    public var dateTitle: String?
    public var dateDetails: String?
    public var price: String?
    public var paymentStatus: Bool?
    public var outstanding: Bool?
    public var paymentType: String?
    
    public init() { }
    public init(title: String?, dateTitle: String?, dateDetails: String?, price: String?, paymentStatus: Bool?, outstanding: Bool?, paymentType: String?) {
        self.title = title
        self.dateTitle = dateTitle
        self.dateDetails = dateDetails
        self.price = price
        self.paymentStatus = paymentStatus
        self.outstanding = outstanding
        self.paymentType = paymentType
    }
}

/*
 public struct FilterTypeDataModel {
 
 public var filterName : String?
 public var isSelected: Bool?
 
 public init() { }
 public init(filterName: String, isSelected: Bool?) {
 self.filterName = filterName
 self.isSelected = isSelected
 }
 }
 
 
 public struct VisitsMonthsDataModel {
 
 public var month: String?
 public var isSelected: Bool?
 
 public init() { }
 public init(month: String? , isSelected: Bool?) {
 self.month = month
 self.isSelected = isSelected
 }
 }
 */
