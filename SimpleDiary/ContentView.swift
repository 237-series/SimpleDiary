//
//  ContentView.swift
//  SimpleDiary
//
//  Created by sglee237 on 2023/01/26.
//

import SwiftUI

struct TopArea: View {
    var body: some View {
        HStack {
            Button {
                
            } label: {
                Text("한줄 일기 기록")
                    .font(.system(size: 33))
                    .frame(maxWidth: .infinity)
            }
            .padding()
        }
        .background(.white)
        .cornerRadius(20)
        .padding()
    }
}




struct ContentView: View {
    var body: some View {
        ZStack{
            Color.gray.ignoresSafeArea()
                .opacity(0.2)
            
            VStack {
                // Area:1 - TopButton
                TopArea()
                // Area:2 - ScrollArea
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
