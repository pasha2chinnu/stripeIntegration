//
//  AddCardController.swift
//  StripePayment
//
//  Created by kvana_imac11 on 12/02/20.
//  Copyright © 2020 kvana_imac11. All rights reserved.
//

import UIKit
import Stripe

class GGTextField: UITextField {
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 4.0
        
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.size.width - 10, height: bounds.size.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.size.width - 10, height: bounds.size.height)
    }
}

class AddCardController: UIViewController {

    @IBOutlet var cardNumberTextField: UITextField!
    @IBOutlet var nameTextField: GGTextField!
    @IBOutlet var cvvTextField: GGTextField!
    @IBOutlet var expireMonthTextField: GGTextField!
    @IBOutlet var expireYearTextField: GGTextField!
    
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var saveButton: UIButton!
    
    var cardData: BankCard?
    var cardTypeImageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cancelButton.layer.cornerRadius = 4.0
        saveButton.layer.cornerRadius = 4.0
        
        let leftView = UIView(frame: CGRect(x: 0, y:10, width:60, height:30))
        cardTypeImageView = UIImageView(frame: CGRect(x: 10, y:3, width:40, height:24))
        cardTypeImageView?.image = cardData?.cardLogo
        leftView.addSubview(cardTypeImageView!)
        cardNumberTextField.leftView = leftView
        cardNumberTextField.leftViewMode = .always
        cardNumberTextField.layer.borderColor = UIColor.gray.cgColor
        cardNumberTextField.layer.borderWidth = 1.0
        cardNumberTextField.layer.cornerRadius = 4.0
        
        let brand = STPCardValidator.brand(forNumber: "")
        cardTypeImageView?.image = STPImageLibrary.brandImage(for: brand)
        
        if cardData != nil {
            
            cardNumberTextField.text = "xxxx xxxx xxxx  " + (cardData?.endingDigits)!
            cardNumberTextField.isUserInteractionEnabled = false
            cardNumberTextField.textColor = UIColor.lightGray
            nameTextField.text = cardData?.userName
            expireMonthTextField.text = cardData?.expiryMonth
            expireYearTextField.text = cardData?.expiryYear
            cardTypeImageView?.image = cardData?.cardLogo
            cvvTextField.isHidden = true
//            cvvTitleLabel.isHidden = true
        }
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveCardButtonAction(_ sender: Any) {
//        if (cardNumberTextField.text?.characters.count)! > 0 && (expireYearTextField.text?.characters.count)! > 0 && (expireMonthTextField.text?.characters.count)! > 0 && (nameTextField.text?.characters.count)! > 0 {
            
            if cardData != nil {
                
                editExistingCard()
                
            } else {
                
//                if (cvvTextField.text?.characters.count)! > 0 {
                    
                    let validationStateMonth:STPCardValidationState = STPCardValidator.validationState(forExpirationMonth: expireMonthTextField.text!)
                    let validationStateYear:STPCardValidationState = STPCardValidator.validationState(forExpirationYear: expireYearTextField.text!, inMonth: expireMonthTextField.text!)
                    let brand = STPCardValidator.brand(forNumber: cardNumberTextField.text!)
                    let validationCVC = STPCardValidator.validationState(forCVC: cvvTextField.text!, cardBrand: brand)
                    
                    if (validationStateMonth == STPCardValidationState.valid) && (validationStateYear == STPCardValidationState.valid) && (validationCVC == STPCardValidationState.valid) {
                        
//                        SVProgressHUD.show()
                        
                        let cardParams = STPCardParams()
                        cardParams.number = cardNumberTextField.text
                        cardParams.expMonth = UInt(expireMonthTextField.text!)!
                        cardParams.expYear = UInt(expireYearTextField.text!)!
                        cardParams.cvc = cvvTextField.text
                        cardParams.name = nameTextField.text
                        
                        STPAPIClient.shared().createToken(withCard: cardParams) { (token: STPToken?, error: Error?) in
                            guard let token = token, error == nil else {
                                // Present error to user...
//                                SVProgressHUD.dismiss()
//                                Helper.showAlert(withtTitle: "", withMessage: NSLocalizedString("unknown_error", comment: ""), inView: self)
                                return
                            }
                            
                            self.submitTokenToBackend(token: token, completion: { (error: Error?) in
                                if let error = error {
//                                    SVProgressHUD.dismiss()
//                                    Helper.showAlert(withtTitle: "", withMessage: NSLocalizedString("invalid_card", comment: ""), inView: self)
                                }
                            })
                        }
                    } else {
//                        Helper.showAlert(withtTitle: NSLocalizedString("invalid_details", comment: ""), withMessage: NSLocalizedString("invalid_content_body", comment: ""), inView: self)
                    }
//                }else {
//                    Helper.showAlert(withtTitle: NSLocalizedString("incomplete_details", comment: ""), withMessage: NSLocalizedString("fill_all_fields", comment: ""), inView: self)
//                }
            }
//        } else {
//            Helper.showAlert(withtTitle: NSLocalizedString("incomplete_details", comment: ""), withMessage: NSLocalizedString("fill_all_fields", comment: ""), inView: self)
//        }
        }
    
    
    func editExistingCard() {
        
//        SVProgressHUD.show()
        
        cardData?.userName = nameTextField.text
        cardData?.expiryMonth = expireMonthTextField.text!
        cardData?.expiryYear = expireYearTextField.text
        
//        WebServices.editCard(cardData!, success: {
//            SVProgressHUD.dismiss()
//            self.showSuccessAlert()
//
//        }) { (errorMsg) in
//            SVProgressHUD.dismiss()
//            Helper.showAlert(withtTitle: NSLocalizedString("title_error", comment: ""), withMessage: errorMsg, inView: self)
//        }
    }
    
    
    
    //MARK: Private Functions
    func submitTokenToBackend(token: STPToken, completion: @escaping ((Error)->())) {
        
//        print("Stripe Token : \(token)")
//        print("Stripe Token : \(token.tokenId)")
//
//        WebServices.addNewCard(token.tokenId, success: {
//            SVProgressHUD.dismiss()
//            self.showSuccessAlert()
//
//        }) { (errorMsg) in
//            SVProgressHUD.dismiss()
//            Helper.showAlert(withtTitle: NSLocalizedString("title_error", comment: ""), withMessage: errorMsg, inView: self)
//        }
    }

}
