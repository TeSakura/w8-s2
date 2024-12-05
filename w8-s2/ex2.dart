import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Add intl package to format the date

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
      home: ExpenseForm(),
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
  Category? _selectedCategory;
  DateTime? _selectedDate;

  Future<void> _pickDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100), 
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
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
            const SizedBox(height: 16),

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
            const SizedBox(height: 16),

            // Date Picker (Text and IconButton)
            Row(
              children: [
                Text (
                  _selectedDate == null
                      ? 'Select Date'
                      : DateFormat('yyyy-MM-dd').format(_selectedDate!),
                  style: const TextStyle(fontSize: 16),
                ),
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: _pickDate,
                ),
              ],
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
                      _selectedDate = null;
                    });
                  },
                  child: const Text('Cancel'),
                ),

                // Save Button
                ElevatedButton(
                  onPressed: () {
                    // Print data to the console
                    print('Title: ${_titleController.text}');
                    print('Amount: ${_amountController.text}');
                    print('Category: $_selectedCategory');
                    print('Date: $_selectedDate');
                  },
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
