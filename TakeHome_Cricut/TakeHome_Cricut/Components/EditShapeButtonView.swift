//
//  EditShapeButtonView.swift
//  TakeHome_Cricut
//
//  Created by Ben Oveson on 4/6/25.
//

import SwiftUI

struct EditShapeButtonView: View {
    let viewModel: EditShapeButtonViewModel
    let action: ((ShapeStyle) -> Void)
    
    var body: some View {
        Button(viewModel.name, action: { action(viewModel.drawPath) })
    }
}

#Preview {
    EditShapeButtonView(viewModel: EditShapeButtonViewModel(name: "Circle", drawPath: .circle),
                    action: { shapeAction in })
}
