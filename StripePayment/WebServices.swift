//
//  WebServices.swift
//  StripePayment
//
//  Created by kvana_imac11 on 12/02/20.
//  Copyright © 2020 kvana_imac11. All rights reserved.
//

import UIKit



//class func editCard(_ cardDetails:BankCard, success:@escaping (()->()), failure: @escaping ((String)->())) {
       
//       let parameters: Parameters = [
//           "card_id": cardDetails.cardId,
//           "exp_month": cardDetails.expiryMonth,
//           "exp_year": cardDetails.expiryYear,
//           "name": cardDetails.userName]
//
//       print("Edit card parameters: \(parameters)")
//
//       let urlString = WSEndPoint.edit_card.urlString()
//       print("Edit card URL: \(urlString)")
//       UIApplication.shared.isNetworkActivityIndicatorVisible = true
//
//       Alamofire.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: self.commonHeaders()).responseJSON { (response:DataResponse<Any>) in
//           UIApplication.shared.isNetworkActivityIndicatorVisible = false
//           switch(response.result) {
//           case .success(_):
//               print("Edit card response \(response.result.value ?? "Default")")
//               if let value = response.result.value {
//                   let json = JSON(value)
//                   if json["statusCode"].intValue == ResponseCode.code_request_success {
//                       success()
//                   }
//                   else {
//                       failure(json["message"].stringValue)
//                   }
//               }
//           case .failure(let error):
//               print("Edit card error \(error)")
//               failure(error.localizedDescription)
//           }
//       }
//   }
