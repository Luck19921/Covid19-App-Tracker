//
//  ContentView.swift
//  Covid-19
//
//  Created by Albert Cheng on 2020/4/14.
//  Copyright © 2020 Albert Cheng. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var data = getData()
    
    var body: some View {
        ScrollView {
            VStack {
                if self.data.countries.count != 0 && self.data.data != nil {
                    VStack {
                        HStack(alignment: .top) {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("離上次更新時間：\(getDate(time: self.data.data.updated))")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                Text("COVID-19<全世界疫情狀況>")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                Text("全世界病患總人數：\(getValue(data: self.data.data.cases))")
                                    .fontWeight(.bold)
                                    .font(.body)
                                    .foregroundColor(.white)
                                Text("習維尼的武漢病毒蔓延迅速, 請各位做好保護措施")
                                    .fontWeight(.bold)
                                    .font(.system(size: 14, weight: Font.Weight.regular, design: Font.Design.rounded))
                                    .foregroundColor(.red)
                                    .padding()
                                    .background(Color.white.opacity(0.8))
                                    .cornerRadius(30)
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                self.data.data = nil
                                self.data.countries.removeAll()
                                self.data.updateData()
                                
                            }) {
                                Image(systemName: "arrow.clockwise")
                                    .font(.title)
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.top, (UIApplication.shared.windows.first?.safeAreaInsets.top))
                        .padding()
                        .padding(.bottom, 60)
                        .background(Color.red.opacity(0.8))
                        
                        HStack(spacing: 15) {
                            VStack(alignment: .center, spacing: 15) {
                                Text("死亡人數")
                                    .foregroundColor(Color.black.opacity(0.5))
                                Text(getValue(data: self.data.data.deaths))
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.red)
                            }
                            .padding(30)
                            .background(Color.white)
                            .cornerRadius(12)
                            
                            VStack(alignment: .center, spacing: 15) {
                                Text("痊癒人數")
                                    .foregroundColor(Color.black.opacity(0.5))
                                Text(getValue(data: self.data.data.recovered))
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.green)
                            }
                            .padding(30)
                            .background(Color.white)
                            .cornerRadius(12)
                        }
                        .offset(y: -60)
                        .padding(.bottom, -60)
                        .zIndex(25)
                        
                        VStack(alignment: .center, spacing: 15) {
                            Text("確診人數")
                                .foregroundColor(Color.black.opacity(0.5))
                            Text(getValue(data: self.data.data.active))
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.yellow)
                        }
                        .padding(30)
                        .background(Color.white)
                        .cornerRadius(12)
                        .padding(.top, 15)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(self.data.countries, id: \.self) { myID in
                                    cellView(data: myID)
                                }
                            }
                            .padding()
                        }
                        VStack(alignment: .center, spacing: 12) {
                            Text("Albert Cheng 2020/04/14")
                                .fontWeight(.bold)
                                .foregroundColor(.red)
                                .font(.system(size: 15))
                            
                            Text("Latest Version: 2020/04/17")
                                .fontWeight(.bold)
                                .foregroundColor(.red)
                                .font(.system(size: 15))
                            
                            Text("Reference: Kavsoft")
                                .fontWeight(.bold)
                                .foregroundColor(.red)
                                .font(.system(size: 15))
                            
                        }.padding(.bottom, 40)
                            .padding(.top, 10)
                        
                    }
                } else {
                    VStack(alignment: .center, spacing: 12) {
                        GeometryReader { geometry in
                            Indicator().frame(width: UIScreen.main.bounds.width , height: UIScreen.main.bounds.height)
                        }
                    }
                }
            }.edgesIgnoringSafeArea(.top)
                .background(Color.black.opacity(0.1)
                    .edgesIgnoringSafeArea(.all))
        }
    }
}

func getDate(time: Double) -> String {
       //working api stuffs here
       let date = Double(time / 1000)
       let format = DateFormatter()
       format.dateFormat = "MMM - dd - YYYY hh:mm a"
    return format.string(from: Date(timeIntervalSince1970: TimeInterval(exactly: date)!))
   }

   func getValue(data: Double) -> String {
       let format = NumberFormatter()
       format.numberStyle = .decimal
    return format.string(for: data)!
   }

struct cellView: View {
    
    var data: Details
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("國家：\(data.country)")
                .fontWeight(.bold)
            
            HStack(spacing: 15) {
                
                VStack(alignment: .center, spacing: 12) {
                    Text("確診人數")
                        .font(.title)
                    Text(getValue(data: data.cases))
                        .font(.title)
                }
                
                VStack(alignment: .center, spacing: 12) {
                    
                    VStack(alignment: .center, spacing: 10) {
                        Text("死亡")
                        Text(getValue(data: data.deaths))
                            .foregroundColor(.red)
                    }
                    
                    Divider()
                    
                    VStack(alignment: .center, spacing: 10) {
                        Text("痊癒")
                        Text(getValue(data: data.recovered))
                            .foregroundColor(.green)
                    }
                    
                    Divider()
                    
                    VStack(alignment: .center, spacing: 10) {
                        Text("重症")
                        Text(getValue(data: data.critical))
                            .foregroundColor(.yellow)
                    }
                }
            }
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width - 30)
        .background(Color.white)
        .cornerRadius(20)
    }
}


struct GlobalInfo: Decodable {
    var cases: Double
    var deaths: Double
    var recovered: Double
    var critical: Double
    var active: Double
    var updated: Double
}

struct Details: Decodable, Hashable {
    var country: String
    var cases: Double
    var deaths: Double
    var recovered: Double
    var critical: Double
}

class getData: ObservableObject {
    @Published var data: GlobalInfo!
    @Published var countries = [Details]()
    
    init() {
        updateData()
    }
    
    func updateData() {
        //update the address version II of API here
        //let url: String = "https://corona.lmao.ninja/v2/countries/taiwan"
        let url: String = "https://corona.lmao.ninja/v2/all"
        let url1: String = "https://corona.lmao.ninja/v2/countries/"
        let session = URLSession(configuration: .default)
        let session1 = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: url)!) {
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
            let newTarget = url1 + i
            session1.dataTask(with: URL(string: newTarget)!) {
                (data, res, err) in
                if err != nil {
                    print((err?.localizedDescription)!)
                    return
                }
                
                let json = try! JSONDecoder().decode(Details.self, from: data!)
                DispatchQueue.main.async {
                    print(json)
                    self.countries.append(json)
                }
            }.resume()
        }
    }
    
    
}
//var country_default = ["Taiwan", "Japan", "S. Korea", "China","USA", "Italy"]

var country = ["Taiwan", "Japan", "Uganda", "Vietnam", "Thailand", "Macao", "China","USA", "Italy", "Spain", "Australia", "Singapore", "Russia", "UAE"]
struct Indicator: UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<Indicator>) -> UIActivityIndicatorView {
        let v = UIActivityIndicatorView(style: .large)
        v.startAnimating()
        return v
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<Indicator>) {
    }
}


