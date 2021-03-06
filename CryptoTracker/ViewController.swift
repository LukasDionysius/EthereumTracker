//
//  ViewController.swift
//  CryptoTracker
//
//  Created by Lukas Michaels on 12/6/17.
//  Copyright © 2017 Lukas Michaels. All rights reserved.
//

// Video that helps me understand Alamofire:
// https://www.youtube.com/watch?v=4ipvI7zpVg8&t=1226s

import UIKit
import Alamofire


class ViewController: UIViewController {
    
    // Labels that are attached to UI counterparts
    @IBOutlet weak var cryptoLabel: UILabel!
    
    @IBOutlet weak var dayChangeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var lowLabel: UILabel!

    
    
    
    // Global variable
    var currCrypto = ""
    
    /// ***************************************************************
    /// BTC button method
    /// ***************************************************************
    @IBAction func BTCBtn(_ sender: Any) {
        print("BTC refresh pressed")
        
        // The "Refresh" method needs to know what page it's on
        currCrypto = "BTC"
        
        // Currency formatter
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        // Percentage formatter
        let percFormatter = NumberFormatter()
        percFormatter.minimumFractionDigits = 0
        percFormatter.maximumFractionDigits = 2
        
        // Labels
        cryptoLabel.text = "Bitcoin"
        priceLabel.text = "..."
        highLabel.text = "..."
        lowLabel.text = "..."
        dayChangeLabel.text = "..."
        
        // API call using Alamofire
        Alamofire.request("https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC&tsyms=USD").responseJSON { response in
            
            // Put JSON response in dictionary
            if let bitcoinJSON = response.result.value {
                let bitcoinObject:Dictionary = bitcoinJSON as! Dictionary<String, Any>
                
                // Parse through information
                let rawObject:Dictionary = bitcoinObject["RAW"] as! Dictionary<String, Any>
                let usdObject:Dictionary = rawObject["BTC"] as! Dictionary<String, Any>
                let btcObject:Dictionary = usdObject["USD"] as! Dictionary<String, Any>
                
                // Current price
                let rate:NSNumber = btcObject["PRICE"] as! NSNumber
                let rateCurrency = (formatter.string(from: rate)!)
                // Day change
                let dayChange:NSNumber = btcObject["CHANGE24HOUR"] as! NSNumber
                let dayChangeCurrency = (formatter.string(from: dayChange)!)
                // Day change percentage
                let dayChangePerc:NSNumber = btcObject["CHANGEPCT24HOUR"] as! NSNumber
                let dayChangePercPercentage = (percFormatter.string(from: dayChangePerc)!)
                // High day price
                let highDay:NSNumber = btcObject["HIGH24HOUR"] as! NSNumber
                let highDayCurrency = (formatter.string(from: highDay)!)
                // Low day price
                let lowDay:NSNumber = btcObject["LOW24HOUR"] as! NSNumber
                let lowDayCurrency =  (formatter.string(from: lowDay)!)
                
                // Changing UI
                self.priceLabel.text = "\(rateCurrency)" // Current price
                self.dayChangeLabel.text = "\(dayChangeCurrency)  (\(dayChangePercPercentage)%)"
                self.highLabel.text = "\(highDayCurrency)"
                self.lowLabel.text = "\(lowDayCurrency)"
                
                print("BTC refresh succeed")
            }
        }
    }
    
    /// ***************************************************************
    /// ETH button method
    /// ***************************************************************
    @IBAction func ETHBtn(_ sender: Any) {
        print("ETH refresh pressed")
        
        // The "Refresh" method needs to know what page it's on
        currCrypto = "ETH"
        
        // Currency formatter
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        // Percentage formatter
        let percFormatter = NumberFormatter()
        percFormatter.minimumFractionDigits = 0
        percFormatter.maximumFractionDigits = 2
        
        // Labels
        cryptoLabel.text = "Ethereum"
        priceLabel.text = "..."
        highLabel.text = "..."
        lowLabel.text = "..."
        dayChangeLabel.text = "..."
        
        // API call using Alamofire
        Alamofire.request("https://min-api.cryptocompare.com/data/pricemultifull?fsyms=ETH&tsyms=USD").responseJSON { response in
            
            if let bitcoinJSON = response.result.value {
                let bitcoinObject:Dictionary = bitcoinJSON as! Dictionary<String, Any>
                
                // Parse through information
                let rawObject:Dictionary = bitcoinObject["RAW"] as! Dictionary<String, Any>
                let usdObject:Dictionary = rawObject["ETH"] as! Dictionary<String, Any>
                let btcObject:Dictionary = usdObject["USD"] as! Dictionary<String, Any>
                
                // Current price
                let rate:NSNumber = btcObject["PRICE"] as! NSNumber
                let rateCurrency = (formatter.string(from: rate)!)
                // Day change
                let dayChange:NSNumber = btcObject["CHANGE24HOUR"] as! NSNumber
                let dayChangeCurrency = (formatter.string(from: dayChange)!)
                // Day change percentage
                let dayChangePerc:NSNumber = btcObject["CHANGEPCT24HOUR"] as! NSNumber
                let dayChangePercPercentage = (percFormatter.string(from: dayChangePerc)!)
                // High day price
                let highDay:NSNumber = btcObject["HIGH24HOUR"] as! NSNumber
                let highDayCurrency = (formatter.string(from: highDay)!)
                // Low day price
                let lowDay:NSNumber = btcObject["LOW24HOUR"] as! NSNumber
                let lowDayCurrency =  (formatter.string(from: lowDay)!)
                
                // Changing UI
                self.priceLabel.text = "\(rateCurrency)" // Current price
                self.dayChangeLabel.text = "\(dayChangeCurrency)  (\(dayChangePercPercentage)%)"
                self.highLabel.text = "\(highDayCurrency)"
                self.lowLabel.text = "\(lowDayCurrency)"
                
                print("ETH refresh succeed")
            }
        }
    }
    
    /// ***************************************************************
    /// Refresh button method
    /// ***************************************************************
    @IBAction func refreshBtn(_ sender: Any) {

        print("Refresh pressed")
        
        // Currency formatter
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        // Percentage formatter
        let percFormatter = NumberFormatter()
        percFormatter.minimumFractionDigits = 0
        percFormatter.maximumFractionDigits = 2
        
        // Labels
        priceLabel.text = "..."
        highLabel.text = "..."
        lowLabel.text = "..."
        dayChangeLabel.text = "..."
    
        // Check to see if the refresh button is being pressed on BTC or ETH page
        if self.currCrypto == "BTC" || self.currCrypto == "" {
            // API call for Bitcoin
            Alamofire.request("https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC&tsyms=USD").responseJSON { response in
                if let bitcoinJSON = response.result.value {
                    let bitcoinObject:Dictionary = bitcoinJSON as! Dictionary<String, Any>
                    
                    // Parse through information
                    let rawObject:Dictionary = bitcoinObject["RAW"] as! Dictionary<String, Any>
                    let usdObject:Dictionary = rawObject["BTC"] as! Dictionary<String, Any>
                    let btcObject:Dictionary = usdObject["USD"] as! Dictionary<String, Any>
                    
                    // Current price
                    let rate:NSNumber = btcObject["PRICE"] as! NSNumber
                    let rateCurrency = (formatter.string(from: rate)!)
                    // Day change
                    let dayChange:NSNumber = btcObject["CHANGE24HOUR"] as! NSNumber
                    let dayChangeCurrency = (formatter.string(from: dayChange)!)
                    // Day change percentage
                    let dayChangePerc:NSNumber = btcObject["CHANGEPCT24HOUR"] as! NSNumber
                    let dayChangePercPercentage = (percFormatter.string(from: dayChangePerc)!)
                    // High day price
                    let highDay:NSNumber = btcObject["HIGH24HOUR"] as! NSNumber
                    let highDayCurrency = (formatter.string(from: highDay)!)
                    // Low day price
                    let lowDay:NSNumber = btcObject["LOW24HOUR"] as! NSNumber
                    let lowDayCurrency =  (formatter.string(from: lowDay)!)
                    
                    // Changing UI
                    self.priceLabel.text = "\(rateCurrency)" // Current price
                    self.dayChangeLabel.text = "\(dayChangeCurrency)  (\(dayChangePercPercentage)%)"
                    self.highLabel.text = "\(highDayCurrency)"
                    self.lowLabel.text = "\(lowDayCurrency)"
                    
                    print("BTC refresh succeed")
                }
            }
        }
        // Check to see if the refresh button is being pressed on BTC or ETH page
        if self.currCrypto == "ETH" {
            // API call for Ethereum
            Alamofire.request("https://min-api.cryptocompare.com/data/pricemultifull?fsyms=ETH&tsyms=USD").responseJSON { response in
                if let bitcoinJSON = response.result.value {
                    let bitcoinObject:Dictionary = bitcoinJSON as! Dictionary<String, Any>
                    
                    // Parse through information
                    let rawObject:Dictionary = bitcoinObject["RAW"] as! Dictionary<String, Any>
                    let usdObject:Dictionary = rawObject["ETH"] as! Dictionary<String, Any>
                    let btcObject:Dictionary = usdObject["USD"] as! Dictionary<String, Any>
                    
                    // Current price
                    let rate:NSNumber = btcObject["PRICE"] as! NSNumber
                    let rateCurrency = (formatter.string(from: rate)!)
                    // Day change
                    let dayChange:NSNumber = btcObject["CHANGE24HOUR"] as! NSNumber
                    let dayChangeCurrency = (formatter.string(from: dayChange)!)
                    // Day change percentage
                    let dayChangePerc:NSNumber = btcObject["CHANGEPCT24HOUR"] as! NSNumber
                    let dayChangePercPercentage = (percFormatter.string(from: dayChangePerc)!)
                    // High day price
                    let highDay:NSNumber = btcObject["HIGH24HOUR"] as! NSNumber
                    let highDayCurrency = (formatter.string(from: highDay)!)
                    // Low day price
                    let lowDay:NSNumber = btcObject["LOW24HOUR"] as! NSNumber
                    let lowDayCurrency =  (formatter.string(from: lowDay)!)
                    
                    // Changing UI
                    self.priceLabel.text = "\(rateCurrency)" // Current price
                    self.dayChangeLabel.text = "\(dayChangeCurrency)  (\(dayChangePercPercentage)%)"
                    self.highLabel.text = "\(highDayCurrency)"
                    self.lowLabel.text = "\(lowDayCurrency)"
                    
                    print("ETH refresh succeed")
                }
            }
        }
    }
    
    // ***************************************************************
    // IMPORTANT: Method called when app is opened for first time
    // ***************************************************************
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Currency formatter
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        // Percentage formatter
        let percFormatter = NumberFormatter()
        percFormatter.minimumFractionDigits = 0
        percFormatter.maximumFractionDigits = 2
        
        // Labels
        priceLabel.text = "..."
        highLabel.text = "..."
        lowLabel.text = "..."
        dayChangeLabel.text = "..."
        
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
                // Day change
                let dayChange:NSNumber = btcObject["CHANGE24HOUR"] as! NSNumber
                let dayChangeCurrency = (formatter.string(from: dayChange)!)
                // Day change percentage
                let dayChangePerc:NSNumber = btcObject["CHANGEPCT24HOUR"] as! NSNumber
                let dayChangePercPercentage = (percFormatter.string(from: dayChangePerc)!)
                // High day price
                let highDay:NSNumber = btcObject["HIGH24HOUR"] as! NSNumber
                    let highDayCurrency = (formatter.string(from: highDay)!)
                // Low day price
                let lowDay:NSNumber = btcObject["LOW24HOUR"] as! NSNumber
                    let lowDayCurrency =  (formatter.string(from: lowDay)!)
                
                // Changing UI
                self.priceLabel.text = "\(rateCurrency)" // Current price
                self.dayChangeLabel.text = "\(dayChangeCurrency)  (\(dayChangePercPercentage)%)"
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

