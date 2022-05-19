//
//  CliffordAttractor.swift
//  arartattractors
//
//  Created by Yasuhito Nagatomo on 2022/05/18.
//

import Foundation

final class CliffordAttractor: Attractor {
    let name: String
    let parameter: SIMD4<Float>
    let numberOfPoints: Int
    var point: SIMD3<Float>
    let displayScale: Float = 3.0
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

// Clifford Attractor
// Xn+1 = sin(a * Yn) + c * cos(a * Xn)
// Yn+1 = sin(b * Xn) + d * cos(b * Yn)
extension CliffordAttractor {
    func next() -> SIMD3<Float> {
        let xNext = sinf(parameter.x * point.y)
        + parameter.z * cosf(parameter.x * point.x)
        let yNext = sinf(parameter.y * point.x)
        + parameter.w * cosf(parameter.y * point.y)
        point = SIMD3<Float>(xNext, yNext, point.z)
        return point
    }
}
