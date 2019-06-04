//
//  PatientInformationViewController.swift
//  HosaProject
//
//  Created by Darvyn Martinez on 2/8/19.
//  Copyright © 2019 Darvyn Martinez. All rights reserved.
//

import UIKit
import CoreNFC

class PatientInformationViewController: UIViewController, NFCNDEFReaderSessionDelegate {
    
    //action to create calls
    
    @IBAction func callBrianMom(_ sender: UIButton) {
        var url:NSURL = NSURL(string: "tel://714-745-2399")!
        UIApplication.shared.openURL(url as URL)
    }
    
    @IBAction func callBrianDad(_ sender: UIButton) {
        var url:NSURL = NSURL(string: "tel://714-225-7367")!
        UIApplication.shared.openURL(url as URL)
    }
    
    @IBAction func callDarvynMom(_ sender: UIButton) {
        var url:NSURL = NSURL(string: "tel://714-341-8317")!
        UIApplication.shared.openURL(url as URL)
    }
    
    @IBAction func callDarvynDad(_ sender: UIButton) {
        var url:NSURL = NSURL(string: "tel://714-262-5284")!
        UIApplication.shared.openURL(url as URL)
    }
    
    
    
    
    //properties
    @IBAction func bgSave(_ sender: UITapGestureRecognizer) {
    }
    
    
    
    /// NFC session reference.
    private var nfcSession: NFCNDEFReaderSession!
    
    @IBOutlet weak var darvynScrollView: UIScrollView!
    @IBOutlet weak var brianScrollView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @IBAction func scanButton(_ sender: Any) {
        nfcSession = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: false)
        nfcSession.alertMessage = "Hold your iPhone near \"Scan\" indicator on the bracelet."
        nfcSession.begin()
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print(error)
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            session.invalidate()
        })
        var result = ""
        for payload in messages[0].records {
            result += String.init(data: payload.payload.advanced(by: 3), encoding: .utf8)! // 1
        }
        
        if result == "DarvynMartinez" {
            DispatchQueue.main.async {
                self.darvynScrollView.isHidden = false
                self.brianScrollView.isHidden = true
            }
        } else if result == "BrianKo" {
            DispatchQueue.main.async {
                self.brianScrollView.isHidden = false
                self.darvynScrollView.isHidden = true
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}
