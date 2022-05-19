# AR Art Attractors

![AppIcon](https://user-images.githubusercontent.com/66309582/169184025-28376a03-abc9-41b1-b6ad-5b0431be6e78.png)

A minimal iOS AR(Augumented Reality) app that displays 3D graphic arts in AR.
It uses attractor systems.

An attractor is a set of states toward which a dynamic system tends to evolve,
for a wide variety of starting conditions and parameters of the system.

The project includes four attractors and default parameters.
Using the UI, users can change the parameters and find chaotic strange solutions.
And also, they can modify the number of points ,animation speed, and colors, as they like.

1. Clifford attractor
1. de Jong attractor
1. Hopalong attractor
1. Lorenz attractor

The project:

- Xcode 13.4, Swift 5.5 (Swift Concurrency)
- Target: iOS / iPadOS 15.0 and later, macOS 12.0 and later on Apple Silicon
- Frameworks: SwiftUI, ARKit, RealityKit2, Metal

It shows:

- Procedural geometry generation with RealityKit2
- Custom Material generation with RealityKit2 and Metal
- Concurrent calculation with SwiftUI and Swift Concurrency

One small triangular pyramid is generated for each point in an equation.
The pyramid consists of four vertices and four triangles as the face.
For example, when creating 300,000 points, 1200K vertices and 1200K triangles
are generated.
ARKit and RealityKit display these 3d geometries in the realtime AR scene.

The project is a minimal implementation.
Please modify it and make your own AR app!

![Image](https://user-images.githubusercontent.com/66309582/169184612-efaaa53c-e25c-4921-86b6-998228ebcce9.png)
![Image](https://user-images.githubusercontent.com/66309582/169184790-873d6e02-aacf-4348-9d39-a11d4f7bd1f6.png)
![Image](https://user-images.githubusercontent.com/66309582/169184872-96cb6273-8115-4435-983a-7a1d46503f04.png)
![GIF](https://user-images.githubusercontent.com/66309582/169184908-84fa8e14-c3ab-4899-a6d4-c8d8e75940b9.gif)

The structure:

- Views: HomeView, FigureView, ARContainerView, etc.
- ViewModel: FigureSet, Figure
- AR Scene State Management: ARScene
- 3D Model Management: ModelManager, AttractorModel
- Data Model: Attractor, CliffordAttractor, etc.
- Metal: MetalLibLoader, surfaceShader

![Image](https://user-images.githubusercontent.com/66309582/169422495-2aeca43c-8804-49a1-bb4d-7e882c9bac09.png)

## References

- Apple Documentation: Article [Modifying RealityKit Rendering Using Custom Materials](https://developer.apple.com/documentation/realitykit/modifying_realitykit_rendering_using_custom_materials)

![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)

