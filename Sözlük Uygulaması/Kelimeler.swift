//
//  Kelimeler.swift
//  Sözlük Uygulaması
//
//  Created by Fırat İlhan on 2.04.2023.
//

import Foundation


class Kelimeler:Codable {
    var kelime_id:String?
    var kelime_en:String?
    var kelime_tr:String?
    
    init() {
        
    }
    
    init(kelime_id:String,kelime_en:String,kelime_tr:String) {
        self.kelime_id = kelime_id
        self.kelime_en = kelime_en
        self.kelime_tr = kelime_tr
    }
}
