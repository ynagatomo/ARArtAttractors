//
//  Attractor.swift
//  arartattractors
//
//  Created by Yasuhito Nagatomo on 2022/05/15.
//

import Foundation

enum AttractorType: Int {
    case clifford = 0, deJong, hopalong, lorenz

    // swiftlint:disable function_parameter_count
    static func makeAttractor(type: AttractorType, name: String, parameter: SIMD4<Float>,
                              number: Int, point: SIMD3<Float>, color: Float) -> Attractor {
        let attractor: Attractor
        switch type {
        case .clifford: attractor = CliffordAttractor(name: name, parameter: parameter,
                                                      number: number, point: point,
                                                      color: color)
        case .deJong: attractor = DeJongAttractor(name: name, parameter: parameter,
                                                  number: number, point: point,
                                                  color: color)
        case .hopalong: attractor = HopalongAttractor(name: name, parameter: parameter,
                                                      number: number, point: point,
                                                      color: color)
        case .lorenz: attractor = LorenzAttractor(name: name, parameter: parameter,
                                                  number: number, point: point,
                                                  color: color)
        }
        return attractor
    }
}

protocol Attractor {
    var name: String { get }
    var parameter: SIMD4<Float> { get }
    var numberOfPoints: Int { get }
    var point: SIMD3<Float> { get set }
    var displayScale: Float { get }
    var colorFactor: Float { get }
    func next() -> SIMD3<Float>
}
