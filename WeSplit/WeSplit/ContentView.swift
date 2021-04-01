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
	@State private var numberOfPeopleInput = ""	// Challenge 3
//	@State private var indexNumOfPeople = 2
	@State private var tipPercentage = 2
	let tipPercentages = [10, 15, 20, 25, 0]
	
	var totalPerPerson: String {
		// CALCULATIONS HERE
//		let peopleCount = Double(indexNumOfPeople + 2) // as numberOfPeople played as an index
		let peopleCount = Double(numberOfPeopleInput) ?? 1	// Challenge 3
		let selectedTip = Double(tipPercentages[tipPercentage])
		let totalCheckAmount = Double(checkAmountInput) ?? 0
		
		let grandTotal = totalCheckAmount * (1 + selectedTip / 100)
		let amountPerPerson = grandTotal / peopleCount
		
		let formatter = NumberFormatter()
		formatter.numberStyle = .currency
		
		return formatter.string(from: NSNumber(value: amountPerPerson)) ?? "$0"
	}
	
	// Challenge 2
	var grandTotal: String {
		let selectedTip = Double(tipPercentages[tipPercentage])
		let totalCheckAmount = Double(checkAmountInput) ?? 0
		
		let grandTotal = totalCheckAmount * (1 + selectedTip / 100)
		
		let formatter = NumberFormatter()
		formatter.numberStyle = .currency
		
		return formatter.string(from: NSNumber(value: grandTotal)) ?? "$0"
	}
	
	// MARK: MAIN BODY
    var body: some View {
		NavigationView {
			Form {
				Section {
					TextField("Check Amount", text: $checkAmountInput)
						.keyboardType(.decimalPad)
//					Picker("Number of People", selection: $indexNumOfPeople) {
//						ForEach(2..<100) {
//							Text("\($0) people")
//						}
//					}
//					.pickerStyle(WheelPickerStyle())
					
					TextField("Number of People", text: $numberOfPeopleInput)
						.keyboardType(.decimalPad)	// Challenge 3
				}
				
				Section(header: Text("How much would you like to tip?")) {
					Picker("Tip Percentage", selection: $tipPercentage) {
						ForEach(0..<tipPercentages.count) {
							Text("\(self.tipPercentages[$0])%")
						}
					}
					.pickerStyle(SegmentedPickerStyle())
				}
				
				// Challenge 1
				Section(header: Text("Total amount per person is")) {
					Text("\(totalPerPerson)")
				}
				
				// Challenge 2
				Section(header: Text("Grand total amount with tips")) {
					Text("\(grandTotal)")
				}
			}
			.navigationTitle("WeSplit")
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		ContentView()
			.preferredColorScheme(.dark)
    }
}
