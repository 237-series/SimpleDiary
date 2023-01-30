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
        
        return "weather.default"
    }
    
    func getFeelingColor() -> Color {
        if let feeling = self.diary.feeling {
            return feeling.feelingColor
        }
        
        return .white
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
    
    func getStateList() -> Array<String> {
        if let state = diary.state {
            return Array(repeating: "heart.rectangle", count: state.rawValue)
        }
        return Array()
    }
    
    var diaryHead: some View {
        HStack {
            Text (diary.keyDateString())
                .font(.title2).fontWeight(.bold)
                .foregroundColor(.secondary)
            Spacer()
            HStack(spacing: -2) {
                ForEach(getStateList(), id: \.self) { imageName in
                    Image(systemName: imageName)
                        .imageScale(.large)
                        .foregroundColor(.red)
                    
                }
                
            }
            
        }
    }
    
    func getDiaryContents() -> String {
        var text = "일기 내용입니다"
        if let contents = diary.contents {
            text = contents
        }
        return text
    }
    
    var diaryDescription: some View {
        ScrollView {
            Text(getDiaryContents() )
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
    
    var diaryContents: some View {
        GeometryReader {
            VStack(alignment: .leading) {
                diaryHead
                diaryTitle
                Text("")
                diaryDescription
                Spacer()
            }
            .frame(height: $0.size.height + 10)
            .padding(32)
            .background(.white)
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
        DiaryDetailView(diary: DiaryModel(keyDate: Date(), title: "한줄 일기", feeling: .happy, state: .good))
    }
}
