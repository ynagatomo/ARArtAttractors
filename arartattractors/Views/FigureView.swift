//
//  FigureView.swift
//  arartattractors
//
//  Created by Yasuhito Nagatomo on 2022/05/14.
//

import SwiftUI

struct FigureView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var figureSet: FigureSet
    private var figure: Figure {
        figureSet.figures[figureSet.selectedFigureIX]
    }

    var body: some View {
        ZStack {
            Color.black

            if figureSet.generatingModel {
                Text("Calculating...")
                    .foregroundColor(.gray)
            } else {
                ARContainerView(figure: figure)
            }

            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text(figure.name).font(.title2)
                        Group {
                            Text(" a = \(String(format: "%6.2f", figure.paramA))")
                            Text(" b = \(String(format: "%6.2f", figure.paramB))")
                            Text(" c = \(String(format: "%6.2f", figure.paramC))")
                            Text(" d = \(String(format: "%6.2f", figure.paramD))")
                            Text(" N = \(String(format: "%.0f", figure.paramN))")
                        }.font(.caption)
                    } // VStack
                    .foregroundColor(.cyan)
                    Spacer()
                    Button(action: dismiss.callAsFunction) {
                        Image(systemName: "xmark.circle")
                            .font(.largeTitle)
                            .padding(4)
                    }
                    .tint(.orange)
                } // HStack
                Spacer()
            } // VStack
            .padding(32)
            .padding(.top, 16)
        } // ZStack
        .ignoresSafeArea()
        .task {
            // try? await Task.sleep(nanoseconds: 3_000_000_000) for testing
            ModelManager.shared.setup(figure: figure)
            figureSet.generatingModel = false
        }
    }
}
