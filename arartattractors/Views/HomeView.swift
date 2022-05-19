//
//  HomeView.swift
//  arartattractors
//
//  Created by Yasuhito Nagatomo on 2022/05/12.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var figureSet =  FigureSet() // ViewModel
    @State private var showingFigure = false
    private var figure: Figure {
        figureSet.figures[figureSet.selectedFigureIX]
    }

    var body: some View {
        ZStack {
            Color("HomeBGColor").ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                Text("AR Art - Attractors")
                    .font(.system(.largeTitle, design: .rounded))
                    .padding()

                HStack {
                    Menu {
                        Picker(selection: $figureSet.selectedFigureIX) {
                            ForEach(figureSet.figures) { figure in
                                Text(figure.name).tag(figure.id)
                            }
                        } label: {}
                    } label: {
                        Label("SELECT", systemImage: "list.bullet")
                            .foregroundColor(.blue)
                            .font(.title2)
                    }
                    Text(figureSet.figures[figureSet.selectedFigureIX].name)
                        .font(.title2)
                        .padding(.horizontal)
                }

                Button(action: {
                    showingFigure = true
                    figureSet.generatingModel = true
                }, label: {
                    Text("Visualize in AR")
                })
                .padding()
                .controlSize(.large)

                ParameterSettingView(figure: $figureSet.figures[figureSet.selectedFigureIX])

                Button(action: {
                    figureSet.reset(at: figureSet.selectedFigureIX)
                }, label: {
                    Text("Reset Parameters")
                })
                .tint(.orange)
            }
            .padding(.vertical)

            .buttonStyle(.borderedProminent)
        } // ZStack
        .foregroundColor(.white)
        .fullScreenCover(isPresented: $showingFigure) {
            FigureView(figureSet: figureSet)
        }
        .onAppear {
            figureSet.setup()   // Setup the ViewModel
            MetalLibLoader.shared.initialize()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .previewInterfaceOrientation(.portrait)
    }
}

struct ParameterSettingView: View {
    @Binding var figure: Figure
    let stepParam: Float = 0.01
    let stepNumber: Float = 1.0
    let stepSpeed: Float = 0.1
    let stepColor: Float = 0.1
    var body: some View {
        VStack {
            Text("Parameter Setting").font(.title3).padding(.bottom)
            ParameterSliderView(parameter: $figure.paramA, name: "a",
                                minValue: figure.parameterRange.min,
                                maxValue: figure.parameterRange.max, step: stepParam,
                                format: "%.2f")
            ParameterSliderView(parameter: $figure.paramB, name: "b",
                                minValue: figure.parameterRange.min,
                                maxValue: figure.parameterRange.max, step: stepParam,
                                format: "%.2f")
            ParameterSliderView(parameter: $figure.paramC, name: "c",
                                minValue: figure.parameterRange.min,
                                maxValue: figure.parameterRange.max, step: stepParam,
                                format: "%.2f")
            ParameterSliderView(parameter: $figure.paramD, name: "d",
                                minValue: figure.parameterRange.min,
                                maxValue: figure.parameterRange.max, step: stepParam,
                                format: "%.2f")
            ParameterSliderView(parameter: $figure.paramN, name: "Number of Points",
                                minValue: Float(figure.numberRange.min),
                                maxValue: Float(figure.numberRange.max), step: stepNumber,
                                format: "%.0f")
            ParameterSliderView(parameter: $figure.animationSpeed, name: "Animation Speed",
                                minValue: figure.speedRange.min,
                                maxValue: figure.speedRange.max, step: stepSpeed,
                                format: "%.1f")
            ParameterSliderView(parameter: $figure.colorFactor, name: "Color Factor",
                                minValue: figure.colorRange.min,
                                maxValue: figure.colorRange.max, step: stepColor,
                                format: "%.1f")
        }
        .padding(32)
    }
}

struct ParameterSliderView: View {
    @Binding var parameter: Float
    let name: String
    let minValue: Float, maxValue: Float, step: Float
    let format: String
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(name):  \(String(format: format, parameter))")
            Slider(value: $parameter, in: minValue...maxValue, step: step,
                   label: { Text("Parameter") }, minimumValueLabel: {}, maximumValueLabel: {},
                   onEditingChanged: {_ in })
        }
    }
}
