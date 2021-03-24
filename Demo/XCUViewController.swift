//
//  XCUViewController.swift
//  Demo
//
//  Created by Deheng Xu on 2020/1/4.
//  Copyright © 2020 Deheng.Xu. All rights reserved.
//

import UIKit
import XCocoaUtilsPublic

class XCUViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mainvcLogSwift("func: \(#function)");
        let home = getEnv("HOME")
        debugPrint("home: \(home)")
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
