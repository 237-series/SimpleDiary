//
//  DiaryDataManager.swift
//  SimpleDiary
//
//  Created by sglee237 on 2023/01/27.
//

import Foundation

typealias DiaryDict = [String:[DiaryModel]]

class DiaryDataManager:ObservableObject {
    static let DIARY_DATA_LIST_KEY = "DIARY_DATA_DICT_KEY"
    
    static let shared = DiaryDataManager()
    
    @Published var dataList:[DiaryModel] = []
    
    private var datas:DiaryDict = [:]
    
    var keyDate = ""
    var strKeyDate:String {
        get {
            keyDate
        }
        set(newKeyDate) {
            keyDate = newKeyDate
            if let keyDataList = datas[keyDate] as [DiaryModel]? {
                dataList = keyDataList
            }
            else {
                dataList = []
            }
        }
    }
    
    
    init() {
        if let data = UserDefaults.standard.value(forKey: DiaryDataManager.DIARY_DATA_LIST_KEY) as? Data {
            if let savedObject = try? JSONDecoder().decode(DiaryDict.self, from: data) {
//            let accountList = try? PropertyListDecoder().decode([DiaryModel].self, from: data)
//            if let list = accountList {
//                dataList = list
//            }
                datas = savedObject
            }
        } else {
            //datas = [keyDate : getDummyData()]
        }
        strKeyDate = keyDateString(from: Date())
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
        let newKeyDate = keyDateString(from: date)
        self.keyDate = newKeyDate
        return dataList
    }
    
    func saveDiary(Diary diary:DiaryModel?) -> Bool {
        if let data = diary {
            let myKeyDate = data.keyDateString()
            self.strKeyDate = myKeyDate
            
            for (i , item) in dataList.enumerated() {
                if (item.keyDate == data.keyDate) {
                    dataList.remove(at: i)
                    break
                }
            }
            
            dataList.insert(data, at: 0)
            return true
        }
        
        return false
    }
    
    func add(DiaryModel acData:DiaryModel?) -> Bool {
        // Add LocalList
        if let data = acData {
            // 1. Set Key
            strKeyDate = data.keyDateString()
            dataList.insert(data, at: 0)
            
            datas[strKeyDate] = dataList
            
            // Add Save List
//            UserDefaults.standard.set(datas, forKey: DiaryDataManager.DIARY_DATA_LIST_KEY)
            if let encoded = try? JSONEncoder().encode(datas) {
                UserDefaults.standard.set(encoded, forKey: DiaryDataManager.DIARY_DATA_LIST_KEY)
            }
            return UserDefaults.standard.synchronize()
        }
        
        return false
    }
}
