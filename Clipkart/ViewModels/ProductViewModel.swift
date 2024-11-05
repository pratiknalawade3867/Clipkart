//
//  ProductViewModel.swift
//  Clipkart
//
//  Created by pratik.nalawade on 25/10/24.
//

import Foundation

class ProductViewModel: ObservableObject {
    
    @Published var products: [Product] = []
    private let manager = APIManager()
    @Published var isLoading = true // Add loading state
    @Published var isNetClosed: Bool = false
    
    func fetchProducts() async {
        do {
            products = try await manager.request(url: "https://fakestoreapi.com/products")
            // Once the data is loaded, hide the progress view
            isLoading = false
            print(products)
        }catch {
            isNetClosed = true
            isLoading = false
            //  print("Fetch Product error:", error)
        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
}

final class APIManager {
    
    /*
     Error: throw
     response: return
     */
    func request<T: Decodable>(url: String) async throws -> T {
        guard let url = URL(string: url) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}
