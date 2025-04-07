//
//  MainViewDataProvider.swift
//  TakeHome_Cricut
//
//  Created by Ben Oveson on 4/6/25.
//

import Foundation

public enum ShapeStyle: String, Codable {
    case square
    case circle
    case triangle
}

public enum MainViewDataProviderError: Error {
    case failedToDecode
    case noData
    case urlSessionError(Error)
    case invalidURL
}

private struct ShapeButtonData: Codable {
    let name: String
    let drawPath: ShapeStyle

    enum CodingKeys: String, CodingKey {
        case name
        case drawPath = "draw_path"
    }
}

private struct ShapeButtonResponse: Codable {
    let buttons: [ShapeButtonData]
}

class MainViewDataProvider {
    func fetchShapeButtons() async throws -> [EditShapeButtonViewModel] {
        guard let url = URL(string: "https://staticcontent.cricut.com/static/test/shapes_001.json") else {
            throw MainViewDataProviderError.invalidURL
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        do {
            let decoded = try JSONDecoder().decode(ShapeButtonResponse.self, from: data)
            return makeButtonViewModels(response: decoded)
        } catch {
            throw MainViewDataProviderError.failedToDecode
        }
    }
    
    private func makeButtonViewModels(response: ShapeButtonResponse) -> [EditShapeButtonViewModel] {
        response.buttons.map { EditShapeButtonViewModel(name: $0.name, drawPath: $0.drawPath) }
    }
}
