//
//  kelimeEkleViewController.swift
//  Sözlük Uygulaması
//
//  Created by Fırat İlhan on 14.12.2023.
//



import UIKit

class kelimeEkleViewController: UIViewController {
    
    
    @IBOutlet weak var kelimeEnText: UITextField!
    @IBOutlet weak var kelimeTrText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        kelimeEnText.layer.masksToBounds = true
        kelimeEnText.layer.cornerRadius = 15
        
        kelimeTrText.layer.masksToBounds = true
        kelimeTrText.layer.cornerRadius = 15

    }
    
  
    
    @IBAction func kelimeEkleBtn(_ sender: Any) {
        
        
        
        if kelimeEnText.text == "" && kelimeTrText.text == "" {
            makeAlert(titleInput: "Hata!", messageInput: "Boş Bırakamazsınız!")
        } else {
            if let en = kelimeEnText.text, let tr = kelimeTrText.text {
                kelimeEkle(kelime_en: en, kelime_tr: tr)
                print(en)
                print(tr)
                self.makeAlert(titleInput: "Tebrikler", messageInput: "Kelime Eklendi.")
                
            }
        }
        
    }
    
    func kelimeEkle(kelime_en:String,kelime_tr:String) {
        //kelime ekler
        var request = URLRequest(url: URL(string: "https://www.swiftogreniyorum.com/kelimeler/...")!)
        
        request.httpMethod = "POST"
        let postString = "kelime_en=\(kelime_en)&kelime_tr=\(kelime_tr)"
        request.httpBody = postString.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil || data == nil {
                print("Hata")
                //self.makeAlert(titleInput: "Error", messageInput: "Hay aksi birşeyler ters gitti...")
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
    
    func makeAlert(titleInput: String, messageInput:String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Yeni Kelime", style: UIAlertAction.Style.default) { (UIAlertAction) in
            self.okButton() }
        let geriButton = UIAlertAction(title: "Geri Dön", style: .default) { (UIAlertAction) in
            self.geriButton() }
            alert.addAction(okButton)
            alert.addAction(geriButton)
            self.present(alert, animated: true, completion: nil)
        }
        
        func geriButton() {
            navigationController?.popViewController(animated: true)
            //self.performSegue(withIdentifier: "back", sender: nil)
        }
    
    func okButton() {
        kelimeEnText.text = ""
        kelimeTrText.text = ""
    }
        
    }


