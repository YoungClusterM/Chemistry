//
//  WikipediaQuery.swift
//  ChemistryShared
//
//  Created by Pavel Kasila on 5/26/19.
//  Copyright © 2019 Pavel Kasila. All rights reserved.
//

import Foundation

public class WikipediaQuery {
    public init() {
        
    }
    
    public func get(_ title: String) -> WikipediaQueryModel {
        do {
            let data = try Data(contentsOf: URL(string: "https://en.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&exintro&explaintext&redirects=1&titles=\(title)")!)
            
            let query = try JSONDecoder().decode(WikipediaQueryModel.self, from: data)
            
            return query
            
        } catch let error as NSError {
            fatalError("\(error)")
        }
    }
}

public class WikipediaQueryModel: Encodable, Decodable {
    public var batchcomplete: String
    public var query: WikipediaQueryModelEntity
}

public class WikipediaQueryModelEntity: Encodable, Decodable {
    public var pages: [String:WikpediaPageModel]
}

public class WikpediaPageModel: Encodable, Decodable {
    public var pageid: Int
    public var ns: Int
    public var title: String
    public var extract: String
}
