//
//  ContentView.swift
//  WeSplit
//
//  Created by Joe Pham on 2021-03-21.
//

import SwiftUI

struct ContentView: View {
	// MARK: PROPERTIES
	@State private var checkAmountInput = ""
	@State private var numberOfPeople = 2
	@State private var tipPercentage = 2
	let tipPercentages = [10, 15, 20, 25, 0]
	
	var totalPerPerson: String {
		// CALCULATIONS HERE
		let peopleCount = Double(numberOfPeople + 2) // as numberOfPeople played as an index
		let selectedTip = Double(tipPercentages[tipPercentage])
		let totalCheckAmount = Double(checkAmountInput) ?? 0
		
		let grandTotal = totalCheckAmount * (1 + selectedTip / 100)
		let amountPerPerson = grandTotal / peopleCount
		
		let formatter = NumberFormatter()
		formatter.numberStyle = .currency
		
		return formatter.string(from: NSNumber(value: amountPerPerson)) ?? "$0"
	}
	
	// MARK: MAIN BODY
    var body: some View {
		NavigationView {
			Form {
				Section {
					TextField("Check Amount", text: $checkAmountInput)
						.keyboardType(.decimalPad)
					Picker("Number of People", selection: $numberOfPeople) {
						ForEach(2..<50) {
							Text("\($0) people")
						}
					}
				}
				
				Section(header: Text("How much would you like to tip?")) {
					Picker("Tip Percentage", selection: $tipPercentage) {
						ForEach(0..<tipPercentages.count) {
							Text("\(self.tipPercentages[$0])%")
						}
					}
					.pickerStyle(SegmentedPickerStyle())
				}
				
				Section(header: Text("Total amount per person is")) {
					Text("\(totalPerPerson)")
				}
			}
			.navigationTitle("WeSplit")
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		ContentView()
    }
}
