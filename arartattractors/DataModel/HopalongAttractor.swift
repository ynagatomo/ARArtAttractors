//
//  HopalongAttractor.swift
//  arartattractors
//
//  Created by Yasuhito Nagatomo on 2022/05/18.
//

import Foundation

// MARK: - Hopalong Attractor

final class HopalongAttractor: Attractor {
    let name: String
    let parameter: SIMD4<Float>
    let numberOfPoints: Int
    var point: SIMD3<Float>
    let displayScale: Float = 0.3
    let colorFactor: Float

    init(name: String, parameter: SIMD4<Float>, number: Int,
         point: SIMD3<Float>, color: Float) {
        self.name = name
        self.parameter = parameter
        self.numberOfPoints = number
        self.point = point
        self.colorFactor = color
    }
}

// Hopalong Attractor
// Xn+1 = Yn - sin(Xn) * sqr( abs( b * Xn - c ) )
// Yn+1 = a - Xn
extension HopalongAttractor {
    func next() -> SIMD3<Float> {
        // print("DEBUG: next() was called.")
        // print("DEBUG:  - point = \(point)")
        // print("DEBUG:  - param = \(parameter)")
        let xNext = point.y - sinf(point.x) * sqrtf(fabsf(parameter.y * point.x - parameter.z))
        let yNext = parameter.x - point.x
        + parameter.w * cosf(parameter.y * point.y)
        point = SIMD3<Float>(xNext, yNext, point.z)
        return point
    }
}
