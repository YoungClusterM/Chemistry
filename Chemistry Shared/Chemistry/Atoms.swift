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

class Atom {
    var pm : Float
    #if os(iOS) || os(watchOS) || os(tvOS)
    var color : UIColor
    #elseif os(OSX)
    var color : NSColor
    #endif
    var wikipedia : String
    var num : Int8
    
    #if os(iOS) || os(watchOS) || os(tvOS)
    init(pm: Float, color: UIColor, num: Int8, wikipedia: String) {
        self.pm = pm
        self.color = color
        self.num = num
        self.wikipedia = wikipedia
    }
    #elseif os(OSX)
    init(pm: Float, color: NSColor, num: Int8, wikipedia: String) {
        self.pm = pm
        self.color = color
        self.num = num
        self.wikipedia = wikipedia
    }
    #endif
    
    func draw() -> SCNSphere {
        let atom = SCNSphere(radius: CGFloat(self.pm / 100))
        atom.firstMaterial?.diffuse.contents  = self.color
        
        return atom
    }
    
    func getDescription() -> String {
        return ""
    }
}

let Atoms: [String:Atom] = [
    "H": Atom(pm: 53, color: .blue, num: 1, wikipedia: "Hydrogen"),
    "He": Atom(pm: 31, color: .blue, num: 2, wikipedia: "Helium"),
    "Li": Atom(pm: 152, color: .blue, num: 3, wikipedia: "Lithium"),
    "Be": Atom(pm: 112, color: .blue, num: 4, wikipedia: "Beryllium"),
    "B": Atom(pm: 85, color: .blue, num: 5, wikipedia: "Boron"),
    "C": Atom(pm: 70, color: .blue, num: 6, wikipedia: "Carbon"),
    "N": Atom(pm: 65, color: .blue, num: 7, wikipedia: "Nitrogen"),
    "O": Atom(pm: 60, color: .red, num: 8, wikipedia: "Oxygen"),
    "F": Atom(pm: 147, color: .green, num: 9, wikipedia: "Fluorine"),
    "Ne": Atom(pm: 38, color: .blue, num: 10, wikipedia: "Neon"),
    "Na": Atom(pm: 227, color: .blue, num: 11, wikipedia: "Sodium"),
    "Mg": Atom(pm: 173, color: .blue, num: 12, wikipedia: "Magnesium"),
    "Al": Atom(pm: 143, color: .blue, num: 13, wikipedia: "Aluminium"),
    "Si": Atom(pm: 111, color: .blue, num: 14, wikipedia: "Silicon"),
    "P": Atom(pm: 195, color: .blue, num: 15, wikipedia: "Phosphorus"),
    "S": Atom(pm: 100, color: .blue, num: 16, wikipedia: "Sulfur"),
    "Cl": Atom(pm: 175, color: .blue, num: 17, wikipedia: "Chlorine"),
    "Ar": Atom(pm: 71, color: .blue, num: 18, wikipedia: "Argon"),
    "K": Atom(pm: 280, color: .blue, num: 19, wikipedia: "Potassium"),
    "Ca": Atom(pm: 231, color: .blue, num: 20, wikipedia: "Calcium"),
    "Sc": Atom(pm: 230, color: .blue, num: 21, wikipedia: "Scandium"),
    "Ti": Atom(pm: 147, color: .blue, num: 22, wikipedia: "Titanium"),
    "V": Atom(pm: 205, color: .blue, num: 23, wikipedia: "Vanadium"),
    "Cr": Atom(pm: 128, color: .blue, num: 24, wikipedia: "Chromium"),
    "Mn": Atom(pm: 127, color: .blue, num: 25, wikipedia: "Manganese"),
    "Fe": Atom(pm: 126, color: .blue, num: 26, wikipedia: "Iron"),
    "Co": Atom(pm: 200, color: .blue, num: 27, wikipedia: "Cobalt"),
    "Ni": Atom(pm: 163, color: .blue, num: 28, wikipedia: "Nickel"),
    "Cu": Atom(pm: 128, color: .blue, num: 29, wikipedia: "Copper"),
    "Zn": Atom(pm: 139, color: .blue, num: 30, wikipedia: "Zinc"),
    "Ga": Atom(pm: 187, color: .blue, num: 31, wikipedia: "Gallium"),
    "Ge": Atom(pm: 211, color: .blue, num: 32, wikipedia: "Germanium"),
    "As": Atom(pm: 185, color: .blue, num: 33, wikipedia: "Arsenic"),
    "Se": Atom(pm: 120, color: .blue, num: 34, wikipedia: "Selenium"),
    "Br": Atom(pm: 185, color: .blue, num: 35, wikipedia: "Bromine"),
    "Kr": Atom(pm: 88, color: .blue, num: 36, wikipedia: "Krypton"),
    "Rb": Atom(pm: 248, color: .blue, num: 37, wikipedia: "Rubidium"),
    "Sr": Atom(pm: 200, color: .blue, num: 38, wikipedia: "Strontium"),
    "Y": Atom(pm: 180, color: .blue, num: 39, wikipedia: "Yttrium"),
    "Zr": Atom(pm: 230, color: .blue, num: 40, wikipedia: "Zirconium"),
    "Nb": Atom(pm: 215, color: .blue, num: 41, wikipedia: "Niobium"),
    "Mo": Atom(pm: 139, color: .blue, num: 42, wikipedia: "Molybdenum"),
    "Tc": Atom(pm: 205, color: .blue, num: 43, wikipedia: "Technetium"),
    "Ru": Atom(pm: 205, color: .blue, num: 44, wikipedia: "Ruthenium"),
    "Rh": Atom(pm: 200, color: .blue, num: 45, wikipedia: "Rhodium"),
    "Pd": Atom(pm: 163, color: .blue, num: 46, wikipedia: "Palladium"),
    "Ag": Atom(pm: 172, color: .blue, num: 47, wikipedia: "Silver"),
    "Cd": Atom(pm: 158, color: .blue, num: 48, wikipedia: "Cadmium"),
    "In": Atom(pm: 220, color: .blue, num: 49, wikipedia: "Indium"),
    "Sn": Atom(pm: 140, color: .blue, num: 50, wikipedia: "Tin"),
    "Sb": Atom(pm: 206, color: .blue, num: 51, wikipedia: "Antimony"),
    "Te": Atom(pm: 140, color: .blue, num: 52, wikipedia: "Tellurium"),
    "I": Atom(pm: 140, color: .blue, num: 53, wikipedia: "Iodine"),
    "Xe": Atom(pm: 108, color: .blue, num: 54, wikipedia: "Xenon"),
    "Cs": Atom(pm: 300, color: .blue, num: 55, wikipedia: "Cesium"),
    "Ba": Atom(pm: 268, color: .blue, num: 56, wikipedia: "Barium"),
    // Begin lanthanes
    "La": Atom(pm: 250, color: .blue, num: 57, wikipedia: "Lanthanum"),
    "Ce": Atom(pm: 181, color: .blue, num: 58, wikipedia: "Cerium"),
    "Pr": Atom(pm: 247, color: .blue, num: 59, wikipedia: "Praseodymium"),
    "Nd": Atom(pm: 229, color: .blue, num: 60, wikipedia: "Neodymium"),
    "Pm": Atom(pm: 243, color: .blue, num: 61, wikipedia: "Promethium"),
    "Sm": Atom(pm: 242, color: .blue, num: 62, wikipedia: "Samarium"),
    "Eu": Atom(pm: 240, color: .blue, num: 63, wikipedia: "Europium"),
    "Gd": Atom(pm: 180, color: .blue, num: 64, wikipedia: "Gadolinium"),
    "Tb": Atom(pm: 175, color: .blue, num: 65, wikipedia: "Terbium"),
    "Dy": Atom(pm: 235, color: .blue, num: 66, wikipedia: "Dysprosium"),
    "Ho": Atom(pm: 175, color: .blue, num: 67, wikipedia: "Holmium"),
    "Er": Atom(pm: 175, color: .blue, num: 68, wikipedia: "Erbium"),
    "Tm": Atom(pm: 230, color: .blue, num: 69, wikipedia: "Thulium"),
    "Yb": Atom(pm: 176, color: .blue, num: 70, wikipedia: "Ytterbium"),
    "Lu": Atom(pm: 227, color: .blue, num: 71, wikipedia: "Lutetium"),
    // End lanthanes
    "Hf": Atom(pm: 225, color: .blue, num: 72, wikipedia: "Hafnium"),
    "Ta": Atom(pm: 220, color: .blue, num: 73, wikipedia: "Tantalum"),
    "W": Atom(pm: 210, color: .blue, num: 74, wikipedia: "Tungsten"),
    "Re": Atom(pm: 137, color: .blue, num: 75, wikipedia: "Rhenium"),
    "Os": Atom(pm: 200, color: .blue, num: 76, wikipedia: "Osmium"),
    "Ir": Atom(pm: 200, color: .blue, num: 77, wikipedia: "Iridium"),
    "Pt": Atom(pm: 175, color: .blue, num: 78, wikipedia: "Platinum"),
    "Au": Atom(pm: 166, color: .blue, num: 79, wikipedia: "Gold"),
    "Hg": Atom(pm: 150, color: .blue, num: 80, wikipedia: "Mercury"),
    "Tl": Atom(pm: 220, color: .blue, num: 81, wikipedia: "Thallium"),
    "Pb": Atom(pm: 180, color: .blue, num: 82, wikipedia: "Lead"),
    "Bi": Atom(pm: 230, color: .blue, num: 83, wikipedia: "Bismuth"),
    "Po": Atom(pm: 190, color: .blue, num: 84, wikipedia: "Polonium"),
    "At": Atom(pm: 200, color: .blue, num: 85, wikipedia: "Astatine"),
    "Rn": Atom(pm: 134, color: .blue, num: 86, wikipedia: "Radon"),
    "Fr": Atom(pm: 348, color: .blue, num: 87, wikipedia: "Francium"),
    "Ra": Atom(pm: 200, color: .blue, num: 88, wikipedia: "Radium"),
    // Begin Actinides
    "Ac": Atom(pm: 200, color: .blue, num: 89, wikipedia: "Actinium"),
    "Th": Atom(pm: 240, color: .blue, num: 90, wikipedia: "Thorium"),
    "Pa": Atom(pm: 200, color: .blue, num: 91, wikipedia: "Protactinium"),
    "U": Atom(pm: 138, color: .blue, num: 92, wikipedia: "Uranium"),
    "Np": Atom(pm: 200, color: .blue, num: 93, wikipedia: "Neptunium"),
    "Pu": Atom(pm: 175, color: .blue, num: 94, wikipedia: "Plutonium"),
    "Am": Atom(pm: 200, color: .blue, num: 95, wikipedia: "Americium"),
    "Cm": Atom(pm: 200, color: .blue, num: 96, wikipedia: "Curium"),
    "Bk": Atom(pm: 297, color: .blue, num: 97, wikipedia: "Berkelium"),
    "Cf": Atom(pm: 295, color: .blue, num: 98, wikipedia: "Californium"),
    "Es": Atom(pm: 292, color: .blue, num: 99, wikipedia: "Einsteinium"),
    "Fm": Atom(pm: 290, color: .blue, num: 100, wikipedia: "Fermium"),
    "Md": Atom(pm: 287, color: .blue, num: 101, wikipedia: "Mendelevium"),
    "No": Atom(pm: 285, color: .blue, num: 102, wikipedia: "Nobelium"),
    "Lr": Atom(pm: 282, color: .blue, num: 103, wikipedia: "Lawrencium"),
    // End Actinides
    "Rf": Atom(pm: 200, color: .blue, num: 104, wikipedia: "Rutherfordium"),
    "Db": Atom(pm: 200, color: .blue, num: 105, wikipedia: "Dubnium"),
    "Sg": Atom(pm: 200, color: .blue, num: 106, wikipedia: "Seaborgium"),
    "Bh": Atom(pm: 200, color: .blue, num: 107, wikipedia: "Bohrium"),
    "Hs": Atom(pm: 200, color: .blue, num: 108, wikipedia: "Hassium"),
    "Mt": Atom(pm: 200, color: .blue, num: 109, wikipedia: "Meitnerium"),
    "Ds": Atom(pm: 200, color: .blue, num: 110, wikipedia: "Darmstadtium"),
    "Rg": Atom(pm: 200, color: .blue, num: 111, wikipedia: "Roentgenium"),
    "Cn": Atom(pm: 200, color: .blue, num: 112, wikipedia: "Copernicium"),
    "Nh": Atom(pm: 170, color: .blue, num: 113, wikipedia: "Nihonium"),
    "Fl": Atom(pm: 200, color: .blue, num: 114, wikipedia: "Flerovium"),
    "Mc": Atom(pm: 200, color: .blue, num: 115, wikipedia: "Moscovium"),
    "Lv": Atom(pm: 200, color: .blue, num: 116, wikipedia: "Livermorium"),
    "Ts": Atom(pm: 200, color: .blue, num: 117, wikipedia: "Tennessine"),
    "Og": Atom(pm: 152, color: .blue, num: 118, wikipedia: "Oganesson"),
]
