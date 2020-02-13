//
//  BankCard.swift
//  StripePayment
//
//  Created by kvana_imac11 on 12/02/20.
//  Copyright © 2020 kvana_imac11. All rights reserved.
//

import UIKit
import SwiftyJSON

//MARK: Enums
enum CardType: String {
    case visa = "visa"
    case masterCard = "mastercard"
    case americanExpress = "american express"
    case discover = "discover"
    case dinersClub = "diners club"
    case jcb = "jcb"
}

class BankCard: NSObject {
    
    var cardId:String!
    var cardType:CardType = .visa
    var endingDigits:String!
    var userName:String!
    var expiryMonth:String!
    var expiryYear:String!
    var cardLogo: UIImage!
    var cardToken: String!
    
    required init(json: SwiftyJSON.JSON) {
        
        cardId = json["card_id"].stringValue
        cardType = CardType(rawValue: json["card_type"].stringValue.lowercased())!
        endingDigits = json["ending_digits"].stringValue
        userName = json["name_on_card"].stringValue
        expiryMonth = json["exp_month"].stringValue
        let year = json["exp_year"].stringValue
        year.count > 2 ? (expiryYear = year.substring(from: year.index(year.endIndex, offsetBy: -2))) : (expiryYear = year)
        
        switch cardType {
        case .visa:
            cardLogo = UIImage(named: "visa_logo")
            break
        case .masterCard:
            cardLogo = UIImage(named: "mastercard_logo")
            break
        case .americanExpress:
            cardLogo = UIImage(named: "amex_logo")
            break
        case .discover:
            cardLogo = UIImage(named: "discover_logo")
            break
        case .dinersClub:
            cardLogo = UIImage(named: "diners_logo")
            break
        case .jcb:
            cardLogo = UIImage(named: "jcb_logo")
            break
        }
    }
    
    override init() {
        
    }
    
    class func array(_ cardObjectList:JSON) -> [BankCard] {
        var cardItemsArray = [BankCard]()
        for (_, subJson) in cardObjectList {
            let obj:BankCard = BankCard(json: subJson)
            cardItemsArray.append(obj)
        }
        return cardItemsArray
    }
}

