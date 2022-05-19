//
//  DeJongAttractor.swift
//  arartattractors
//
//  Created by Yasuhito Nagatomo on 2022/05/18.
//

import Foundation

final class DeJongAttractor: Attractor {
    let name: String
    let parameter: SIMD4<Float>
    let numberOfPoints: Int
    var point: SIMD3<Float>
    let displayScale: Float = 3
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

// de Jong Attractor
// Xn+1 = sin(a * Yn) - cos(b * Xn)
// Yn+1 = sin(c * Xn) - cos(d * Yn)
extension DeJongAttractor {
    func next() -> SIMD3<Float> {
        let xNext = sinf(parameter.x * point.y)
        - cosf(parameter.y * point.x)
        let yNext = sinf(parameter.z * point.x)
        - cosf(parameter.w * point.y)
        point = SIMD3<Float>(xNext, yNext, point.z)
        return point
    }
}
