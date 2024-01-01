//
//  LearnedTrViewController.swift
//  Sözlük Uygulaması
//
//  Created by Fırat İlhan on 31.12.2023.
//

import UIKit

class LearnedTrViewController: UIViewController {

    
    
    @IBOutlet weak var tableView: UITableView!
    var kelimeListesi = [Kelimeler]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        learnedKelimelerAll()
    }
    func learnedKelimelerAll() {
           //öğrendiğim kelimeleri listeler
           let url = URL(string: "https://www.swiftogreniyorum.com/kelimeler/learned_kelimeler_tr.php")!
           
           URLSession.shared.dataTask(with:url) { data, response, error in
               if error != nil || data == nil {
                   print("Hata")
                   return
               }
               do {
                   let cevap = try JSONDecoder().decode(KelimelerCevap.self, from: data!)
                   if let gelenKelimelistesi = cevap.kelimeler {
                       self.kelimeListesi = gelenKelimelistesi
                   }
                   DispatchQueue.main.async {
                       self.tableView.reloadData()
                   }
               }catch {
                   print(error.localizedDescription)
               }
           }.resume()
       }
    
    func kelimeCikar(kelime_id:Int) {
       //öğrendiğim tr kelimeler listesinden kelimeyi çıkarır
        var request = URLRequest(url: URL(string: "https://www.swiftogreniyorum.com/kelimeler/")!)
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
                  
                    self.learnedKelimelerAll()
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func makeAlert(titleInput: String, messageInput:String) {
        
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
   
    }

 

}


extension LearnedTrViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kelimeListesi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let kelime = kelimeListesi[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "learnedTrHucre", for: indexPath) as! LearnedHucreTrTableViewCell
        cell.ingilizceLabel.text = kelime.kelime_en
        cell.turkceLabel.text = kelime.kelime_tr
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let cikarAction = UIContextualAction(style: .destructive, title: "Çıkar") {
            (contextualAction, view, boolValue) in
             let kelime = self.kelimeListesi[indexPath.row]
             if let kid = Int(kelime.kelime_id!) {
             self.kelimeCikar(kelime_id: kid)
             }
        }
        return UISwipeActionsConfiguration(actions: [cikarAction])
    }
    
    
}
