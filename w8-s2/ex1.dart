import 'package:flutter/material.dart';

void main() => runApp(const ExpenseApp());

class ExpenseApp extends StatelessWidget {
  const ExpenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const ExpenseForm(),
    );
  }
}

enum Category { FOOD, TRAVEL, LEISURE, WORK }

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({super.key});

  @override
  _ExpenseFormState createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  Category? _selectedCategory; // Holds the selected category

  void _saveExpense() {
    if (_titleController.text.isEmpty ||
        _amountController.text.isEmpty ||
        _selectedCategory == null) {
      // Show an error if any field is empty
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Please fill out all fields and select a category.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    // Create the expense item
    final expense = {
      'title': _titleController.text,
      'amount': _amountController.text,
      'category': _selectedCategory!.name.toUpperCase(),
    };

    print('Expense Saved: $expense');

    // Clear form after saving
    _titleController.clear();
    _amountController.clear();
    setState(() {
      _selectedCategory = null;
    });

    // Show confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Expense Saved Successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Expense'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Input Field
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              maxLength: 50,
            ),
            SizedBox(height: 16),

            // Amount Input Field
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            // Dropdown Button
            DropdownButton<Category>(
              value: _selectedCategory,
              hint: const Text('Select Category'),
              isExpanded: true,
              items: Category.values.map((category) {
                return DropdownMenuItem<Category>(
                  value: category,
                  child: Text(category.name.toUpperCase()),
                );
              }).toList(),
              onChanged: (Category? newValue) {
                setState(() {
                  _selectedCategory = newValue;
                });
              },
            ),
            const SizedBox(height: 32),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Cancel Button
                TextButton(
                  onPressed: () {
                    // Clear the form
                    _titleController.clear();
                    _amountController.clear();
                    setState(() {
                      _selectedCategory = null;
                    });
                  },
                  child: const Text('Cancel'),
                ),

                // Save Button
                ElevatedButton(
                  onPressed: _saveExpense,
                  child: const Text('Save Expense'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
