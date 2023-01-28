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
    
    var dataManager:DiaryDataManager = DiaryDataManager.shared
    
    @State var selectedWeather:DiaryWeatherItem = .sunny
    
    @State private var title:String = ""
    
    func addData() -> Bool {
        let newData = DiaryModel(keyDate: Date(), title: title)
        let result = dataManager.add(DiaryModel: newData)
        return !result
        
    }
    
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
    
    var PickerArea: some View {
        VStack {
            Picker("", selection: $selectedWeather) {
                ForEach(DiaryWeatherItem.allCases, id:\.self) { weatherItem in
                    Text(weatherItem.displayImoji).tag(weatherItem)
                }
            } .onChange(of: selectedWeather, perform: { newWeather in
                
            })
            .pickerStyle(SegmentedPickerStyle())
            
        }
    }
    
    
    var InputArea: some View {
        
        
        VStack {
            
            HStack {
                Text("오늘은 어떤가요?")
                    .font(.title)
                Spacer()
                Button(action: {
                    let result = addData()
                    isPresented = result
                }) {
                    Image(systemName: "arrow.up")
                        .imageScale(.large)
                        .frame(width: 40, height: 40)
                        .foregroundColor(.white)
                        .background(.gray)
                        .clipShape(Circle())
                    
                }
                
            }
            
            PickerArea
            
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

