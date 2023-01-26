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

struct ContentsArea:View {
    var body: some View {
        ScrollView() {
            VStack(spacing: 10) {
                DiaryListRow()
                DiaryListRow()
                DiaryListRow()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .padding()
        }
        .background(.white)
        .cornerRadius(20)
        .padding()
    }
}


struct DiaryListRow: View {
    var body: some View {
        HStack {
            // 로고 자리 (이모지로 대체)
            Text("😀")
                .font(.system(size: 45))
                .cornerRadius(0.3)
            
            VStack(alignment: .leading) {
                //타이틀, 금액
                Text("2023-01-25")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text("오늘은 행복한 하루~")
                    .font(.title3)
            }
            
            Spacer()
            
        }
        
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
                ContentsArea()
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
