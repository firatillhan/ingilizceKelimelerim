//
//  RandomViewController.swift
//  Sözlük Uygulaması
//
//  Created by Fırat İlhan on 15.12.2023.
//

import UIKit

class EnglishRandomViewController: UIViewController {
    
    
    var kelimeListesi = [Kelimeler]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self  
        randomKelimelerAll()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        randomKelimelerAll()
    }
    
    
    
    
    @IBAction func RefreshList(_ sender: Any) {
        randomKelimelerAll()
    }
    
    
    
    
    func randomKelimelerAll() {
           //rastgele 25 kelime listeler
           let url = URL(string: "https://www.swiftogreniyorum.com/kelimeler/random_kelimeler.php")!
           
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indeks = sender as? Int
        
        if segue.identifier == "toKelimeDetay" {
            let gidilecekVC = segue.destination as! KelimeDetayViewController
            gidilecekVC.kelime = kelimeListesi[indeks!]
        }
    }
        func makeAlert(titleInput: String, messageInput:String) {
                    let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
                    let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
        }
       
}



extension EnglishRandomViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let kelime = kelimeListesi[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "randomHucre", for: indexPath) as! EnglishRandomHucreTableViewCell
        cell.ingilizceLabel.text = kelime.kelime_en
        cell.turkceLabel.text = kelime.kelime_tr
        return cell
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kelimeListesi.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toKelimeDetay", sender: indexPath.row)
    }
}
