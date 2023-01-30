//
//  DiaryDataManager.swift
//  SimpleDiary
//
//  Created by sglee237 on 2023/01/27.
//

import Foundation

class DiaryDataManager:ObservableObject {
    static let DIARY_DATA_LIST_KEY = "DIARY_DATA_LIST_KEY"
    
    static let shared = DiaryDataManager()
    
    @Published var dataList:[DiaryModel] = []

    
    private var datas:[String:[DiaryModel]] = [:]
    
    init() {
        if let data = UserDefaults.standard.value(forKey: DiaryDataManager.DIARY_DATA_LIST_KEY) as? Data {
            let accountList = try? PropertyListDecoder().decode([DiaryModel].self, from: data)
            if let list = accountList {
                dataList = list
            }
        }
    }
    
    /// Data Structure
    ///  Key: _DIARY_DATA_LIST_KEY_
    ///  Value: Dictionary {key:"DateString", value: Array[DiaryModel] }
    ///
    
    func keyDateString(from date:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = .current
        
        return dateFormatter.string(from: date)
    }
    
    func getDummyData() -> [DiaryModel]  {
        return [
            DiaryModel(keyDate: Date(), title: "오늘은 좋았던날", contents: "오늘 이야기는 3달 전으로 돌아가야 한다", weather: .none, state: .verygood),
            DiaryModel(keyDate: Date(), title: "오늘은 조금 평범했던 날", contents: "조용한 주말이었다.", weather: .cloudy, state: .soso)
        ]
    }
    
    func getList(from date:Date = Date()) -> [DiaryModel] {
        if dataList.isEmpty {
            return getDummyData()
        }
        
        var returnList:[DiaryModel] = dataList
//        if acCate != .none {
//            returnList = []
//            for data in dataList {
//                if data.category == acCate {
//                    returnList.append(acData)
//                }
//            }
//        }
//        
        return returnList
    }
    
    func add(DiaryModel acData:DiaryModel?) -> Bool {
        // Add LocalList
        if let data = acData {
            dataList.insert(data, at: 0)
            
            // Add Save List
            UserDefaults.standard.set(try? PropertyListEncoder().encode(dataList), forKey: DiaryDataManager.DIARY_DATA_LIST_KEY)
            return UserDefaults.standard.synchronize()
        }
        
        return false
    }
}
