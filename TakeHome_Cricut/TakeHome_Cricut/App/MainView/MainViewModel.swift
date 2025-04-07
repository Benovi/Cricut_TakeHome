//
//  MainViewModel.swift
//  TakeHome_Cricut
//
//  Created by Ben Oveson on 4/6/25.
//

import Swift
import Foundation

@MainActor
class MainViewModel: ObservableObject {
    @Published var editshapeButtons: [EditShapeButtonViewModel]
    @Published var shapes: [ShapeViewModel]
    @Published var error: Bool
    let dataProvider: MainViewDataProvider
    
    init(editshapeButtons: [EditShapeButtonViewModel] = [],
         shapes: [ShapeViewModel] = [],
         error: Bool = false,
         dataProvider: MainViewDataProvider = MainViewDataProvider()) {
        self.editshapeButtons = editshapeButtons
        self.shapes = shapes
        self.error = error
        self.dataProvider = dataProvider
    }
    
    func clearAll() {
        shapes.removeAll(keepingCapacity: false)
    }
    
    func load() async {
        do {
            let buttons = try await dataProvider.fetchShapeButtons()
            editshapeButtons = buttons
        } catch {
            self.error = true
        }
    }
    
    func addShape(_ shape: ShapeStyle) {
        shapes.append(ShapeViewModel(drawPath: shape))
    }
}
