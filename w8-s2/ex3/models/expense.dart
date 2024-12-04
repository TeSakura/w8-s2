import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Category {
  food(Icons.lunch_dining),
  travel(Icons.flight_takeoff),
  leisure(Icons.movie),
  work(Icons.work);

  final IconData icon;

  const Category(this.icon);
}

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return '${date.month}/${date.day}/${date.year}';
  }

  @override
  String toString() {
    return "Expense(title: $title, amount: $amount, category: ${category.name}, date: $formattedDate)";
  }
}

// A simple example of how you might display the expenses

class ExpenseList extends StatelessWidget {
  final List<Expense> expenses;

  const ExpenseList({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        final expense = expenses[index];
        return ListTile(
          leading: Icon(expense.category.icon),
          title: Text(expense.title),
          subtitle: Text('\$${expense.amount.toStringAsFixed(2)} - ${expense.formattedDate}'),
          trailing: Icon(Icons.delete),
          onTap: () {
            // Handle delete or other actions
          },
        );
      },
    );
  }
}
