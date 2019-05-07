//
//  ReactorViewController.swift
//  Chemistry
//
//  Created by Pavel Kasila on 5/4/19.
//  Copyright © 2019 Pavel Kosilo. All rights reserved.
//

import Foundation
import UIKit
import BLTNBoard

typealias DialogRequest = ((_ item:BLTNActionItem) -> ())

class ReactionCalculatorViewController : UIViewController {
    var reactants = Array(repeating: "", count: 64)
    var products = Array(repeating: "", count: 64)
    var isAqueous = false
    
    var ctrParse = 0
    
    var hydBalNumber = 0.0
    var chemBalNumber = 0.0
    var skipChar = false
    var skipChar2 = false
    var skipChar3 = false
    var elemMolarMass = 0.0
    var brackMolarMass = 0.0
    var hydMolarMass = 0.0
    var chemMolarMass = 0.0
    var elemInBrack = false
    var elemInHyd = false
    var charForIon = false
    
    var fixedChemName = ""
    var fixedChemMol = 0.0
    var fixedChemMass = 0.0
    var fixedChemConc = 0.0
    var fixedChemVol = 0.0
    var fixedChemFound = false
    
    var calcMode = 0
    var fixedLoc = 0
    var chemMass = 0.0
    var chemMassStr = ""
    var chemVol = 0.0
    var chemVolStr = ""
    var chemicalFormatted = ""
    
    var analysis = Array(repeating: "", count: 2)
    var reactsMass = 0.0
    var prodsMass = 0.0
    var diffMass = 0.0
    var diffMassStr = ""
    
    var inDarkMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func dialogAlert(title: String, content: String, okAction: @escaping DialogRequest) {
        let page = BLTNPageItem(title: title)
        
        page.descriptionText = content
        page.actionButtonTitle = NSLocalizedString("Continue", comment: "")
        page.requiresCloseButton = false
        
        page.actionHandler = okAction
        
        let manager = BLTNItemManager(rootItem: page)
        manager.showBulletin(above: self)
    }
    
    func dialogContCanc(title: String, content: String, okAction: @escaping DialogRequest, failAction: @escaping DialogRequest) {
        let page = BLTNPageItem(title: title)
        
        page.descriptionText = content
        page.actionButtonTitle = NSLocalizedString("Continue", comment: "")
        page.actionButtonTitle = NSLocalizedString("Cancel", comment: "")
        page.requiresCloseButton = false
        
        page.actionHandler = okAction
        page.alternativeHandler = failAction
        
        let manager = BLTNItemManager(rootItem: page)
        manager.showBulletin(above: self)
    }
    
    func dialogAnalysis(title: String, content: String, okAction: @escaping DialogRequest) {
        let page = BLTNPageItem(title: title)
        
        page.descriptionText = content
        page.actionButtonTitle = NSLocalizedString("Continue", comment: "")
        page.requiresCloseButton = false
        
        page.actionHandler = okAction
        
        let manager = BLTNItemManager(rootItem: page)
        manager.showBulletin(above: self)
    }
    
    func Crop(input: String, from: Int, length: Int) -> String! {
        let startIndex = input.index(input.startIndex, offsetBy: from)
        
        var result = input.substring(from: startIndex)
        
        let endIndex = result.index(result.startIndex, offsetBy: length)
        result = result.substring(to: endIndex)
        
        return result
    }
    
    func Parse(input: String, isReactant: Bool) {
        ctrParse = 0
        charForIon = false
        
        for i in 0...(input.count - 1) {
            if Crop(input: input, from: i, length: 1) == "[" {
                charForIon = true
            } else if Crop(input: input, from: i, length: 1) == "]" {
                charForIon = false
            }
            
            if Crop(input: input, from: i, length: 1) == "+" && charForIon == false {
                ctrParse += 1
            } else if Crop(input: input, from: i, length: 1) != " " {
                if isReactant {
                    reactants[ctrParse] += Crop(input: input, from: i, length: 1)
                } else {
                    products[ctrParse] += Crop(input: input, from: i, length: 1)
                }
            }
        }
    }
    
    func GetMolarMass(chemical: String) -> Double {
        func GetBalNumber(from: Int) {
            if Double(Crop(input: chemical, from: from, length: 1)) != nil {
                if chemical.count > 1 {
                    if Double(Crop(input: chemical, from: from + 1, length: 1)) != nil {
                        if elemInHyd {
                            hydBalNumber = (Double(Crop(input: chemical, from: from, length: 1))!) * 10 + Double(Crop(input: chemical, from: from + 1, length: 1))!
                        } else {
                            chemBalNumber = (Double(Crop(input: chemical, from: from, length: 1))!) * 10 + Double(Crop(input: chemical, from: from + 1, length: 1))!
                        }
                        
                        skipChar2 = true
                    } else {
                        if elemInHyd {
                            hydBalNumber = Double(Crop(input: chemical, from: from, length: 1))!
                        } else {
                            chemBalNumber = Double(Crop(input: chemical, from: from, length: 1))!
                        }
                        
                        skipChar = true
                    }
                } else {
                    if elemInHyd {
                        hydBalNumber = Double(Crop(input: chemical, from: from, length: 1))!
                    } else {
                        chemBalNumber = Double(Crop(input: chemical, from: from, length: 1))!
                    }
                    
                    skipChar = true
                }
            }
        }
        
        hydBalNumber = 1
        chemBalNumber = 1
        skipChar = false
        skipChar2 = false
        skipChar3 = false
        elemMolarMass = 0
        brackMolarMass = 0
        hydMolarMass = 0
        chemMolarMass = 0
        elemInBrack = false
        elemInHyd = false
        charForIon = false
        
        GetBalNumber(from: 0)
        
        for i in 0...(chemical.count - 1) {
            if (!skipChar && !skipChar2 && !skipChar3 && !charForIon) {
                switch Crop(input: chemical, from: i, length: 1) {
                case "(":
                    elemInBrack = true
                    
                case ")":
                    if chemical.count > i + 1 {
                        if Int(Crop(input: chemical, from: i + 1, length: 1)) != nil {
                            if chemical.count > i + 2 {
                                if Int(Crop(input: chemical, from: i + 2, length: 1)) != nil {
                                    brackMolarMass *= (Double(Crop(input: chemical, from: i + 1, length: 1))!) * 10 + Double(Crop(input: chemical, from: i + 2, length: 1))!
                                    skipChar2 = true
                                } else {
                                    brackMolarMass *= Double(Crop(input: chemical, from: i + 1, length: 1))!
                                    skipChar = true
                                }
                            } else {
                                brackMolarMass *= Double(Crop(input: chemical, from: i + 1, length: 1))!
                                skipChar = true
                            }
                        }
                    }
                    
                    elemInBrack = false
                    chemMolarMass += brackMolarMass
                    brackMolarMass = 0
                    
                case ".":
                    elemInHyd = true
                    
                    if chemical.count > i + 1 {
                        GetBalNumber(from: i + 1)
                    }
                    
                case "[":
                    charForIon = true
                    
                case "]":
                    charForIon = false
                    
                case "A":
                    if chemical.count > i + 1 {
                        switch Crop(input: chemical, from: i + 1, length: 1) {
                        case "c":
                            elemMolarMass += 227.0277
                            skipChar = true
                        case "g":
                            elemMolarMass += 107.8682
                            skipChar = true
                        case "l":
                            elemMolarMass += 26.9815
                            skipChar = true
                        case "m":
                            elemMolarMass += 241.0568
                            skipChar = true
                        case "r":
                            elemMolarMass += 39.9840
                            skipChar = true
                        case "s":
                            elemMolarMass += 74.9216
                            skipChar = true
                        case "t":
                            elemMolarMass += 209.9871
                            skipChar = true
                        case "u":
                            elemMolarMass += 196.9665
                            skipChar = true
                        default:
                            break
                        }
                    }
                    
                case "B":
                    if chemical.count > i + 1 {
                        switch Crop(input: chemical, from: i + 1, length: 1) {
                        case "a":
                            elemMolarMass += 137.3270
                            skipChar = true
                        case "e":
                            elemMolarMass += 9.0122
                            skipChar = true
                        case "h":
                            elemMolarMass += 272.1380
                            skipChar = true
                        case "i":
                            elemMolarMass += 208.9084
                            skipChar = true
                        case "k":
                            elemMolarMass += 247.0703
                            skipChar = true
                        case "r":
                            elemMolarMass += 79.9040
                            skipChar = true
                        default:
                            elemMolarMass += 10.8110
                        }
                    } else {
                        elemMolarMass += 10.8110
                    }
                    
                case "C":
                    if chemical.count > i + 1 {
                        switch Crop(input: chemical, from: i + 1, length: 1) {
                        case "a":
                            elemMolarMass += 40.0780
                            skipChar = true
                        case "d":
                            elemMolarMass += 112.4110
                            skipChar = true
                        case "e":
                            elemMolarMass += 140.1160
                            skipChar = true
                        case "f":
                            elemMolarMass += 249.0749
                            skipChar = true
                        case "l":
                            elemMolarMass += 35.4530
                            skipChar = true
                        case "m":
                            elemMolarMass += 243.0614
                            skipChar = true
                        case "n":
                            elemMolarMass += 285.1741
                            skipChar = true
                        case "o":
                            elemMolarMass += 53.9332
                            skipChar = true
                        case "r":
                            elemMolarMass += 51.9961
                            skipChar = true
                        case "s":
                            elemMolarMass += 132.9055
                            skipChar = true
                        case "u":
                            elemMolarMass += 53.9640
                            skipChar = true
                        default:
                            elemMolarMass += 12.0107
                        }
                    } else {
                        elemMolarMass += 12.0107
                    }
                    
                case "D":
                    if chemical.count > i + 1 {
                        switch Crop(input: chemical, from: i + 1, length: 1) {
                        case "b":
                            elemMolarMass += 268.1255
                            skipChar = true
                        case "s":
                            elemMolarMass += 281.1621
                            skipChar = true
                        case "y":
                            elemMolarMass += 162.5000
                            skipChar = true
                        default:
                            break
                        }
                    }
                    
                case "E":
                    if chemical.count > i + 1 {
                        switch Crop(input: chemical, from: i + 1, length: 1) {
                        case "r":
                            elemMolarMass += 167.2590
                            skipChar = true
                            break
                        case "s":
                            elemMolarMass += 252.0830
                            skipChar = true
                            break
                        case "u":
                            elemMolarMass += 151.9640
                            skipChar = true
                            break
                        default:
                            break
                        }
                    }
                    
                case "F":
                    if chemical.count > i + 1 {
                        switch Crop(input: chemical, from: i + 1, length: 1) {
                        case "e":
                            elemMolarMass += 55.8450
                            skipChar = true
                        case "l":
                            elemMolarMass += 289.1873
                            skipChar = true
                        case "m":
                            elemMolarMass += 257.0951
                            skipChar = true
                        case "r":
                            elemMolarMass += 223.0917
                            skipChar = true
                        default:
                            elemMolarMass += 18.9984
                        }
                    } else {
                        elemMolarMass += 18.9984
                    }
                    
                case "G":
                    if chemical.count > i + 1 {
                        switch Crop(input: chemical, from: i + 1, length: 1) {
                        case "a":
                            elemMolarMass += 69.7230
                            skipChar = true
                        case "d":
                            elemMolarMass += 157.2500
                            skipChar = true
                        case "e":
                            elemMolarMass += 72.6400
                            skipChar = true
                        default:
                            break
                        }
                    }
                    
                case "H":
                    if chemical.count > i + 1 {
                        switch Crop(input: chemical, from: i + 1, length: 1) {
                        case "e":
                            elemMolarMass += 4.0026
                            skipChar = true
                        case "f":
                            elemMolarMass += 178.4900
                            skipChar = true
                        case "g":
                            elemMolarMass += 200.5900
                            skipChar = true
                        case "o":
                            elemMolarMass += 164.9303
                            skipChar = true
                        case "s":
                            elemMolarMass += 270.1347
                            skipChar = true
                        default:
                            elemMolarMass += 1.0079
                        }
                    } else {
                        elemMolarMass += 1.0079
                    }
                    
                case "I":
                    if chemical.count > i + 1 {
                        switch Crop(input: chemical, from: i + 1, length: 1) {
                        case "n":
                            elemMolarMass += 114.8180
                            skipChar = true
                        case "r":
                            elemMolarMass += 192.2170
                            skipChar = true
                        default:
                            elemMolarMass += 126.9045
                        }
                    } else {
                        elemMolarMass += 126.9045
                    }
                    
                case "K":
                    if chemical.count > i + 1 {
                        switch Crop(input: chemical, from: i + 1, length: 1) {
                        case "r":
                            elemMolarMass += 83.7980
                            skipChar = true
                        default:
                            elemMolarMass += 39.0983
                        }
                    } else {
                        elemMolarMass += 39.0983
                    }
                    
                case "L":
                    if chemical.count > i + 1 {
                        switch Crop(input: chemical, from: i + 1, length: 1) {
                        case "a":
                            elemMolarMass += 138.9055
                            skipChar = true
                        case "i":
                            elemMolarMass += 6.9410
                            skipChar = true
                        case "r":
                            elemMolarMass += 262.1096
                            skipChar = true
                        case "u":
                            elemMolarMass += 174.9668
                            skipChar = true
                        default:
                            break
                        }
                    }
                    
                case "M":
                    if chemical.count > i + 1 {
                        switch Crop(input: chemical, from: i + 1, length: 1) {
                        case "d":
                            elemMolarMass += 258.0983
                            skipChar = true
                        case "g":
                            elemMolarMass += 24.3050
                            skipChar = true
                        case "n":
                            elemMolarMass += 54.9380
                            skipChar = true
                        case "o":
                            elemMolarMass += 95.9600
                            skipChar = true
                        case "t":
                            elemMolarMass += 276.1512
                            skipChar = true
                        default:
                            break
                        }
                    }
                    
                case "N":
                    if chemical.count > i + 1 {
                        switch Crop(input: chemical, from: i + 1, length: 1) {
                        case "a":
                            elemMolarMass += 22.9898
                            skipChar = true
                        case "b":
                            elemMolarMass += 92.9064
                            skipChar = true
                        case "d":
                            elemMolarMass += 144.242
                            skipChar = true
                        case "e":
                            elemMolarMass += 20.1797
                            skipChar = true
                        case "i":
                            elemMolarMass += 58.6934
                            skipChar = true
                        case "o":
                            elemMolarMass += 259.1010
                            skipChar = true
                        case "p":
                            elemMolarMass += 236.0466
                            skipChar = true
                        default:
                            elemMolarMass += 14.0067
                        }
                    } else {
                        elemMolarMass += 14.0067
                    }
                    
                case "O":
                    if chemical.count > i + 1 {
                        switch Crop(input: chemical, from: i + 1, length: 1) {
                        case "s":
                            elemMolarMass += 190.2300
                            skipChar = true
                        default:
                            elemMolarMass += 15.9994
                        }
                    } else {
                        elemMolarMass += 15.9994
                    }
                    
                case "P":
                    if chemical.count > i + 1 {
                        switch Crop(input: chemical, from: i + 1, length: 1) {
                        case "a":
                            elemMolarMass += 231.0359
                            skipChar = true
                        case "b":
                            elemMolarMass += 207.2000
                            skipChar = true
                        case "d":
                            elemMolarMass += 106.4200
                            skipChar = true
                        case "m":
                            elemMolarMass += 144.9127
                            skipChar = true
                        case "o":
                            elemMolarMass += 208.9824
                            skipChar = true
                        case "r":
                            elemMolarMass += 140.9077
                            skipChar = true
                        case "t":
                            elemMolarMass += 195.0840
                            skipChar = true
                        case "u":
                            elemMolarMass += 238.0496
                            skipChar = true
                        default:
                            elemMolarMass += 30.9738
                        }
                    } else {
                        elemMolarMass += 30.9738
                    }
                    
                case "R":
                    if chemical.count > i + 1 {
                        switch Crop(input: chemical, from: i + 1, length: 1) {
                        case "a":
                            elemMolarMass += 223.0185
                            skipChar = true
                        case "b":
                            elemMolarMass += 85.4678
                            skipChar = true
                        case "e":
                            elemMolarMass += 186.2070
                            skipChar = true
                        case "f":
                            elemMolarMass += 265.1167
                            skipChar = true
                        case "g":
                            elemMolarMass += 280.1645
                            skipChar = true
                        case "h":
                            elemMolarMass += 102.9055
                            skipChar = true
                        case "n":
                            elemMolarMass += 210.9906
                            skipChar = true
                        case "u":
                            elemMolarMass += 101.0700
                            skipChar = true
                        default:
                            break
                        }
                    }
                    
                case "S":
                    if chemical.count > i + 1 {
                        switch Crop(input: chemical, from: i + 1, length: 1) {
                        case "b":
                            elemMolarMass += 121.7600
                            skipChar = true
                        case "c":
                            elemMolarMass += 44.9559
                            skipChar = true
                        case "e":
                            elemMolarMass += 78.9600
                            skipChar = true
                        case "g":
                            elemMolarMass += 271.1335
                            skipChar = true
                        case "i":
                            elemMolarMass += 28.0855
                            skipChar = true
                        case "m":
                            elemMolarMass += 150.3600
                            skipChar = true
                        case "n":
                            elemMolarMass += 118.7100
                            skipChar = true
                        case "r":
                            elemMolarMass += 87.6200
                            skipChar = true
                        default:
                            elemMolarMass += 32.0650
                        }
                    } else {
                        elemMolarMass += 32.0650
                    }
                    
                case "T":
                    if chemical.count > i + 1 {
                        switch Crop(input: chemical, from: i + 1, length: 1) {
                        case "a":
                            elemMolarMass += 180.9479
                            skipChar = true
                        case "b":
                            elemMolarMass += 158.9254
                            skipChar = true
                        case "c":
                            elemMolarMass += 96.9064
                            skipChar = true
                        case "e":
                            elemMolarMass += 127.6000
                            skipChar = true
                        case "h":
                            elemMolarMass += 232.0381
                            skipChar = true
                        case "i":
                            elemMolarMass += 47.8670
                            skipChar = true
                        case "l":
                            elemMolarMass += 204.3383
                            skipChar = true
                        case "m":
                            elemMolarMass += 168.9342
                            skipChar = true
                        case "s":
                            elemMolarMass += 292.2080
                            skipChar = true
                        default:
                            break
                        }
                    }
                    
                case "U":
                    elemMolarMass += 238.0289
                    
                case "V":
                    elemMolarMass += 50.9415
                    
                case "W":
                    elemMolarMass += 183.8400
                    
                case "X":
                    elemMolarMass += 131.2930
                    
                case "Y":
                    if chemical.count > i + 1 {
                        switch Crop(input: chemical, from: i + 1, length: 1) {
                        case "b":
                            elemMolarMass += 173.0540
                            skipChar = true
                        default:
                            elemMolarMass += 88.9059
                        }
                    } else {
                        elemMolarMass += 88.9059
                    }
                    
                case "Z":
                    if chemical.count > i + 1 {
                        switch Crop(input: chemical, from: i + 1, length: 1) {
                        case "n":
                            elemMolarMass += 65.3800
                            skipChar = true
                        case "r":
                            elemMolarMass += 91.2240
                            skipChar = true
                        default:
                            break
                        }
                    }
                default:
                    break
                }
                
                if chemical.count > i + 1 {
                    if Double(Crop(input: chemical, from: i + 1, length: 1)) != nil {
                        if chemical.count > i + 2 {
                            if Double(Crop(input: chemical, from: i + 2, length: 1)) != nil {
                                elemMolarMass *= (Double(Crop(input: chemical, from: i + 1, length: 1))!) * 10 + Double(Crop(input: chemical, from: i + 2, length: 1))!
                                skipChar2 = true
                            } else {
                                elemMolarMass *= Double(Crop(input: chemical, from: i + 1, length: 1))!
                                skipChar = true
                            }
                        } else {
                            elemMolarMass *= Double(Crop(input: chemical, from: i + 1, length: 1))!
                            skipChar = true
                        }
                    }
                }
            } else if skipChar3 {
                skipChar3 = false
                skipChar2 = true
                skipChar = false
            } else if skipChar2 {
                skipChar2 = false
                skipChar = true
            } else {
                skipChar = false
                
                if chemical.count > i + 1 {
                    if Double(Crop(input: chemical, from: i + 1, length: 1)) != nil {
                        if chemical.count > i + 2 {
                            if Double(Crop(input: chemical, from: i + 2, length: 1)) != nil {
                                elemMolarMass *= (Double(Crop(input: chemical, from: i + 1, length: 1))!) * 10 + Double(Crop(input: chemical, from: i + 2, length: 1))!
                                skipChar2 = true
                            } else {
                                elemMolarMass *= Double(Crop(input: chemical, from: i + 1, length: 1))!
                                skipChar = true
                            }
                        } else {
                            elemMolarMass *= Double(Crop(input: chemical, from: i + 1, length: 1))!
                            skipChar = true
                        }
                    }
                }
            }
            
            if !skipChar && !skipChar2 && !skipChar3 {
                if elemInBrack {
                    brackMolarMass += elemMolarMass
                } else if elemInHyd {
                    hydMolarMass += elemMolarMass
                } else {
                    chemMolarMass += elemMolarMass
                }
                
                elemMolarMass = 0
            }
        }
        
        chemMolarMass *= chemBalNumber
        chemMolarMass += hydBalNumber * hydMolarMass
        
        return chemMolarMass
    }
    
    func Identify(chemical: String) -> String {
        fixedChemName = ""
        skipChar = false
        
        if chemical != "" {
            for i in 0...(chemical.count - 1) {
                if i == 0 && Double(Crop(input: chemical, from: i, length: 1)) != nil {
                    if chemical.count > i + 1 {
                        if Double(Crop(input: chemical, from: i + 1, length: 1)) != nil {
                            skipChar = true
                        } else {
                            skipChar = false
                        }
                    }
                } else {
                    if skipChar {
                        skipChar = false
                    } else {
                        fixedChemName += Crop(input: chemical, from: i, length: 1)
                    }
                }
            }
        }
        
        return fixedChemName
    }
    
    /*func FindFixAmount(chemical: String) -> Double {
        if chemical != "" {
            if Identify(chemical: chemical) == txtFixChemical.stringValue {
                switch calcMode {
                case 1:
                    fixedChemMass = Double(txtFixAmount.stringValue)!
                    fixedChemMol = fixedChemMass / GetMolarMass(chemical: chemical)
                case 2:
                    fixedChemMol = Double(txtFixAmount.stringValue)!
                    fixedChemMass = fixedChemMol * GetMolarMass(chemical: chemical)
                case 3:
                    fixedChemConc = Double(txtFixConc.stringValue)!
                    fixedChemVol = Double(txtFixVol.stringValue)!
                    fixedChemMol = fixedChemConc * fixedChemVol / 1000
                    fixedChemMass = fixedChemMol * GetMolarMass(chemical: chemical)
                case 4:
                    fixedChemConc = Double(txtFixConc.stringValue)!
                    fixedChemVol = Double(txtFixVol.stringValue)!
                    fixedChemMol = fixedChemConc * fixedChemVol
                    fixedChemMass = fixedChemMol * GetMolarMass(chemical: chemical)
                default:
                    break
                }
                
                fixedChemFound = true
            }
        }
        
        return fixedChemMol
    }
    
    func PrintReactantMass(chemical: String) {
        chemMass = 0
        chemVol = 0
        
        if chemical != "" {
            chemMass = fixedChemMol * GetMolarMass(chemical: chemical)
            chemMassStr = String(round(chemMass * 1000) / 1000)
            chemVol = chemMass / GetMolarMass(chemical: Identify(chemical: chemical)) * 1000
            chemVolStr = String(round(chemVol * 1000) / 1000)
            chemicalFormatted = Identify(chemical: chemical)
            
            if calcMode == 1 || calcMode == 2 {
                analysis[0] = "You need " + chemMassStr + " grams of "
                analysis[1] = chemicalFormatted + "." + "\n"
                
                txtAnalysis.stringValue += analysis[0] + analysis[1]
            } else if calcMode == 3 || calcMode == 4 {
                analysis[0] = "You need " + chemMassStr + " grams of " + chemicalFormatted + ", or "
                analysis[1] = chemVolStr + " cm3 of 1M " + chemicalFormatted + "." + "\n"
                
                txtAnalysis.stringValue += analysis[0] + analysis[1]
            }
            
            reactsMass += chemMass
        }
    }
    
    func PrintProductMass(chemical: String) {
        chemMass = 0
        chemVol = 0
        
        if chemical != "" {
            chemMass = fixedChemMol * GetMolarMass(chemical: chemical)
            chemMassStr = String(round(chemMass * 1000) / 1000)
            chemVol = chemMass / GetMolarMass(chemical: Identify(chemical: chemical)) * 1000
            chemVolStr = String(round(chemVol * 1000) / 1000)
            chemicalFormatted = Identify(chemical: chemical)
            
            if calcMode == 1 || calcMode == 2 {
                analysis[0] = "You produce " + chemMassStr + " grams of "
                analysis[1] = chemicalFormatted + "." + "\n"
                
                txtAnalysis.stringValue += analysis[0] + analysis[1]
            } else if calcMode == 3 || calcMode == 4 {
                analysis[0] = "You produce " + chemMassStr + " grams of " + chemicalFormatted + ", or "
                analysis[1] = chemVolStr + " cm3 of 1M " + chemicalFormatted + "." + "\n"
                
                txtAnalysis.stringValue += analysis[0] + analysis[1]
            }
            
            prodsMass += chemMass
        }
    }
    
    @IBAction func btnAqueous(_ sender: UIButton) {
        switch sender.state {
        case .on:
            isAqueous = true
            txtFixAmount.isEnabled = false
            txtFixAmount.stringValue = ""
            txtFixConc.isEnabled = true
            txtFixVol.isEnabled = true
        case .off:
            isAqueous = false
            txtFixConc.isEnabled = false
            txtFixConc.stringValue = ""
            txtFixVol.isEnabled = false
            txtFixVol.stringValue = ""
            txtFixAmount.isEnabled = true
        default:
            isAqueous = true
            txtFixAmount.isEnabled = false
            txtFixAmount.stringValue = ""
            txtFixConc.isEnabled = true
            txtFixVol.isEnabled = true
        }
    }
    
    @IBAction func rbtnUnits(_ sender: UIButton) {
        switch sender.title {
        case "mol":
            calcMode = 2
        case "cm3":
            calcMode = 3
        case "dm3":
            calcMode = 4
        default:
            calcMode = 1
        }
    }
    
    @IBAction func btnAnalyse(_ sender: UIButton) {
        if txtReactants.stringValue == "" {
            dialogAlert(title: "Analyse", content: "Please enter the reactants of your chemical reaction.", okAction: {
                (item: BLTNActionItem) in
                return
            })
        } else if txtProducts.stringValue == "" {
            dialogAlert(title: "Analyse", content: "Please enter the products of your chemical reaction.", okAction: {
                (item: BLTNActionItem) in
                return
            })
        } else if txtFixChemical.stringValue == "" {
            dialogAlert(title: "Analyse", content: "Please enter the chemical that you want to fix or know the amount of in the toggles.", okAction: {
                (item: BLTNActionItem) in
                return
            })
        } else if txtFixAmount.stringValue == "" && (txtFixConc.stringValue == "" || txtFixVol.stringValue == "") {
            dialogAlert(title: "Analyse", content: "Please enter the amount of the chemical that you want to fix in the toggles.", okAction: {
                (item: BLTNActionItem) in
                return
            })
        } else if calcMode == 0 {
            dialogAlert(title: "Analyse", content: "Please specify what units your numbers are in by clicking on the radio buttons.", okAction: {
                (item: BLTNActionItem) in
                return
            })
        } else {
            for i in 0...63 {
                reactants[i] = ""
                products[i] = ""
            }
            
            fixedChemFound = false
            fixedLoc = 0
            
            reactsMass = 0
            prodsMass = 0
            diffMass = 0
            diffMassStr = ""
            txtAnalysis.stringValue = ""
            
            Parse(input: txtReactants.stringValue, isReactant: true)
            Parse(input: txtProducts.stringValue, isReactant: false)
            
            for i in 0...63 {
                FindFixAmount(chemical: reactants[i])
            }
            if fixedChemFound {
                fixedLoc = 1
            } else {
                fixedLoc = 2
                
                for i in 0...63 {
                    FindFixAmount(chemical: products[i])
                }
            }
            
            chemicalFormatted = Identify(chemical: txtFixChemical.stringValue)
            
            if fixedLoc == 1 {
                if calcMode == 1 {
                    analysis[0] = "You have " + String(fixedChemMass) + " grams of "
                    analysis[1] = chemicalFormatted + "." + "\n" + "\n"
                    
                    txtAnalysis.stringValue = analysis[0] + analysis[1]
                } else if calcMode == 2 {
                    analysis[0] = "You have " + String(fixedChemMol) + " moles of "
                    analysis[1] = chemicalFormatted + "." + "\n" + "\n"
                    
                    txtAnalysis.stringValue = analysis[0] + analysis[1]
                } else if calcMode == 3 {
                    analysis[0] = "You have " + String(fixedChemVol) + " cm3 of " + String(fixedChemConc)
                    analysis[1] = " mol dm-3 " + chemicalFormatted + "." + "\n" + "\n"
                    
                    txtAnalysis.stringValue = analysis[0] + analysis[1]
                } else if calcMode == 4 {
                    analysis[0] = "You have " + String(fixedChemVol) + " dm3 of " + String(fixedChemConc)
                    analysis[1] = " mol dm-3 " + chemicalFormatted + "." + "\n" + "\n"
                    
                    txtAnalysis.stringValue = analysis[0] + analysis[1]
                }
            } else if fixedLoc == 2 {
                if calcMode == 1 {
                    analysis[0] = "You want " + String(fixedChemMass) + " grams of "
                    analysis[1] = chemicalFormatted + "." + "\n" + "\n"
                    
                    txtAnalysis.stringValue = analysis[0] + analysis[1]
                } else if calcMode == 2 {
                    analysis[0] = "You want " + String(fixedChemMol) + " moles of "
                    analysis[1] = chemicalFormatted + "." + "\n" + "\n"
                    
                    txtAnalysis.stringValue = analysis[0] + analysis[1]
                } else if calcMode == 3 {
                    analysis[0] = "You want " + String(fixedChemVol) + " cm3 of " + String(fixedChemConc)
                    analysis[1] = " mol dm-3 " + chemicalFormatted + "." + "\n" + "\n"
                    
                    txtAnalysis.stringValue = analysis[0] + analysis[1]
                } else if calcMode == 4 {
                    analysis[0] = "You want " + String(fixedChemVol) + " dm3 of " + String(fixedChemConc)
                    analysis[1] = " mol dm-3 " + chemicalFormatted + "." + "\n" + "\n"
                    
                    txtAnalysis.stringValue = analysis[0] + analysis[1]
                }
            }
            
            for i in 0...63 {
                PrintReactantMass(chemical: reactants[i])
            }
            
            for i in 0...63 {
                PrintProductMass(chemical: products[i])
            }
            
            diffMass = prodsMass - reactsMass
            diffMassStr = String(round(abs(diffMass) * 1000) / 1000)
            
            
            if Int(diffMass) < 0 {
                txtAnalysis.stringValue += "\nThe mass of all reactants is more than the mass of all products by " + diffMassStr + " grams. This reaction is impossible. Make sure your equation is fully balanced and all chemicals are entered in correctly."
            } else if Int(diffMass) > 0 {
                txtAnalysis.stringValue += "\nThe mass of all reactants is less than the mass of all products by " + diffMassStr + " grams. This reaction is impossible. Make sure your equation is fully balanced and all chemicals are entered in correctly."
            }
        }
    }
    
    @IBAction func btnClearAll(_ sender: UIButton) {
        dialogContCanc(title: "Would you like to clear all your calculations?", content: "Make sure you don't have anything you need on here.", okAction: { (item: BLTNActionItem) in
            for i in 0...63 {
                self.reactants[i] = ""
                self.products[i] = ""
            }
            
            self.txtReactants.stringValue = ""
            self.txtProducts.stringValue = ""
            
            self.txtFixChemical.stringValue = ""
            self.txtFixAmount.stringValue = ""
            self.txtFixConc.stringValue = ""
            self.txtFixVol.stringValue = ""
            
            self.txtAnalysis.stringValue = ""
        }, failAction: {
            (item: BLTNActionItem) in
            return
        })
    }
    
    @IBAction func btnUpdate(_ sender: UIButton) {
        dialogContCanc(title: "Would you like to check for software updates on GitHub?", content: "You are currently running Version 1.3.", okAction: { (item: BLTNActionItem) in
            UIApplication.shared.open(URL(string: "https://github.com/jyjulianwong/chemicalReactionCalculator_macOS/releases")!)
        }, failAction: {
            (item: BLTNActionItem) in
            return
        })
    }*/
}
