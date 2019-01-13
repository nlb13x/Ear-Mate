//
//  ViewController.swift
//  Hard of Hearing
//
//  Created by 苏 on 2019/1/13.
//  Copyright © 2019 StarterHack. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    
    @IBAction func textButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "segue_text", sender: self)
    }
    
    @IBAction func acountButton(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "segue_acount", sender: self)
        
    }
    
    @IBAction func unwind(for segue: UIStoryboardSegue) {
        print("unwind...")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }


}

