//
//  ContentView.swift
//  iExpense
//
//  Created by Roman Zherebko on 02.06.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false

     var body: some View {
        NavigationView {
            List {
                Section("Personal") {
                    ForEach(expenses.items.filter({$0.type == "Personal"})) { item in
                        ExpenseCell(item: item)
                    }
                    .onDelete(perform: removePersonalItems)
                }
                
                Section("Business") {
                    ForEach(expenses.items.filter({$0.type == "Business"})) { item in
                        ExpenseCell(item: item)
                    }
                    .onDelete(perform: removeBusinessItems)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeBusinessItems(at offsets: IndexSet) {
        for i in offsets.makeIterator() {
            let theItem = expenses.items.filter({$0.type == "Business"})[i]
            expenses.items.removeAll(where: {$0.id == theItem.id})
        }
    }
    
    func removePersonalItems(at offsets: IndexSet) {
        for i in offsets.makeIterator() {
            let theItem = expenses.items.filter({$0.type == "Personal"})[i]
            expenses.items.removeAll(where: {$0.id == theItem.id})
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
