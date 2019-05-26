//
//  Atoms.swift
//  Chemistry
//
//  Created by Паша Косило on 10/21/18.
//  Copyright © 2018 Pavel Kosilo. All rights reserved.
//

import Foundation
import CoreGraphics
#if os(iOS) || os(watchOS) || os(tvOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif
import SceneKit

public class Atom {
    public var pm : Float
    public var atomMass : Float
    #if os(iOS) || os(watchOS) || os(tvOS)
    public var color : UIColor
    #elseif os(OSX)
    public var color : NSColor
    #endif
    public var wikipedia : String
    public var num : Int8
    
    #if os(iOS) || os(watchOS) || os(tvOS)
    public init(pm: Float, color: UIColor, num: Int8, wikipedia: String, atomMass: Float) {
        self.pm = pm
        self.color = color
        self.num = num
        self.wikipedia = wikipedia
        self.atomMass = atomMass
    }
    #elseif os(OSX)
    public init(pm: Float, color: NSColor, num: Int8, wikipedia: String, atomMass: Float) {
        self.pm = pm
        self.color = color
        self.num = num
        self.wikipedia = wikipedia
        self.atomMass = atomMass
    }
    #endif
    
    public func draw() -> SCNSphere {
        let atom = SCNSphere(radius: CGFloat(self.pm / 100))
        atom.firstMaterial?.diffuse.contents  = self.color
        
        return atom
    }
    
    func getDescription() -> String {
        return ""
    }
    
    public static func getAll() -> [String:Atom] {
        return Atoms
    }
}

public var Atoms: [String:Atom] = [:]
