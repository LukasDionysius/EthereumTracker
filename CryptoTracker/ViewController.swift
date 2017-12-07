//
//  ViewController.swift
//  CryptoTracker
//
//  Created by Lukas Michaels on 12/6/17.
//  Copyright © 2017 Lukas Michaels. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var lowLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Currency formatter
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        ///
        priceLabel.text = "..."
        highLabel.text = "..."
        lowLabel.text = "..."

        
        // Calling API using Alamofire and putting it in dictionaries
        Alamofire.request("https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC&tsyms=USD").responseJSON { response in
            print(response)
    
            if let bitcoinJSON = response.result.value {
                let bitcoinObject:Dictionary = bitcoinJSON as! Dictionary<String, Any>
                
                // Parse through information
                let rawObject:Dictionary = bitcoinObject["RAW"] as! Dictionary<String, Any>
                let usdObject:Dictionary = rawObject["BTC"] as! Dictionary<String, Any>
                let btcObject:Dictionary = usdObject["USD"] as! Dictionary<String, Any>
                
                // Current price
                let rate:NSNumber = btcObject["PRICE"] as! NSNumber
                    let rateCurrency = (formatter.string(from: rate)!)
                // High day price
                let highDay:NSNumber = btcObject["HIGH24HOUR"] as! NSNumber
                    let highDayCurrency = (formatter.string(from: highDay)!)
                // Low day price
                let lowDay:NSNumber = btcObject["LOW24HOUR"] as! NSNumber
                    let lowDayCurrency =  (formatter.string(from: lowDay)!)
                
                
                // Changing UI
                self.priceLabel.text = "\(rateCurrency)" // Current price
                self.highLabel.text = "\(highDayCurrency)"
                self.lowLabel.text = "\(lowDayCurrency)"
            }
            
            
            
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

