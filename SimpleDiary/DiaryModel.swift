//
//  DiaryModel.swift
//  SimpleDiary
//
//  Created by sglee237 on 2023/01/26.
//

import Foundation


/*
 Data Structure of DiaryModel
    - 날짜:Date as id       - 날씨: []
    - 최종수정일자:           - 기분: []
    - 한줄일기(제목)          - 상태: []
    - 내용                  - 사진: 사진데이터 or 링크
    - 사용자id: 기기UUID
    - 파트너id: 교환일기용

*/

enum DiaryWeatherItem {
    /// 날씨: [맑음, 흐림, 비, 눈, 바람, 추움, 더움]
    case sunny
    case cloudy
    case rain
    case snow
    case wind
    case cold
    case hot
}

enum DiaryFeelingItem {
    /// 기분: [행복, 기쁨, 신남, 슬픔, 우울, 짜증, 화남, 그저그럼]
    case happy
    case delight
    case excited
    case sad
    case moodiness
    case annoying
    case angry
    case soso
}

enum DiaryStateItem {
    /// 상태: [매우좋음, 좋음, 보통, 나쁨, 매우나쁨]
    case verygood
    case good
    case soso
    case bad
    case verybad
}

struct DiaryModel {
    /// id, 최초 작성시 사용
    var keyDate:Date
    
    /// 마지막 수정 날짜
    var lastModifiedDate:Date?
    
    /// 한줄 일기 및 일기 내용
    var title: String
    var contents: String?
    
    /// 사용자 id 및 교환일기용 상대 id
    var userId:UUID?
    var partnerId:UUID?
    
    /// 날씨:
    var weather:DiaryWeatherItem?
    var feeling:DiaryFeelingItem?
    var state:DiaryStateItem?
    
    /// 사진
    
    
    // 필수 초기화 요소
    init(keyDate: Date, lastModifiedDate: Date? = nil, title: String, contents: String? = nil, userId: UUID? = nil, partnerId: UUID? = nil, weather: DiaryWeatherItem? = nil, feeling: DiaryFeelingItem? = nil, state: DiaryStateItem? = nil) {
        self.keyDate = keyDate
        self.lastModifiedDate = lastModifiedDate
        self.title = title
        self.contents = contents
        self.userId = userId
        self.partnerId = partnerId
        self.weather = weather
        self.feeling = feeling
        self.state = state
    }
}
