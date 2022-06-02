//
//  ExpenceCell.swift
//  iExpense
//
//  Created by Roman Zherebko on 02.06.2022.
//

import SwiftUI

struct ExpenseCell: View {
    let item: ExpenseItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text(item.type)
            }

            Spacer()

            Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                .foregroundColor(item.amount < 10 ? .green : item.amount < 100 ? .blue : .red)
        }
    }
}

struct ExpenceCell_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseCell(item: ExpenseItem(name: "launch", type: "Personal", amount: 44))
    }
}
