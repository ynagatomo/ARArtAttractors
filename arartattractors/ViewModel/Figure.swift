//
//  Figure.swift
//  arartattractors
//
//  Created by Yasuhito Nagatomo on 2022/05/15.
//

import Foundation

struct Figure: Identifiable {
    let id: Int
    let type: AttractorType //  FigureType
    let name: String
    let parameterRange: (min: Float, max: Float) // range of parameters
    let numberRange: (min: Int, max: Int)   // range of number of points
    let speedRange: (min: Float, max: Float)    // range of animation speed
    let colorRange: (min: Float, max: Float)
    let point: SIMD3<Float>         // initial point
    var paramA: Float = 0           // parameter a
    var paramB: Float = 0           // parameter b
    var paramC: Float = 0           // parameter c
    var paramD: Float = 0           // parameter d
    var paramN: Float = 0           // number of points
    var animationSpeed: Float = 0   // animation speed
    var colorFactor: Float = 0      // color factor

    init(id: Int, type: AttractorType, name: String, point: SIMD3<Float>,
         parameterRange: AttractorConstant.ParameterRange) {
        self.id = id
        self.type = type
        self.name = name
        self.point = point
        self.parameterRange = parameterRange.parameter
        self.numberRange = parameterRange.number
        self.speedRange = parameterRange.animationSpeed
        self.colorRange = parameterRange.colorFactor
    }

    /// Is equal to other figure?
    /// - Parameter other: other figure
    /// - Returns: true when all parameters are equal
    ///
    /// It does not care about animation speed
    func isEqualModel(to other: Figure) -> Bool {
        return self.type == other.type
        && self.paramA == other.paramA
        && self.paramB == other.paramB
        && self.paramC == other.paramC
        && self.paramD == other.paramD
        && self.paramN == other.paramN
        && self.colorFactor == other.colorFactor
    }
}
