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
    
    init() {
        if let data = UserDefaults.standard.value(forKey: DiaryDataManager.DIARY_DATA_LIST_KEY) as? Data {
            let accountList = try? PropertyListDecoder().decode([DiaryModel].self, from: data)
            if let list = accountList {
                dataList = list
            }
        }
    }
    
    func getDummyData() -> [DiaryModel] {
        return [
            DiaryModel(keyDate: Date(), title: "오늘은 좋았던날"),
            DiaryModel(keyDate: Date(), title: "오늘은 조금 평범했던 날")
            
        ]
    }
    
    func getList() -> [DiaryModel] {
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
