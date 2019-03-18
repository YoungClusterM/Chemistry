//
//  Atoms.swift
//  Chemistry
//
//  Created by Паша Косило on 10/21/18.
//  Copyright © 2018 Pavel Kosilo. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit
import SceneKit

class Atom {
    var pm : Float = 0
    var color : UIColor = UIColor.white
    
    init(pm: Float, color: UIColor, num: Int8) {
        self.pm = pm
        self.color = color
    }
    
    func draw() -> SCNSphere {
        let atom = SCNSphere(radius: CGFloat(self.pm / 100))
        atom.firstMaterial?.diffuse.contents  = self.color
        
        return atom
    }
}

let Atoms: [String:Atom] = [
    "H": Atom(pm: 53, color: .blue, num: 1),
    "He": Atom(pm: 31, color: .blue, num: 2),
    "Li": Atom(pm: 152, color: .blue, num: 3),
    "Be": Atom(pm: 112, color: .blue, num: 4),
    "B": Atom(pm: 85, color: .blue, num: 5),
    "C": Atom(pm: 70, color: .blue, num: 6),
    "N": Atom(pm: 65, color: .blue, num: 7),
    "O": Atom(pm: 60, color: .red, num: 8),
    "F": Atom(pm: 147, color: .green, num: 9),
    "Ne": Atom(pm: 38, color: .blue, num: 10),
    "Na": Atom(pm: 227, color: .blue, num: 11),
    "Mg": Atom(pm: 173, color: .blue, num: 12),
    "Al": Atom(pm: 143, color: .blue, num: 13),
    "Si": Atom(pm: 111, color: .blue, num: 14),
    "P": Atom(pm: 195, color: .blue, num: 15),
    "S": Atom(pm: 100, color: .blue, num: 16),
    "Cl": Atom(pm: 175, color: .blue, num: 17),
    "Ar": Atom(pm: 71, color: .blue, num: 18),
    "K": Atom(pm: 280, color: .blue, num: 19),
    "Ca": Atom(pm: 231, color: .blue, num: 20),
    "Sc": Atom(pm: 230, color: .blue, num: 21),
    "Ti": Atom(pm: 147, color: .blue, num: 22),
    "V": Atom(pm: 205, color: .blue, num: 23),
    "Cr": Atom(pm: 128, color: .blue, num: 24),
    "Mn": Atom(pm: 127, color: .blue, num: 25),
    "Fe": Atom(pm: 126, color: .blue, num: 26),
    "Co": Atom(pm: 200, color: .blue, num: 27),
    "Ni": Atom(pm: 163, color: .blue, num: 28),
    "Cu": Atom(pm: 128, color: .blue, num: 29),
    "Zn": Atom(pm: 139, color: .blue, num: 30),
    "Ga": Atom(pm: 187, color: .blue, num: 31),
    "Ge": Atom(pm: 211, color: .blue, num: 32),
    "As": Atom(pm: 185, color: .blue, num: 33),
    "Se": Atom(pm: 120, color: .blue, num: 34),
    "Br": Atom(pm: 185, color: .blue, num: 35),
    "Kr": Atom(pm: 88, color: .blue, num: 36),
    "Rb": Atom(pm: 248, color: .blue, num: 37),
    "Sr": Atom(pm: 200, color: .blue, num: 38),
    "Y": Atom(pm: 180, color: .blue, num: 39),
    "Zr": Atom(pm: 230, color: .blue, num: 40),
    "Nb": Atom(pm: 215, color: .blue, num: 41),
    "Mo": Atom(pm: 139, color: .blue, num: 42),
    "Tc": Atom(pm: 205, color: .blue, num: 43),
    "Ru": Atom(pm: 205, color: .blue, num: 44),
    "Rh": Atom(pm: 200, color: .blue, num: 45),
    "Pd": Atom(pm: 163, color: .blue, num: 46),
    "Ag": Atom(pm: 172, color: .blue, num: 47),
    "Cd": Atom(pm: 158, color: .blue, num: 48),
    "In": Atom(pm: 220, color: .blue, num: 49),
    "Sn": Atom(pm: 140, color: .blue, num: 50),
    "Sb": Atom(pm: 206, color: .blue, num: 51),
    "Te": Atom(pm: 140, color: .blue, num: 52),
    "I": Atom(pm: 140, color: .blue, num: 53),
    "Xe": Atom(pm: 108, color: .blue, num: 54),
    "Cs": Atom(pm: 300, color: .blue, num: 55),
    "Ba": Atom(pm: 268, color: .blue, num: 56),
    // Begin lanthanes
    "La": Atom(pm: 250, color: .blue, num: 57),
    "Ce": Atom(pm: 181, color: .blue, num: 58),
    "Pr": Atom(pm: 247, color: .blue, num: 59),
    "Nd": Atom(pm: 229, color: .blue, num: 60),
    "Pm": Atom(pm: 243, color: .blue, num: 61),
    "Sm": Atom(pm: 242, color: .blue, num: 62),
    "Eu": Atom(pm: 240, color: .blue, num: 63),
    "Gd": Atom(pm: 180, color: .blue, num: 64),
    "Tb": Atom(pm: 175, color: .blue, num: 65),
    "Dy": Atom(pm: 235, color: .blue, num: 66),
    "Ho": Atom(pm: 175, color: .blue, num: 67),
    "Er": Atom(pm: 175, color: .blue, num: 68),
    "Tm": Atom(pm: 230, color: .blue, num: 69),
    "Yb": Atom(pm: 176, color: .blue, num: 70),
    "Lu": Atom(pm: 227, color: .blue, num: 71),
    // End lanthanes
    "Hf": Atom(pm: 225, color: .blue, num: 72),
    "Ta": Atom(pm: 220, color: .blue, num: 73),
    "W": Atom(pm: 210, color: .blue, num: 74),
    "Re": Atom(pm: 137, color: .blue, num: 75),
    "Os": Atom(pm: 200, color: .blue, num: 76),
    "Ir": Atom(pm: 200, color: .blue, num: 77),
    "Pt": Atom(pm: 175, color: .blue, num: 78),
    "Au": Atom(pm: 166, color: .blue, num: 79),
    "Hg": Atom(pm: 150, color: .blue, num: 80),
    "Tl": Atom(pm: 220, color: .blue, num: 81),
    "Pb": Atom(pm: 180, color: .blue, num: 82),
    "Bi": Atom(pm: 230, color: .blue, num: 83),
    "Po": Atom(pm: 190, color: .blue, num: 84),
    "At": Atom(pm: 200, color: .blue, num: 85),
    "Rn": Atom(pm: 134, color: .blue, num: 86),
    "Fr": Atom(pm: 348, color: .blue, num: 87),
    "Ra": Atom(pm: 200, color: .blue, num: 88),
    // Begin Actinides
    "Ac": Atom(pm: 200, color: .blue, num: 89),
    "Th": Atom(pm: 240, color: .blue, num: 90),
    "Pa": Atom(pm: 200, color: .blue, num: 91),
    "U": Atom(pm: 138, color: .blue, num: 92),
    "Np": Atom(pm: 200, color: .blue, num: 93),
    "Pu": Atom(pm: 175, color: .blue, num: 94),
    "Am": Atom(pm: 200, color: .blue, num: 95),
    "Cm": Atom(pm: 200, color: .blue, num: 96),
    "Bk": Atom(pm: 297, color: .blue, num: 97),
    "Cf": Atom(pm: 295, color: .blue, num: 98),
    "Es": Atom(pm: 292, color: .blue, num: 99),
    "Fm": Atom(pm: 290, color: .blue, num: 100),
    "Md": Atom(pm: 287, color: .blue, num: 101),
    "No": Atom(pm: 285, color: .blue, num: 102),
    "Lr": Atom(pm: 282, color: .blue, num: 103),
    // End Actinides
    "Rf": Atom(pm: 200, color: .blue, num: 104),
    "Db": Atom(pm: 200, color: .blue, num: 105),
    "Sg": Atom(pm: 200, color: .blue, num: 106),
    "Bh": Atom(pm: 200, color: .blue, num: 107),
    "Hs": Atom(pm: 200, color: .blue, num: 108),
    "Mt": Atom(pm: 200, color: .blue, num: 109),
    "Ds": Atom(pm: 200, color: .blue, num: 110),
    "Rg": Atom(pm: 200, color: .blue, num: 111),
    "Cn": Atom(pm: 200, color: .blue, num: 112),
    "Nh": Atom(pm: 170, color: .blue, num: 113),
    "Fl": Atom(pm: 200, color: .blue, num: 114),
    "Mc": Atom(pm: 200, color: .blue, num: 115),
    "Lv": Atom(pm: 200, color: .blue, num: 116),
    "Ts": Atom(pm: 200, color: .blue, num: 117),
    "Og": Atom(pm: 152, color: .blue, num: 118),
]
