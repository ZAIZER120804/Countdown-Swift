//
//  ContentView.swift
//  Countdown
//
//  Created by ZAIZER120804 on 08/04/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = Viewmodel()
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private let width: Double = 250
    var body: some View {
        VStack {
            Text("\(vm.time)")
                .font(.system(size: 70, weight: .medium, design: .rounded))
                .padding()
                .frame(width: width)
                .background(.thinMaterial)
                . cornerRadius(20)
                .overlay(RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.gray, lineWidth: 4))
                .alert("Timer done!", isPresented: $vm.showalert){
                    Button("Continue", role: .cancel){
                        
                    }
                }
            
            Slider (value: $vm.minutes, in: 1...10, step: 1)
                .padding()
                .frame(width: width)
                .disabled(vm.isactive)
                .animation(.easeInOut, value: vm.minutes)
            
            HStack(spacing: 50){
                Button("Start"){
                    vm.start(minutes: vm.minutes)
                }
                .disabled(vm.isactive)
                
                Button ("Reset", action: vm.reset)
                    .tint(.red)
            }
            .frame(width: width)
        }
        .onReceive(timer){
            _ in
            vm.updatecountdown()
        }
    }
}

#Preview {
    ContentView()
}
