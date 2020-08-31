//
//  getData.swift
//  Covid-19
//
//  Created by Albert Cheng on 2020/8/31.
//  Copyright © 2020 Albert Cheng. All rights reserved.
//

import Foundation

class getData: ObservableObject {
    @Published var data: GlobalInfo?
    @Published var countries = [DetailsInfo]()
    
    init() {
        updateData()
    }
    
    func updateData() {
        //update the address version II of API here
        //let url: String = "https://corona.lmao.ninja/v2/countries/taiwan"
        let url_global: String = "https://corona.lmao.ninja/v2/all"
        let url_all_countries: String = "https://corona.lmao.ninja/v2/countries/"
        let session1 = URLSession(configuration: .default)
        let session2 = URLSession(configuration: .default)
        
        //Decreasing to use the exclamation mark, it would cause app crush and failed to fetch data(error:nil value).
        //Using the question mark is a better choice for building apps.
        guard let newGlobalURL = URL(string: url_global) else { return }
        
        session1.dataTask(with: newGlobalURL) {
            (data, res, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            
            let json = try! JSONDecoder().decode(GlobalInfo.self, from: data!)
            
            DispatchQueue.main.async {
                print(json)
                self.data = json
            }
        }.resume()
        
        for i in country {
            let newTarget = url_all_countries + i
            print("newTarget:\(newTarget)")
            guard let myURL = URL(string: newTarget.urlEncoded()) else { return }
            session2.dataTask(with: myURL) {
                (data, res, err) in
                if err != nil {
                    print((err?.localizedDescription)!)
                    return
                }
                let json = try! JSONDecoder().decode(DetailsInfo.self, from: data!)
                
                DispatchQueue.main.async {
                    print(json)
                    self.countries.append(json)
                }
                
            }.resume()
        }
    }
    
}

var country = ["taiwan", "japan", "usa", "singapore", "uganda", "china", "italy", "spain", "vietnam", "s. korea"]
