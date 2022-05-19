//
//  FigureSet.swift
//  arartattractors
//
//  Created by Yasuhito Nagatomo on 2022/05/15.
//

import Foundation

@MainActor
final class FigureSet: ObservableObject {
    @Published var generatingModel = true   // generating attractor model or not
    @Published var selectedFigureIX = 0     // selected figure's index
    @Published var figures: [Figure] = [    // all figures
        Figure(id: 0, type: .clifford, name: "Clifford attractor",
               point: AttractorConstant.points[0],
               parameterRange: AttractorConstant.ranges[0]),
        Figure(id: 1, type: .deJong, name: "de Jong attractor",
               point: AttractorConstant.points[1],
               parameterRange: AttractorConstant.ranges[1]),
        Figure(id: 2, type: .hopalong, name: "Hopalong attractor",
               point: AttractorConstant.points[2],
               parameterRange: AttractorConstant.ranges[2]),
        Figure(id: 3, type: .lorenz, name: "Lorenz attractor",
               point: AttractorConstant.points[3],
               parameterRange: AttractorConstant.ranges[3])
    ]

    /// Setup all figures
    func setup() {
        // set all figure's parameters
        for index in 0 ..< figures.count {
            reset(at: index)
        }
    }

    /// Resets the specified figure's parameters
    /// - Parameter index: index of an attractor
    func reset(at index: Int) {
        assert(index >= 0 && index < figures.count)
        figures[index].paramA = AttractorConstant.defaultParameters[index].parameter.x
        figures[index].paramB = AttractorConstant.defaultParameters[index].parameter.y
        figures[index].paramC = AttractorConstant.defaultParameters[index].parameter.z
        figures[index].paramD = AttractorConstant.defaultParameters[index].parameter.w
        figures[index].paramN = Float(AttractorConstant.defaultParameters[index].numberOfPoints)
        figures[index].animationSpeed = AttractorConstant.defaultParameters[index].animationSpeed
        figures[index].colorFactor =
            AttractorConstant.defaultParameters[index].colorFactor
    }
}
