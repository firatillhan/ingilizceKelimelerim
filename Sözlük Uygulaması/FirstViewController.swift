//
//  FirstViewController.swift
//  Sözlük Uygulaması
//
//  Created by Fırat İlhan on 16.12.2023.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var random_kelimeler: UIButton!
    @IBOutlet weak var tum_kelimeler: UIButton!
    
    @IBOutlet weak var turkceRandomKelimeler: UIButton!
    @IBOutlet weak var ogrendigim_kelimeler: UIButton!
    
    @IBOutlet weak var ogrendigimKelimelerTr: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
      //  ingilizceLabel.layer.masksToBounds = true
     //   ingilizceLabel.layer.cornerRadius = 15
        
        tum_kelimeler.layer.masksToBounds = true
        tum_kelimeler.layer.cornerRadius = 15
        
        random_kelimeler.layer.masksToBounds = true
        random_kelimeler.layer.cornerRadius = 15
        
        ogrendigim_kelimeler.layer.masksToBounds = true
        ogrendigim_kelimeler.layer.cornerRadius = 15
        
        turkceRandomKelimeler.layer.masksToBounds = true
        turkceRandomKelimeler.layer.cornerRadius = 15
        
        ogrendigimKelimelerTr.layer.masksToBounds = true
        ogrendigimKelimelerTr.layer.cornerRadius = 15
        
        
        
    }
    

   

}
