//
//  ViewController.swift
//  Sözlük Uygulaması
//
//  Created by Fırat İlhan on 2.04.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var kelimeListesi = [Kelimeler]()
    
    var aramaYapiliyorMu = false
    var aramaKelimesi:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
          
      
        
        
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        tumKelimelerAll()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if aramaYapiliyorMu {
            aramaYap(aramaKelimesi: aramaKelimesi!)
        } else {
            tumKelimelerAll()
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indeks = sender as? Int
        
        if segue.identifier == "toKelimeDetay" {
            let gidilecekVC = segue.destination as! KelimeDetayViewController
            gidilecekVC.kelime = kelimeListesi[indeks!]
        }
        if segue.identifier == "toGuncelle" {
            let gidilecekVC = segue.destination as! kelimeGuncelleViewController
            gidilecekVC.kelime = kelimeListesi[indeks!]
        }
     
        
       
    }
    func tumKelimelerAll() {
        //tüm kelimeleri getirir
        let url = URL(string: "https://www.swiftogreniyorum.com/kelimeler/tum_kelimeler.php")!
        
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
    
    func kelimeSil(kelime_id:Int) {
          // kelimeyi siler
           var request = URLRequest(url: URL(string: "https://www.swiftogreniyorum.com/kelimeler/...")!)

           request.httpMethod = "POST"
           let postString = "kelime_id=\(kelime_id)"
           request.httpBody = postString.data(using: .utf8)
           
           URLSession.shared.dataTask(with: request) { data, response, error in
               if error != nil || data == nil {
                   print("Hata")
                   return
               }
               do {
                   if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any] {
                       print(json)
                       if self.aramaYapiliyorMu {
                           self.aramaYap(aramaKelimesi: self.aramaKelimesi!)
                       } else {
                           self.tumKelimelerAll()
                           print("tum kisiler all")
                       }
                   }
                   
               } catch {
                   print(error)
               }
           }.resume()
           
       }
    
    
    func aramaYap(aramaKelimesi:String) {
        //anasayfada tüm kelimeler listesinde arama yapar
        var request = URLRequest(url: URL(string: "https://www.swiftogreniyorum.com/kelimeler/tum_kelimeler_arama.php")!)
        
        request.httpMethod = "POST"
        
        let postString = "kelime_en=\(aramaKelimesi)"
        
        request.httpBody = postString.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil || data == nil {
                print("Hata")
                self.makeAlert(titleInput: "Error", messageInput: "Bir sorun var!")
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
    
    
    func makeAlert(titleInput: String, messageInput:String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
        }
}

extension ViewController:UITableViewDelegate,UITableViewDataSource {

    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return kelimeListesi.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let kelime = kelimeListesi[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "kelimeHucre", for: indexPath) as! KelimeHucreTableViewCell
        cell.ingilizceLabel.text = kelime.kelime_en
        cell.turkceLabel.text = kelime.kelime_tr
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toKelimeDetay", sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let silAction = UIContextualAction(style: .destructive, title: "Sil") {
            (contextualAction, view, boolValue) in
            let kelime = self.kelimeListesi[indexPath.row]
            if let kid = Int(kelime.kelime_id!) {
                self.kelimeSil(kelime_id: kid)
                self.makeAlert(titleInput: "Tebrikler", messageInput: "Kelimeyi Silindi!")
            }
            
        }
    
        let guncelleAction = UIContextualAction(style: .normal, title: "Güncelle") {
            (contextualAction, view, boolValue) in
            self.performSegue(withIdentifier: "toGuncelle", sender: indexPath.row)
            
        }
        return UISwipeActionsConfiguration(actions: [silAction, guncelleAction])
    }
}
extension ViewController:UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        aramaKelimesi = searchText
             
             if searchText ==  "" {
                 aramaYapiliyorMu = false
             } else {
                 aramaYapiliyorMu = true
             }
             aramaYap(aramaKelimesi: aramaKelimesi!)
              
             
             print("Arama sonuç : \(searchText)")
    }
}
