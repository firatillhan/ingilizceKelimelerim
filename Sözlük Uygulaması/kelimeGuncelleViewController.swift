//
//  kelimeGuncelleViewController.swift
//  Sözlük Uygulaması
//
//  Created by Fırat İlhan on 23.12.2023.
//

import UIKit

class kelimeGuncelleViewController: UIViewController {

    @IBOutlet weak var kelimeEnText: UITextField!
    @IBOutlet weak var kelimeTrText: UITextField!
    
    var kelime:Kelimeler?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        kelimeEnText.layer.masksToBounds = true
        kelimeEnText.layer.cornerRadius = 15
        
        kelimeTrText.layer.masksToBounds = true
        kelimeTrText.layer.cornerRadius = 15
        
        if let k = kelime {
            kelimeEnText.text = k.kelime_en
            kelimeTrText.text = k.kelime_tr
        }
    }
    

    @IBAction func kelimeGuncelleBtn(_ sender: Any) {
        if let k = kelime, let en = kelimeEnText.text, let tr = kelimeTrText.text {
            
            if let kid = Int(k.kelime_id!) {
                print("Yeni İngilizce kelime: \(en), Yeni Türkçe kelime : \(tr)")
                kelimeGuncelle(kelime_id: kid, kelime_en: en, kelime_tr: tr)
                self.makeAlert(titleInput: "Tebrikler", messageInput: "Kelime Güncellendi...")

            }
        }
    }
    
    func kelimeGuncelle(kelime_id:Int,kelime_en:String,kelime_tr:String) {
       //kelime günceller
        var request = URLRequest(url: URL(string: "https://www.swiftogreniyorum.com/kelimeler/...")!)
        request.httpMethod = "POST"
        let postString = "kelime_id=\(kelime_id)&kelime_en=\(kelime_en)&kelime_tr=\(kelime_tr)"
        request.httpBody = postString.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil || data == nil {
                print("Hata")
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
       // let okButton = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil)
        let okButton = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default) { (UIAlertAction) in
            self.okButton() }
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
        }
    func okButton() {
        navigationController?.popViewController(animated: true)

    }
   
    

}
