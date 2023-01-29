//
//  DiaryDetailView.swift
//  SimpleDiary
//
//  Created by sglee237 on 2023/01/28.
//

import SwiftUI

struct DiaryDetailView: View {
    let diary:DiaryModel
    
    func getImageName()->String {
        if let weather = diary.weather {
            return "weather." + weather.rawValue
        }
        
        return "weather.cloudy"
    }
    
    var weatherImage: some View {
        GeometryReader { _ in
            Image(getImageName())
                .resizable()
                .scaledToFill()
                .clipped()
        }
    }
    
    var diaryTitle: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text (diary.title)
                    .font(.largeTitle).fontWeight(.medium)
                    .foregroundColor(.black)
                Spacer()
                
            }
            
            
        }
    }
    
    var diaryContents: some View {
        GeometryReader {
            VStack(alignment: .leading) {
                diaryTitle
                Spacer()
            }
            .frame(height: $0.size.height + 10)
            .padding(32)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: -5)
        }
    }
    
    var body: some View {
        
        ZStack {
            weatherImage  // Weather Image
            
            GeometryReader { geo in
                VStack(spacing: 0) {
                    Spacer()
                    diaryContents // Diary Contents
                        .frame(height: geo.size.height * 0.67)
                }
            }

        }
        .edgesIgnoringSafeArea(.top)
        
    }
}

struct DiaryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryDetailView(diary: DiaryModel(keyDate: Date(), title: "한줄 일기"))
    }
}
