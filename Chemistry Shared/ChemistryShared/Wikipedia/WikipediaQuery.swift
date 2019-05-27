//
//  WikipediaQuery.swift
//  ChemistryShared
//
//  Created by Pavel Kasila on 5/26/19.
//  Copyright © 2019 Pavel Kasila. All rights reserved.
//

import Foundation

public typealias WikipediaQueryCallback = (WikipediaQueryModel) -> Result<Void, Error>
public typealias WikipediaParseCallback = (WikipediaParseModel) -> Result<Void, Error>

public class WikipediaQuery {
    public init() {
        
    }
    
    public func getExtract(_ title: String) -> WikipediaQueryModel {
        do {
            let data = try Data(contentsOf: URL(string: "https://en.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&exintro&explaintext&redirects=1&titles=\(title)")!)
            
            let query = try JSONDecoder().decode(WikipediaQueryModel.self, from: data)
            
            return query
            
        } catch let error as NSError {
            fatalError("\(error)")
        }
    }
    
    public func getExtract(_ title: String, callback: WikipediaQueryCallback) -> Result<Void, Error> {
        return callback(self.getExtract(title))
    }
    
    public func getText(_ title: String) -> WikipediaParseModel {
        do {
            let data = try Data(contentsOf: URL(string: "https://en.wikipedia.org/w/api.php?action=parse&page=\(title)&prop=text&format=json")!)
            
            let query = try JSONDecoder().decode(WikipediaParseModel.self, from: data)
            
            return query
            
        } catch let error as NSError {
            fatalError("\(error)")
        }
    }
    
    public func getText(_ title: String, callback: WikipediaParseCallback) -> Result<Void, Error> {
        return callback(self.getText(title))
    }
}

public class WikipediaQueryModel: Encodable, Decodable {
    public var batchcomplete: String
    public var query: WikipediaQueryModelEntity
}

public class WikipediaParseModel: Encodable, Decodable {
    public var parse: WikipediaPageModel
}

public class WikipediaQueryModelEntity: Encodable, Decodable {
    public var pages: [String:WikipediaPageModel]
}

public class WikipediaPageModel: Encodable, Decodable {
    public var pageid: Int
    public var ns: Int?
    public var title: String
    public var extract: String?
    public var text: Dictionary<String, String>?
}
