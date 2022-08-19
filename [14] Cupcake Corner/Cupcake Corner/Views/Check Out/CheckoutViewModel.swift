//
//  CheckoutViewModel.swift
//  Cupcake Corner
//
//  Created by Joe Pham on 2022-08-19.
//

import SwiftUI

extension CheckoutView {
	final class ViewModel: ObservableObject {
		@Published
		var order: Order
		
		@Published
		private(set) var confirmationMessage: String
		
		@Published
		private(set) var showingConfirmation: Bool
		
		init(order: Order) {
			self.order = order
			confirmationMessage = ""
			showingConfirmation = false
		}
		
		func placeOrder() async -> Void {
			guard let encodedData = encodeOrderObject() else { return }
			let networkRequest = createAndConfigNetworkRequest()
			await runRequestAndProcessResponse(networkRequest, from: encodedData)
		}
		
		/// Convert current order object into some JSON data that can be sent
		private func encodeOrderObject() -> Data? {
			if let encoded = try? JSONEncoder().encode(self.order) {
				return encoded
			}
			
			print("Failed to encode order")
			return nil
		}
		
		/// Set up an `URLRequest` to send data over a network call
		private func createAndConfigNetworkRequest() -> URLRequest {
			let url = URL(string: "https://reqres.in/api/cupcakes")!
			var request = URLRequest(url: url)
			request.setValue("application/json", forHTTPHeaderField: "Content-Type")
			request.httpMethod = "POST"
			
			return request
		}
		
		/// Run a pre-configured network request,
		/// and process the response sent back from an API service
		private func runRequestAndProcessResponse(_ request: URLRequest, from inputData: Data) async -> Void {
			do {
				let urlSession = URLSession.shared
				let (dataReceivedFromApiService, _) = try await urlSession.upload(for: request, from: inputData)
				
				let decodedOrder = try JSONDecoder().decode(Order.self, from: dataReceivedFromApiService)
				updateConfirmationContent(from: decodedOrder)
				
			} catch {
				print("Checkout failed.")
			}
		}
		
		private func updateConfirmationContent(from decodedOrder: Order) {
			DispatchQueue.main.async { [weak self] in
				self?.confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Cupcake.types[decodedOrder.item.type].rawValue.lowercased()) cupcakes is on its way!"
				self?.showingConfirmation.toggle()
			}
		}
	}
}
