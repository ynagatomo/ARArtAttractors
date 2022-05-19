//
//  AttractorModel.swift
//  arartattractors
//
//  Created by Yasuhito Nagatomo on 2022/05/15.
//

import UIKit
import RealityKit

final class AttractorModel {
    private let attractor: Attractor
    private var baseEntity: Entity?

    init(attractor: Attractor) {
        self.attractor = attractor
    }

    func baseModelEntity() -> Entity? {
        return baseEntity
    }

    func resetAnimation() {
        // do nothing
    }

    func playAnimation(_ time: Double) {
        baseEntity?.orientation = simd_quatf(angle: Float(time / 2),
                                             axis: SIMD3<Float>(0, 1, 0))
            * simd_quatf(angle: Float(time / 4), axis: SIMD3<Float>(1, 0, 0))
            * simd_quatf(angle: Float(time / 4), axis: SIMD3<Float>(0, 0, 1))
        let scaleFactor = sinf(Float(time)) / 2 + 1.5
        baseEntity?.scale = SIMD3<Float>(scaleFactor, scaleFactor, scaleFactor)
    }

    func animationFinished() -> Bool {
        // do nothing
        return false
    }
}

extension AttractorModel {
    // Generates the Attractor Model
    // swiftlint:disable function_body_length
    func setup() {
        baseEntity = Entity()
        var positions: [SIMD3<Float>] = []
        var indexes: [UInt32] = []
        let edge: Float = ModelConstant.lengthOfEdge // triangle's edge
        let numberOfMaterial = ModelConstant.numberOfMaterial

        // calculate attractor's points and set vertices and material indexes
        var faceMats: [UInt32] = []
        var faceMatIndex = 0
        var faceMatDir = 1  // 1: incremental or -1: decremental
        for index in 0 ..< attractor.numberOfPoints {
            // get the next point of the attractor
            let point = attractor.next() / attractor.displayScale

            // append vertices for triangles
            positions.append(point) // #0
            positions.append(SIMD3<Float>(point.x + edge, point.y, point.z)) // #1
            positions.append(SIMD3<Float>(point.x, point.y + edge, point.z)) // #2
            positions.append(SIMD3<Float>(point.x, point.y, point.z + edge)) // #3

            // append indexed of the vertices to construct four triangles
            let stride = UInt32(index * 4)
            indexes.append(contentsOf: [0 + stride, 2 + stride, 1 + stride,
                                        0 + stride, 3 + stride, 2 + stride,
                                        0 + stride, 1 + stride, 3 + stride,
                                        1 + stride, 2 + stride, 3 + stride])

            // append the index of material for the faces (triangles)
            faceMats.append(contentsOf: [UInt32](repeating: UInt32(faceMatIndex),
                                                 count: 4))
            // move the material index toward or backward
            faceMatIndex += faceMatDir
            if faceMatIndex >= numberOfMaterial {
                faceMatIndex = numberOfMaterial - 2
                faceMatDir = -1
            } else if faceMatIndex < 0 {
                faceMatIndex = 1
                faceMatDir = 1
            }
        }

        // setup the mesh-descriptor
        var descriptor = MeshDescriptor()
        descriptor.positions = MeshBuffers.Positions(positions)
        descriptor.primitives = .triangles(indexes)
        descriptor.materials = .perFace(faceMats) // or .allFaces(0)

        // create the Metal Surface Shader to animate colors
        let surfaceShader = CustomMaterial.SurfaceShader(named: "surfaceShader",
                                                         in: MetalLibLoader.shared.library)

        var materials: [CustomMaterial] = []
        //  var materials: [UnlitMaterial] = []  ... in case of using the SimpleUnlitMaterial
        // create the Custom Materials with the Metal Surface Shader
        for index in 0 ..< numberOfMaterial {
            let colorParam = (Float(index) * 2 / Float(numberOfMaterial) - 1.0) / attractor.colorFactor
            let color = materialColor(colorParam: colorParam) // calc the tint color
            var customMaterial: CustomMaterial
            // create a Custom Material and set the base color with the tint color
            do {
                try customMaterial = CustomMaterial(surfaceShader: surfaceShader, lightingModel: .unlit)
                customMaterial.baseColor = CustomMaterial.BaseColor(tint: color, texture: nil)
            } catch {
                fatalError("failed to create a custome material.")
            }

            // materials.append(material(colorParam: colorParam)) ... when using SimpleUnlitMaterial
            materials.append(customMaterial)
        }

        // create a mesh and a ModelEntity with the mesh and materials
        if let meshResource = try? MeshResource.generate(from: [descriptor]) {
            let model = ModelEntity(mesh: meshResource,
                                    materials: materials)
            baseEntity?.addChild(model)
            // print("DEBUG: bounds = \(model.visualBounds(relativeTo: nil).extents)") ... check the size
        } else {
            fatalError("failed to generate meshResource.")
        }
    }

    // create a UIColor
    private func materialColor(colorParam: Float) -> UIColor {
        var red: CGFloat, green: CGFloat, blue: CGFloat
        if colorParam <= -1.0 { // blue
            red = 0.0
            green = 0.0
            blue = 1.0
        } else if colorParam <= -0.5 { // blue -> cyan
            let temp = (colorParam + 1.0) * 2.0
            red = 0.0
            green = CGFloat(temp)
            blue = 1.0
        } else if colorParam <= 0 { // cyan -> white
            let temp = (colorParam + 0.5) * 2.0
            red = CGFloat(temp)
            green = 1.0
            blue = 1.0
        } else if colorParam <= 0.5 { // white -> orange
            red = 1.0
            green = 1.0 - CGFloat(colorParam)
            blue = 1.0 - CGFloat(colorParam * 2.0)
        } else if colorParam <= 1.0 { // orange -> red
            let temp = colorParam - 0.5
            red = 1.0
            green = 0.5 - CGFloat(temp)
            blue = 0.0
        } else { // red
            red = 1.0
            green = 0.0
            blue = 0.0
        }
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }

    //              color                      colorParam
    //    SIMD3<Float>(0.0, 0.0, 1.0), // blue   -1.0
    //    SIMD3<Float>(0.0, 1.0, 1.0), // cyan   -0.5
    //    SIMD3<Float>(1.0, 1.0, 1.0), // white   0.0
    //    SIMD3<Float>(1.0, 0.5, 0.0), // orange  0.5
    //    SIMD3<Float>(1.0, 0.0, 0.0)]  // red    1.0
    //    private func material(colorParam: Float) -> UnlitMaterial {  ... use this when using UnlitMaterial
    //        var red: CGFloat, green: CGFloat, blue: CGFloat
    //        if colorParam <= -1.0 { // blue
    //            red = 0.0
    //            green = 0.0
    //            blue = 1.0
    //        } else if colorParam <= -0.5 { // blue -> cyan
    //            let temp = (colorParam + 1.0) * 2.0
    //            red = 0.0
    //            green = CGFloat(temp)
    //            blue = 1.0
    //        } else if colorParam <= 0 { // cyan -> white
    //            let temp = (colorParam + 0.5) * 2.0
    //            red = CGFloat(temp)
    //            green = 1.0
    //            blue = 1.0
    //        } else if colorParam <= 0.5 { // white -> orange
    //            red = 1.0
    //            green = 1.0 - CGFloat(colorParam)
    //            blue = 1.0 - CGFloat(colorParam * 2.0)
    //        } else if colorParam <= 1.0 { // orange -> red
    //            let temp = colorParam - 0.5
    //            red = 1.0
    //            green = 0.5 - CGFloat(temp)
    //            blue = 0.0
    //        } else { // red
    //            red = 1.0
    //            green = 0.0
    //            blue = 0.0
    //        }
    //        return UnlitMaterial(color: UIColor(red: red, green: green, blue: blue, alpha: 1.0))
    //    }
}
