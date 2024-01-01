//
//  KelimeDetayTrViewController.swift
//  Sözlük Uygulaması
//
//  Created by Fırat İlhan on 31.12.2023.
//

import UIKit

class KelimeDetayTrViewController: UIViewController {

    @IBOutlet weak var turkceLabel: UILabel!
    @IBOutlet weak var ingilizceLabel: UILabel!
    
    var kelime:Kelimeler?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let k = kelime {
            ingilizceLabel.text = k.kelime_en
            turkceLabel.text = k.kelime_tr
        }
        ingilizceLabel.layer.masksToBounds = true
        ingilizceLabel.layer.cornerRadius = 15
        
        
        turkceLabel.layer.masksToBounds = true
        turkceLabel.layer.cornerRadius = 15
    }
    

    
    @IBAction func learnedButtonTr(_ sender: Any) {
        if let k = kelime {
            
            if let kid = Int(k.kelime_id!) {
                print("Yeni Durum: \(kid)")
               ogrendigimKelimeler(kelime_id: kid)
                //navigationController?.popToRootViewController(animated: true)
                makeAlert(titleInput: "Başarılı", messageInput: "Kelime eklendi")
            }
        }
    }
    
    func makeAlert(titleInput: String, messageInput:String) {
        
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let geriButton = UIAlertAction(title: "Geri Dön", style: .default) { (UIAlertAction) in
            self.geriButton() }
            alert.addAction(geriButton)
      
        self.present(alert, animated: true, completion: nil)
   
    }
    func geriButton() {
        navigationController?.popViewController(animated: true)
    

    }
    
    
    
    func ogrendigimKelimeler(kelime_id:Int) {
       //kelimeyi öğrendiğim kelimeler listesine ekler
        var request = URLRequest(url: URL(string: "https://www.swiftogreniyorum.com/kelimeler/...")!)
        request.httpMethod = "POST"
        let postString = "kelime_id=\(kelime_id)"
        request.httpBody = postString.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil || data == nil {
                print("Hataa")
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any] {
                    print(json)
                    
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
    
    
}
