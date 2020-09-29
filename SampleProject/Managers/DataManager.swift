//
//  DataManager.swift
//  SampleProject
//
//  Created by Manish Tard on 28/09/20.
//  Copyright © 2020 Manish Tard. All rights reserved.
//

import Foundation

class DataManger {
    static let shared = DataManger()
    
    private init(){}
    
    
    func getDataFromFile(fileName: String, completion: ([Section]?, String?) -> Void){
        guard let url = Bundle.main.url(forResource: fileName, withExtension: nil) else{
            completion(nil, "Unable to find resource")
            return
        }
        do{
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let sections = try decoder.decode([Section].self, from: data)
            completion(sections, nil)
        }catch{
            completion(nil, "something went Wrong")
        }
    }
}
