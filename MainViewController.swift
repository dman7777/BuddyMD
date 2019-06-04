//
//  MainViewController.swift
//  HosaProject
//
//  Created by Darvyn Martinez on 3/13/19.
//  Copyright © 2019 Darvyn Martinez. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerButton(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "https://docs.google.com/forms/d/e/1FAIpQLSeED6nBGPDuw9hcmFFHNXEkSPh2CY9YqFn8ihPqjozZy1GBdg/viewform?pli=1")! as URL, options: [:], completionHandler: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
     hey
    */
    
}
