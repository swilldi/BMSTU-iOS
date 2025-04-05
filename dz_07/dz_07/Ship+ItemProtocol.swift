//
//  Ships.swift
//  dz_07
//
//  Created by Dmitriy Dudyrev on 04.04.2025.
//

protocol Item {
    associatedtype Item
    var title: String { get }
    var company: String { get }
    var prise: String { get }
    func next() -> Item
}

enum Ship: Int, Item {
    
    enum ShipCompany: String {
        case aegis = "Aegis Dynamics"
        case anvil = "Anvil Aerospace"
        case rsi = "Roberts Space Industries"
    }
    
    case raven = 0, andromeda, f8c, galaxy, carrack
    
    var title: String {
        switch self {
        case .andromeda:
            "andromeda"
        case .f8c:
            "f8c"
        case .galaxy:
            "galaxy"
        case .raven:
            "raven"
        case .carrack:
            "carrack"
        }
    }
    
    var company: String {
        switch self {
        case .andromeda, .galaxy:
            "Roberts Space Industries"
        case .raven:
            "Aegis Dynamics"
        case .f8c, .carrack:
            "Anvil Aerospace"
        }
    }
    
    var intPrise: Int {
        switch self {
        case .andromeda:
            1000000
        case .galaxy, .carrack:
            3000000
        case .raven:
            400000
        case .f8c:
            1000000
        }
    }
    
    var prise: String {
        var prise = intPrise
        var count = 0
        var strPrise = ""
        while prise != 0 {
            strPrise = String(prise % 10) + strPrise
            count += 1
            if count == 3 && !(1...9).contains(prise) {
                strPrise = " " + strPrise
                count = 0
            }
            prise /= 10
        }
        return strPrise + " UEC"
    }
    
    func next() -> Ship {
        Ship(rawValue: (rawValue + 1) % 5) ?? .raven
    }
}

