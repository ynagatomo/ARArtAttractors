//
//  AttractorConstant.swift
//  arartattractors
//
//  Created by Yasuhito Nagatomo on 2022/05/17.
//

import Foundation

class AttractorConstant {
    private init() {}

    // parameter range
    struct ParameterRange {
        let parameter: (min: Float, max: Float) // range of {a, b, c, d}
        let number: (min: Int, max: Int) // range of number
        let animationSpeed: (min: Float, max: Float) // range of speed
        let colorFactor: (min: Float, max: Float) // range of color
    }

    static let ranges: [ParameterRange] = [
        ParameterRange(parameter: (-3.0, 3.0), number: (30000, 300000),
                       animationSpeed: (0.0, 5.0),
                       colorFactor: (0.1, 10.0)), // Clifford
        ParameterRange(parameter: (-3.0, 3.0), number: (30000, 300000),
                       animationSpeed: (0.0, 5.0),
                       colorFactor: (0.1, 10.0)), // de Jong
        ParameterRange(parameter: (-1.0, 1.0), number: (30000, 300000),
                       animationSpeed: (0.0, 5.0),
                       colorFactor: (0.1, 10.0)), // Hoplong
        ParameterRange(parameter: (0.0, 30.0), number: (30000, 300000),
                       animationSpeed: (0.0, 5.0),
                       colorFactor: (0.1, 10.0)) // Lorenz
    ]

    // default parameters
    struct DefaultParameter {
        let parameter: SIMD4<Float> // (a, b, c, d)
        let numberOfPoints: Int
        let animationSpeed: Float
        let colorFactor: Float
    }

    static let defaultParameters: [DefaultParameter] = [
        DefaultParameter(parameter: SIMD4<Float>(-1.7, -1.8, -2.3, -0.3),
                         numberOfPoints: 30000, animationSpeed: 1.0,
                         colorFactor: 1.0), // Clifford
        DefaultParameter(parameter: SIMD4<Float>(-2.0, -2.3, -1.4, 2.1),
                         numberOfPoints: 30000, animationSpeed: 1.0,
                         colorFactor: 1.0), // de Jong
        DefaultParameter(parameter: SIMD4<Float>(-0.32, 0.36, -0.09, 0),
                         numberOfPoints: 30000, animationSpeed: 1.0,
                         colorFactor: 1.0), // Hopalong
        DefaultParameter(parameter: SIMD4<Float>(10.0, 8.0/3.0, 28.0, 0),
                         numberOfPoints: 30000, animationSpeed: 1.0,
                         colorFactor: 1.0) // Lorenz
    ]

    // start point: (x, y, z)
    static let points: [SIMD3<Float>] = [
        SIMD3<Float>(0.1, 0.1, 0),  // Clifford
        SIMD3<Float>(0.1, 0.1, 0),  // de Jong
        SIMD3<Float>(0, 0, 0),  // Hopalong
        SIMD3<Float>(1, 1, 1)   // Lorenz
    ]
}
