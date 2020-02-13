//
//  ViewController.swift
//  StripePayment
//
//  Created by kvana_imac11 on 12/02/20.
//  Copyright © 2020 kvana_imac11. All rights reserved.
//

import UIKit
import Stripe

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func stripeAction(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(identifier: "AddCardController") as! AddCardController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

