//
//  Model.swift
//  iTune Search
//
//  Created by Ivan Caldwell on 12/5/18.
//  Copyright © 2018 Ivan Caldwell. All rights reserved.
//

import Foundation
import UIKit

class Model {
    static let shared = Model()
    private init() {}
    
    typealias UpdateHandler = () -> Void
    var updateHandler: UpdateHandler? = nil
    
    var result: [SearchResult] = [] {
        didSet {
            DispatchQueue.main.async {
                self.updateHandler?()
            }
        }
    }  

    func numberOfResults() -> Int {
        return result.count
    }
    
    func result(at index: Int) -> SearchResult {
        return result[index]
    }
    
    func search(for string: String, type: ResultType) {
        SearchResultController.performSearch(with: string, resultType: type) { result, error in
            if let error = error {
                NSLog("Error fetching result: \(error)")
                return
            }
 
            self.result = result ?? []
        }
    }
}
