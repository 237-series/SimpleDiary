//
//  DiaryInputModal.swift
//  SimpleDiary
//
//  Created by sglee237 on 2023/01/26.
//

import SwiftUI

struct DiaryInputModal: View {
    @Binding var isPresented: Bool
    @Environment(\.dismiss) private var dismiss
    
    @State private var title:String = ""
    
    var TopButton: some View {
        // Top Button
        HStack {
            Button {
                dismiss()
            } label: {
                Text("돌아가기")
            }
            Spacer()
        }.padding()
    }
    
    var InputArea: some View {
        
        VStack {
            HStack {
                Text("오늘은 어떤가요?")
                    .font(.title)
                Spacer()
                Button(action: {
                    
                }) {
                    Image(systemName: "arrow.up")
                        .imageScale(.large)
                        .frame(width: 40, height: 40)
                        .foregroundColor(.white)
                        .background(.gray)
                        .clipShape(Circle())
                    
                }
                
                
            }
            
            TextField("...입력하기...", text: $title)
                .keyboardType(.decimalPad)
                .font(.title)
        }
        .padding()
    }
    
    var body: some View {
        VStack {
            TopButton
            InputArea
            Spacer()
        }
        .padding()
    }
}

