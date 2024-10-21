//
//  ContentView.swift
//  SwiftDataExample
//
//  Created by Pasham Srinivas Goud on 17/10/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @State private var isShowingIteamsSheet=false
    @Environment(\.modelContext) var context
    
    @Query(sort: \Expences.date) var expenses: [Expences]
    
    var body: some View {
        NavigationStack{
            List
            {
                ForEach(expenses){expense in
                    ExpenseCell(expense: expense)
                }.onDelete(perform: { indexSet in
                    for index in indexSet{
                        context.delete(expenses[index])
                    }
                })
            }
            .navigationTitle("Expenses")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $isShowingIteamsSheet) { AddExpensesSheet() }
            .toolbar {
                if !expenses.isEmpty {
                    Button("Add Expenses", systemImage: "plus"){
                        isShowingIteamsSheet = true
                    }
                }
            }
            .overlay {
                if expenses.isEmpty{
                    ContentUnavailableView(label: {
                        Label("No Expenses", systemImage: "List.bullet.rectangle.portrait")
                    },description: {
                        Text("Starting adding expences to see your list")
                    },actions: {
                        Button("Add Expense"){isShowingIteamsSheet = true }
                    })
                    .offset(y: -60)
                }
                    
            }
        }
    }
}

#Preview {
    ContentView()
}

struct ExpenseCell:View {
    let expense: Expences
    
    var body: some View {
        HStack
        {
            Text(expense.date,format: .dateTime.month(.abbreviated).day())
                .frame(width: 70,alignment: .leading)
            Text(expense.name)
            Spacer()
            Text(expense.value,format: .currency(code: "USD"))
        }
    }
}

struct AddExpensesSheet:View {
    
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var date: Date = .now
    @State private var value: Double = 0
    
    var body: some View {
        NavigationStack
        {
            Form
            {
                TextField("Expense Name", text: $name)
                DatePicker("Date", selection: $date)
                TextField("Value", value: $value, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("New Expense")
            .navigationBarTitleDisplayMode(.large)
            .toolbar{
                ToolbarItemGroup(placement: .topBarLeading){
                    Button("Cancle"){dismiss()}
                }
                ToolbarItemGroup(placement: .topBarTrailing){
                    Button("Save"){
                        // Save Code
                        let expense = Expences(name: name, date: date, value: value)
                        context.insert(expense)
                        dismiss()
                    }
                }
                
            }
        }
    }
}
