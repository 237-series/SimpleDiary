//
//  DiaryDetailView.swift
//  SimpleDiary
//
//  Created by sglee237 on 2023/01/28.
//

import SwiftUI

struct DiaryDetailView: View {
    @State var diary:DiaryModel
    @State var isEditMode:Bool = false
    @State var contents:String = ""
    
    func getImageName()->String {
        if let weather = diary.weather {
            return "weather." + weather.rawValue
        }
        
        return "weather.sunny"
    }
    
    func getFeelingColor() -> Color {
        if let feeling = self.diary.feeling {
            return feeling.feelingColor
        }
        
        return .white
    }
    
    
    var weatherImage: some View {
        GeometryReader { geo in
            Image(getImageName())
                .resizable()
                .scaledToFit()
                .clipped()
        }
    }
    
    func modechange() {
        if let content = diary.contents {
            self.contents = content
        }
        
        self.isEditMode.toggle()
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
    
    var bottomButtons: some View {
        HStack {
            Spacer()
            Button {
                if let content = diary.contents {
                    self.contents = content
                }
                modechange()
            } label: {
                HStack {
                    Image(systemName: "trash")
                    Text("취소")
                        .fontWeight(.semibold)
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.red)
                .cornerRadius(40)
            }
            Button {
//                modechange()
                diary.contents = self.contents
                self.isEditMode = !DiaryDataManager.shared.saveDiary(Diary: self.diary)
                self.contents = ""
            } label: {
                HStack {
                    Image(systemName: "pencil.circle")
                    Text("수정완료")
                        .fontWeight(.semibold)
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.green)
                .cornerRadius(40)
            }
            
        }
        .opacity(isEditMode ? 1 : 0)
        .padding()
    }
    
    func getDiaryContents() -> String {
        var text = ""
        if let contents = diary.contents {
            text = contents
        }
        return text
    }
    
    var diaryDescription: some View {
        ScrollView {
            if (isEditMode == false) {
                Text(getDiaryContents() )
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            else {
                TextField("일기내용", text: $contents, axis: .vertical)
            }
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
        .onTapGesture(count: 2, perform: {
            modechange()
        })
    }
    
    func areaHeight() -> Double {
        if self.isEditMode {
            return 0.80
        }
        return 0.66
    }
    
    var body: some View {
        
        ZStack {
            weatherImage  // Weather Image
            
            GeometryReader { geo in
                VStack(spacing: 0) {
                    Spacer()
                    diaryContents // Diary Contents
                        .frame(height: geo.size.height * areaHeight())
                }
            }
            
            VStack {
                Spacer()
                bottomButtons
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
