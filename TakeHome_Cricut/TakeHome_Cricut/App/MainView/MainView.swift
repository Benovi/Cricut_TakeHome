//
//  MainView.swift
//  TakeHome_Cricut
//
//  Created by Ben Oveson on 4/6/25.
//

import SwiftUI

struct MainView: View {
    @State private var path = NavigationPath()
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                ScrollView(.vertical) {
                    ShapeStack
                }
                Spacer()
                EditShapeButtonStack
            }

            .task {
               await viewModel.load()
            }
            .alert(AlertTitle.networkingError, isPresented: $viewModel.error, actions: {
                // Just here to show I thought about it.
            })
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(ButtonTitle.leadingBarButtonTitle, action: {viewModel.clearAll()})
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(ButtonTitle.trailingBarButtonTitle, action: {
                        path.append(EditCircleViewModel(shapeViewModels: viewModel.shapes,
                                                        onDone: { shapes in viewModel.shapes = shapes}))
                    })
                }
            }
            .navigationDestination(for: EditCircleViewModel.self) { _ in
                EditCircleView(viewModel: EditCircleViewModel(shapeViewModels: self.viewModel.shapes,
                                                              onDone: { shapes in viewModel.shapes = shapes}))
            }
            .padding()
        }
    }
    
    private var ShapeStack: some View {
        ForEach(viewModel.shapes.arrangeGrid(), id: \.self) { row in
            HStack {
                ForEach(row, id: \.self) { shape in
                    ShapeView(viewModel: shape)
                }
            }
        }
    }
    
    private var EditShapeButtonStack: some View {
        HStack(alignment: .bottom) {
            Spacer()
            ForEach(viewModel.editshapeButtons) { button in
                EditShapeButtonView(viewModel: button) { style in
                    self.viewModel.addShape(style)
                }
                Spacer()
            }
        }
    }
}

#Preview {
    MainView(viewModel: MainViewModel())
}
