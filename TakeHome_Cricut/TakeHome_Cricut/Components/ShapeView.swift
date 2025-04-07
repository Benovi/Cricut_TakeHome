//
//  ShapeView.swift
//  TakeHome_Cricut
//
//  Created by Ben Oveson on 4/6/25.
//

import SwiftUI

struct ShapeView: View {
    let viewModel: ShapeViewModel

    var body: some View {
        Group {
            switch viewModel.drawPath {
            case .circle:
                Circle()
            case .square:
                Rectangle()
            case .triangle:
                Triangle()
            }
        }
        .frame(width: 100, height: 100)
        .foregroundColor(.blue)
    }
}

#Preview {
    VStack {
        ShapeView(viewModel: ShapeViewModel(drawPath: .circle))
        ShapeView(viewModel: ShapeViewModel(drawPath: .square))
        ShapeView(viewModel: ShapeViewModel(drawPath: .triangle))
    }
}
