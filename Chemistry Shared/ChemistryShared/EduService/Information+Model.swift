//
//  Information+Model.swift
//  ChemistryShared
//
//  Created by Pavel Kasila on 5/27/19.
//  Copyright © 2019 Pavel Kasila. All rights reserved.
//

import Foundation

public typealias EduServiceInformationCallback = (EduServiceInformationModel) -> Result<Void, Error>

public class EduServiceInformation {
    public init() {
        
    }
    
    public func getInformation() -> EduServiceInformationModel {
        do {
            #if DEBUG
            let url = URL(string: "https://eduservice-chemistry-dev.herokuapp.com/chemistry")!
            #else
            let url = URL(string: "https://eduservice-chemistry.herokuapp.com/chemistry")!
            #endif
            
            let data = try Data(contentsOf: url)
            
            let query = try JSONDecoder().decode(EduServiceInformationModel.self, from: data)
            
            return query
            
        } catch let error as NSError {
            fatalError("\(error)")
        }
    }
    
    public func getInformation(callback: EduServiceInformationCallback) -> Result<Void, Error> {
        return callback(self.getInformation())
    }
}

public class EduServiceInformationModel: Encodable, Decodable {
    public var title: String
    public var manifest: String
}
