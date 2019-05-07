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
    init(pm: Float, color: UIColor, num: Int8, wikipedia: String, atomMass: Float) {
        self.pm = pm
        self.color = color
        self.num = num
        self.wikipedia = wikipedia
        self.atomMass = atomMass
    }
    #elseif os(OSX)
    init(pm: Float, color: NSColor, num: Int8, wikipedia: String, atomMass: Float) {
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

public let Atoms: [String:Atom] = [
    "H": Atom(pm: 53, color: .green, num: 1, wikipedia: "Hydrogen", atomMass: 1.00794),
    "He": Atom(pm: 31, color: .cyan, num: 2, wikipedia: "Helium", atomMass: 4.0026),
    "Li": Atom(pm: 152, color: .red, num: 3, wikipedia: "Lithium", atomMass: 6.941),
    "Be": Atom(pm: 112, color: .orange, num: 4, wikipedia: "Beryllium", atomMass: 9.0122),
    "B": Atom(pm: 85, color: .brown, num: 5, wikipedia: "Boron", atomMass: 10.811),
    "C": Atom(pm: 70, color: .green, num: 6, wikipedia: "Carbon", atomMass: 12.011),
    "N": Atom(pm: 65, color: .green, num: 7, wikipedia: "Nitrogen", atomMass: 14.007),
    "O": Atom(pm: 60, color: .green, num: 8, wikipedia: "Oxygen", atomMass: 15.9994),
    "F": Atom(pm: 147, color: .yellow, num: 9, wikipedia: "Fluorine", atomMass: 18.9984),
    "Ne": Atom(pm: 38, color: .cyan, num: 10, wikipedia: "Neon", atomMass: 20.1797),
    "Na": Atom(pm: 227, color: .red, num: 11, wikipedia: "Sodium", atomMass: 22.9898),
    "Mg": Atom(pm: 173, color: .orange, num: 12, wikipedia: "Magnesium", atomMass: 24.305),
    "Al": Atom(pm: 143, color: .gray, num: 13, wikipedia: "Aluminium", atomMass: 26.9815),
    "Si": Atom(pm: 111, color: .brown, num: 14, wikipedia: "Silicon", atomMass: 28.086),
    "P": Atom(pm: 195, color: .green, num: 15, wikipedia: "Phosphorus", atomMass: 30.9738),
    "S": Atom(pm: 100, color: .green, num: 16, wikipedia: "Sulfur", atomMass: 32.066),
    "Cl": Atom(pm: 175, color: .yellow, num: 17, wikipedia: "Chlorine", atomMass: 35.453),
    "Ar": Atom(pm: 71, color: .cyan, num: 18, wikipedia: "Argon", atomMass: 39.948),
    "K": Atom(pm: 280, color: .red, num: 19, wikipedia: "Potassium", atomMass: 39.0983),
    "Ca": Atom(pm: 231, color: .orange, num: 20, wikipedia: "Calcium", atomMass: 40.078),
    "Sc": Atom(pm: 230, color: .magenta, num: 21, wikipedia: "Scandium", atomMass: 44.956),
    "Ti": Atom(pm: 147, color: .magenta, num: 22, wikipedia: "Titanium", atomMass: 47.867),
    "V": Atom(pm: 205, color: .magenta, num: 23, wikipedia: "Vanadium", atomMass: 50.942),
    "Cr": Atom(pm: 128, color: .magenta, num: 24, wikipedia: "Chromium", atomMass: 51.996),
    "Mn": Atom(pm: 127, color: .magenta, num: 25, wikipedia: "Manganese", atomMass: 54.938),
    "Fe": Atom(pm: 126, color: .magenta, num: 26, wikipedia: "Iron", atomMass: 55.845),
    "Co": Atom(pm: 200, color: .magenta, num: 27, wikipedia: "Cobalt", atomMass: 58.933),
    "Ni": Atom(pm: 163, color: .magenta, num: 28, wikipedia: "Nickel", atomMass: 58.693),
    "Cu": Atom(pm: 128, color: .magenta, num: 29, wikipedia: "Copper", atomMass: 63.546),
    "Zn": Atom(pm: 139, color: .magenta, num: 30, wikipedia: "Zinc", atomMass: 65.406),
    "Ga": Atom(pm: 187, color: .gray, num: 31, wikipedia: "Gallium", atomMass: 69.723),
    "Ge": Atom(pm: 211, color: .brown, num: 32, wikipedia: "Germanium", atomMass: 72.64),
    "As": Atom(pm: 185, color: .brown, num: 33, wikipedia: "Arsenic", atomMass: 74.922),
    "Se": Atom(pm: 120, color: .green, num: 34, wikipedia: "Selenium", atomMass: 78.96),
    "Br": Atom(pm: 185, color: .yellow, num: 35, wikipedia: "Bromine", atomMass: 79.904),
    "Kr": Atom(pm: 88, color: .cyan, num: 36, wikipedia: "Krypton", atomMass: 83.798),
    "Rb": Atom(pm: 248, color: .red, num: 37, wikipedia: "Rubidium", atomMass: 85.468),
    "Sr": Atom(pm: 200, color: .orange, num: 38, wikipedia: "Strontium", atomMass: 87.62),
    "Y": Atom(pm: 180, color: .magenta, num: 39, wikipedia: "Yttrium", atomMass: 88.906),
    "Zr": Atom(pm: 230, color: .magenta, num: 40, wikipedia: "Zirconium", atomMass: 91.224),
    "Nb": Atom(pm: 215, color: .magenta, num: 41, wikipedia: "Niobium", atomMass: 92.906),
    "Mo": Atom(pm: 139, color: .magenta, num: 42, wikipedia: "Molybdenum", atomMass: 95.94),
    "Tc": Atom(pm: 205, color: .magenta, num: 43, wikipedia: "Technetium", atomMass: 98),
    "Ru": Atom(pm: 205, color: .magenta, num: 44, wikipedia: "Ruthenium", atomMass: 101.07),
    "Rh": Atom(pm: 200, color: .magenta, num: 45, wikipedia: "Rhodium", atomMass: 102.906),
    "Pd": Atom(pm: 163, color: .magenta, num: 46, wikipedia: "Palladium", atomMass: 106.42),
    "Ag": Atom(pm: 172, color: .magenta, num: 47, wikipedia: "Silver", atomMass: 107.868),
    "Cd": Atom(pm: 158, color: .magenta, num: 48, wikipedia: "Cadmium", atomMass: 112.412),
    "In": Atom(pm: 220, color: .gray, num: 49, wikipedia: "Indium", atomMass: 114.812),
    "Sn": Atom(pm: 140, color: .gray, num: 50, wikipedia: "Tin", atomMass: 118.71),
    "Sb": Atom(pm: 206, color: .brown, num: 51, wikipedia: "Antimony", atomMass: 121.76),
    "Te": Atom(pm: 140, color: .brown, num: 52, wikipedia: "Tellurium", atomMass: 127.06),
    "I": Atom(pm: 140, color: .yellow, num: 53, wikipedia: "Iodine", atomMass: 126.904),
    "Xe": Atom(pm: 108, color: .cyan, num: 54, wikipedia: "Xenon", atomMass: 131.29),
    "Cs": Atom(pm: 300, color: .red, num: 55, wikipedia: "Cesium", atomMass: 132.905),
    "Ba": Atom(pm: 268, color: .orange, num: 56, wikipedia: "Barium", atomMass: 137.327),
    // Begin lanthanes
    "La": Atom(pm: 250, color: .magenta, num: 57, wikipedia: "Lanthanum", atomMass: 138.905),
    "Ce": Atom(pm: 181, color: .purple, num: 58, wikipedia: "Cerium", atomMass: 140.116),
    "Pr": Atom(pm: 247, color: .purple, num: 59, wikipedia: "Praseodymium", atomMass: 140.907),
    "Nd": Atom(pm: 229, color: .purple, num: 60, wikipedia: "Neodymium", atomMass: 144.242),
    "Pm": Atom(pm: 243, color: .purple, num: 61, wikipedia: "Promethium", atomMass: 145),
    "Sm": Atom(pm: 242, color: .purple, num: 62, wikipedia: "Samarium", atomMass: 150.36),
    "Eu": Atom(pm: 240, color: .purple, num: 63, wikipedia: "Europium", atomMass: 151.964),
    "Gd": Atom(pm: 180, color: .purple, num: 64, wikipedia: "Gadolinium", atomMass: 157.25),
    "Tb": Atom(pm: 175, color: .purple, num: 65, wikipedia: "Terbium", atomMass: 158.925),
    "Dy": Atom(pm: 235, color: .purple, num: 66, wikipedia: "Dysprosium", atomMass: 162.50),
    "Ho": Atom(pm: 175, color: .purple, num: 67, wikipedia: "Holmium", atomMass: 164.93),
    "Er": Atom(pm: 175, color: .purple, num: 68, wikipedia: "Erbium", atomMass: 167.26),
    "Tm": Atom(pm: 230, color: .purple, num: 69, wikipedia: "Thulium", atomMass: 168.934),
    "Yb": Atom(pm: 176, color: .purple, num: 70, wikipedia: "Ytterbium", atomMass: 173.04),
    "Lu": Atom(pm: 227, color: .purple, num: 71, wikipedia: "Lutetium", atomMass: 174.967),
    // End lanthanes
    "Hf": Atom(pm: 225, color: .magenta, num: 72, wikipedia: "Hafnium", atomMass: 178.49),
    "Ta": Atom(pm: 220, color: .magenta, num: 73, wikipedia: "Tantalum", atomMass: 180.948),
    "W": Atom(pm: 210, color: .magenta, num: 74, wikipedia: "Tungsten", atomMass: 183.84),
    "Re": Atom(pm: 137, color: .magenta, num: 75, wikipedia: "Rhenium", atomMass: 186.207),
    "Os": Atom(pm: 200, color: .magenta, num: 76, wikipedia: "Osmium", atomMass: 190.23),
    "Ir": Atom(pm: 200, color: .magenta, num: 77, wikipedia: "Iridium", atomMass: 192.217),
    "Pt": Atom(pm: 175, color: .magenta, num: 78, wikipedia: "Platinum", atomMass: 195.085),
    "Au": Atom(pm: 166, color: .magenta, num: 79, wikipedia: "Gold", atomMass: 196.967),
    "Hg": Atom(pm: 150, color: .magenta, num: 80, wikipedia: "Mercury", atomMass: 200.59),
    "Tl": Atom(pm: 220, color: .gray, num: 81, wikipedia: "Thallium", atomMass: 204.383),
    "Pb": Atom(pm: 180, color: .gray, num: 82, wikipedia: "Lead", atomMass: 207.2),
    "Bi": Atom(pm: 230, color: .gray, num: 83, wikipedia: "Bismuth", atomMass: 208.980),
    "Po": Atom(pm: 190, color: .brown, num: 84, wikipedia: "Polonium", atomMass: 209),
    "At": Atom(pm: 200, color: .yellow, num: 85, wikipedia: "Astatine", atomMass: 211),
    "Rn": Atom(pm: 134, color: .cyan, num: 86, wikipedia: "Radon", atomMass: 222),
    "Fr": Atom(pm: 348, color: .red, num: 87, wikipedia: "Francium", atomMass: 223),
    "Ra": Atom(pm: 200, color: .brown, num: 88, wikipedia: "Radium", atomMass: 226),
    // Begin Actinides
    "Ac": Atom(pm: 200, color: .magenta, num: 89, wikipedia: "Actinium", atomMass: 227),
    "Th": Atom(pm: 240, color: .blue, num: 90, wikipedia: "Thorium", atomMass: 232.038),
    "Pa": Atom(pm: 200, color: .blue, num: 91, wikipedia: "Protactinium", atomMass: 231.035),
    "U": Atom(pm: 138, color: .blue, num: 92, wikipedia: "Uranium", atomMass: 238.029),
    "Np": Atom(pm: 200, color: .blue, num: 93, wikipedia: "Neptunium", atomMass: 237),
    "Pu": Atom(pm: 175, color: .blue, num: 94, wikipedia: "Plutonium", atomMass: 239),
    "Am": Atom(pm: 200, color: .blue, num: 95, wikipedia: "Americium", atomMass: 243),
    "Cm": Atom(pm: 200, color: .blue, num: 96, wikipedia: "Curium", atomMass: 247),
    "Bk": Atom(pm: 297, color: .blue, num: 97, wikipedia: "Berkelium", atomMass: 247),
    "Cf": Atom(pm: 295, color: .blue, num: 98, wikipedia: "Californium", atomMass: 249),
    "Es": Atom(pm: 292, color: .blue, num: 99, wikipedia: "Einsteinium", atomMass: 252),
    "Fm": Atom(pm: 290, color: .blue, num: 100, wikipedia: "Fermium", atomMass: 257),
    "Md": Atom(pm: 287, color: .blue, num: 101, wikipedia: "Mendelevium", atomMass: 258),
    "No": Atom(pm: 285, color: .blue, num: 102, wikipedia: "Nobelium", atomMass: 259),
    "Lr": Atom(pm: 282, color: .blue, num: 103, wikipedia: "Lawrencium", atomMass: 262),
    // End Actinides
    "Rf": Atom(pm: 200, color: .magenta, num: 104, wikipedia: "Rutherfordium", atomMass: 261),
    "Db": Atom(pm: 200, color: .magenta, num: 105, wikipedia: "Dubnium", atomMass: 262),
    "Sg": Atom(pm: 200, color: .magenta, num: 106, wikipedia: "Seaborgium", atomMass: 266),
    "Bh": Atom(pm: 200, color: .magenta, num: 107, wikipedia: "Bohrium", atomMass: 271),
    "Hs": Atom(pm: 200, color: .magenta, num: 108, wikipedia: "Hassium", atomMass: 277),
    "Mt": Atom(pm: 200, color: .magenta, num: 109, wikipedia: "Meitnerium", atomMass: 268),
    "Ds": Atom(pm: 200, color: .magenta, num: 110, wikipedia: "Darmstadtium", atomMass: 271),
    "Rg": Atom(pm: 200, color: .magenta, num: 111, wikipedia: "Roentgenium", atomMass: 282),
    "Cn": Atom(pm: 200, color: .magenta, num: 112, wikipedia: "Copernicium", atomMass: 285),
    "Nh": Atom(pm: 170, color: .gray, num: 113, wikipedia: "Nihonium", atomMass: 286),
    "Fl": Atom(pm: 200, color: .gray, num: 114, wikipedia: "Flerovium", atomMass: 289),
    "Mc": Atom(pm: 200, color: .gray, num: 115, wikipedia: "Moscovium", atomMass: 289),
    "Lv": Atom(pm: 200, color: .gray, num: 116, wikipedia: "Livermorium", atomMass: 293),
    "Ts": Atom(pm: 200, color: .yellow, num: 117, wikipedia: "Tennessine", atomMass: 294),
    "Og": Atom(pm: 152, color: .cyan, num: 118, wikipedia: "Oganesson", atomMass: 294),
    "Uue": Atom(pm: 240, color: .red, num: 119, wikipedia: "Ununennium", atomMass: 316),
    "Ubn": Atom(pm: 320, color: .orange, num: 120, wikipedia: "Unbinilium", atomMass: 320),
    // Begin Super-actinides
    "Ubu": Atom(pm: 320, color: .green, num: 121, wikipedia: "Unbiunium", atomMass: 320),
    "Ubb": Atom(pm: 320, color: .green, num: 122, wikipedia: "Unbibium", atomMass: -1),
    "Ubt": Atom(pm: 240, color: .green, num: 123, wikipedia: "Unbitrium", atomMass: -1),
    "Ubq": Atom(pm: 240, color: .green, num: 124, wikipedia: "Unbiquadium", atomMass: -1),
    "Ubp": Atom(pm: 240, color: .green, num: 125, wikipedia: "Unbipentium", atomMass: -1),
    "Ubh": Atom(pm: 240, color: .green, num: 126, wikipedia: "Unbihexium", atomMass: -1),
    // End Super-actinides
]
