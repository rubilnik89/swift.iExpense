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
                if expenses.items.filter({$0.type == "Personal"}).count > 0 {
                    Section("Personal") {
                        ForEach(expenses.items.filter({$0.type == "Personal"})) { item in
                            ExpenseCell(item: item)
                        }
                        .onDelete(perform: removePersonalItems)
                    }
                }
                
                if expenses.items.filter({$0.type == "Business"}).count > 0 {
                    Section("Business") {
                        ForEach(expenses.items.filter({$0.type == "Business"})) { item in
                            ExpenseCell(item: item)
                        }
                        .onDelete(perform: removeBusinessItems)
                    }
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
        remove(type: "Business", offsets: offsets)
    }
    
    func removePersonalItems(at offsets: IndexSet) {
        remove(type: "Personal", offsets: offsets)
    }
    
    func remove(type: String, offsets: IndexSet) {
        for i in offsets.makeIterator() {
            let theItem = expenses.items.filter({$0.type == type})[i]
            expenses.items.removeAll(where: {$0.id == theItem.id})
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
