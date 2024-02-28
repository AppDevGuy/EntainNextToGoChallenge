//
//  JSONUtility.swift
//  EntainNextToGo
//
//  Created by Sean Smith on 28/2/2024.
//

import Foundation
import Combine

final public class JSONUtility {

    /// Handle JSON Data and return the Struct model data.
    ///
    /// Using this function will result in a one time only use.
    ///
    /// Example usage:
    /// ```
    ///  // Define a cancellable set to store your subscription
    ///  var cancellables = Set<AnyCancellable>()
    /// 
    /// ...
    ///
    /// JSONUtility.decode(type: SomeModel.self, from: jsonData)
    ///     .sink(receiveCompletion: { completion in
    ///         // Completion is a result builder.
    ///         switch completion {
    ///             case .finished:
    ///                 // Successfully decoded
    ///                 break
    ///             case .failure(let error):
    ///                 // Handle error
    ///                 print("Error decoding: \(error)")
    ///         }
    ///     }, receiveValue: { decodedData in
    ///         // Use your decoded data
    ///         print("Decoded data: \(decodedData)")
    ///     })
    ///     .store(in: &cancellables)
    /// ```
    ///
    /// - Returns: A publisher with either the model result or an error.
    public static func decode<T: Decodable>(type: T.Type, from data: Data) -> AnyPublisher<T, Error> {
        Just(data)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }

}
