//
//  EditCircleView.swift
//  TakeHome_Cricut
//
//  Created by Ben Oveson on 4/6/25.
//
import SwiftUI

struct EditCircleView: View {
    @ObservedObject var viewModel: EditCircleViewModel
    
    var body: some View {
            VStack {
                ScrollView(.vertical) {
                    VStack {
                        ForEach(viewModel.circleViewModels.arrangeGrid(), id: \.self) { row in
                            HStack {
                                ForEach(row, id: \.self) { shape in
                                    ShapeView(viewModel: shape)
                                }
                            }
                        }
                    }
                }
                Spacer()
                HStack(alignment: .bottom) {
                    Spacer()
                    EditShapeButtonView(viewModel: EditShapeButtonViewModel(name: ButtonTitle.deleteAll, drawPath: .circle)) { style in
                        self.viewModel.deleteAll()
                    }
                    Spacer()
                    EditShapeButtonView(viewModel: EditShapeButtonViewModel(name: ButtonTitle.add, drawPath: .circle)) { style in
                        self.viewModel.addOne()
                    }
                    Spacer()
                    EditShapeButtonView(viewModel: EditShapeButtonViewModel(name: ButtonTitle.remove, drawPath: .circle)) { style in
                        self.viewModel.removeOne()
                    }
                    Spacer()
                }
            .padding()
            }.onDisappear {
                self.viewModel.done()
            }
    }
}
