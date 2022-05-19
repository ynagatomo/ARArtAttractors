//
//  LorenzAttractor.swift
//  arartattractors
//
//  Created by Yasuhito Nagatomo on 2022/05/18.
//

import Foundation

final class LorenzAttractor: Attractor {
    let name: String
    let parameter: SIMD4<Float>
    let numberOfPoints: Int
    var point: SIMD3<Float>
    let displayScale: Float = 30
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

// Lorenz Attractor
// Xn+1 = Xn - a * (Xn - Yn) * 0.001
// Yn+1 = Yn + (c * Xn - Xn * Zn - Yn) * 0.001
// Zn+1 = Zn + (-b * Zn + Xn * Yn) * 0.001
extension LorenzAttractor {
    func next() -> SIMD3<Float> {
        let xNext = point.x - parameter.x * (point.x - point.y) * 0.001
        let yNext = point.y + (parameter.z * point.x - point.x * point.z - point.y) * 0.001
        let zNext = point.z + (-parameter.y * point.z + point.x * point.y) * 0.001
        point = SIMD3<Float>(xNext, yNext, zNext)
        return point
    }
}
