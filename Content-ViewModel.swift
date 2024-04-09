//
//  Content-ViewModel.swift
//  Countdown
//
//  Created by ZAIZER120804 on 08/04/24.
//

import Foundation

extension ContentView{
    final class Viewmodel: ObservableObject{
        @Published var isactive = false
        @Published var showalert = false
        @Published var time: String = "5:00"
        @Published var minutes: Float = 5.0{
            didSet {
                self.time = "\(Int(minutes)):00"
            }
        }
        private var initialtime = 0
        private var enddate = Date()
        
        func start(minutes: Float){
            self.initialtime = Int(minutes)
            self.enddate = Date()
            self.isactive = true
            self.enddate = Calendar.current.date(byAdding: .minute, value: Int(minutes), to: enddate)!
            
        }
        
        func reset(){
            self.minutes = Float(initialtime)
            self.isactive = false
            self.time = "\(Int(minutes)):00"
        }
        
        func updatecountdown(){
            guard isactive else {return}
            
            let now = Date()
            let diff = enddate.timeIntervalSince1970 - now.timeIntervalSince1970
            
            if diff <= 0 {
                self.isactive = false
                self.time = "0.00"
                self.showalert = true
                return
            }
            
            let date = Date(timeIntervalSince1970: diff)
            let calendar = Calendar.current
            let minutes = calendar.component(.minute, from: date)
            let seconds = calendar.component(.second, from: date)
            
            self.minutes = Float(minutes)
            self.time = String(format: "%d:%02d", minutes, seconds)
        }
    }
}
