//
//  XCUViewController.swift
//  Demo
//
//  Created by Deheng Xu on 2020/1/4.
//  Copyright © 2020 Deheng.Xu. All rights reserved.
//

import UIKit

class XCUViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        log_Sw.setLoggingEnabled(true)
        SwLog("\(#function)");
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
