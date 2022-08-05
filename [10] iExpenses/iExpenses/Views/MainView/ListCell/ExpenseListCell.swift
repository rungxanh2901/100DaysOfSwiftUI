//
//  ExpenseListCell.swift
//  iExpenses
//
//  Created by Joe Pham on 2022-08-04.
//

import SwiftUI

struct ExpenseListCell: View {
	
	let expenseItem: ExpenseItem
	
	@ObservedObject
	var viewModel: ExpenseListCellViewModel
	
	var body: some View {
		HStack {
			VStack(alignment: .leading) {
				Text(expenseItem.name)
					.font(.system(.headline, design: .rounded))
				Text(expenseItem.type.rawValue)
					.font(.system(.caption2, design: .rounded))
			}
			
			Spacer()
			
			Text(
				expenseItem.amount,
				format: .currency(code: Locale.current.currencyCode ?? "USD")
			)
			.font(.system(.callout, design: .monospaced))
			.foregroundColor(viewModel.colorForAmount)
		}
	}
}

struct ExpenseListCell_Previews: PreviewProvider {
	static var previews: some View {
		let sampleItem = ExpenseItem(name: "Breakfast", type: ExpenseType.personal, amount: 10.99)
		ExpenseListCell(
			expenseItem: sampleItem,
			viewModel: ExpenseListCellViewModel(
				item: sampleItem
			)
		)
	}
}