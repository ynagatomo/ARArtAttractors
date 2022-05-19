//
//  MetalLibLoader.swift
//  arartattractors
//
//  Created by Yasuhito Nagatomo on 2022/05/18.
//

import MetalKit

final class MetalLibLoader {
    static var shared = MetalLibLoader()
    private init() {}

    var isInitialized = false
    // var textureCache: CVMetalTextureCache!
    var mtlDevice: MTLDevice!
    var library: MTLLibrary!

    func initialize() {
        guard !isInitialized else { return }

        guard let device = MTLCreateSystemDefaultDevice() else {
            fatalError("failed to create a system default Metal device.")
        }
        mtlDevice = device

        //    if CVMetalTextureCacheCreate(nil, nil, device, nil, &textureCache)
        //      != kCVReturnSuccess {
        //        fatalError()
        //    }

        guard let library = device.makeDefaultLibrary() else {
            fatalError("failed to create a default Metal library.")
        }
        self.library = library

        isInitialized = true
    }
}
