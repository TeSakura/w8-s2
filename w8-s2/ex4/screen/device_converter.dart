import 'package:flutter/material.dart';

class DeviceConverter extends StatefulWidget {
  const DeviceConverter({super.key});

  @override
  State<DeviceConverter> createState() => _DeviceConverterState();
}

class _DeviceConverterState extends State<DeviceConverter> {
  final TextEditingController _dollarController = TextEditingController();
  final BoxDecoration textDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
  );

  // Dropdown items for the devices
  final List<String> devices = ['EURO', 'RIELS', 'DONG'];

  // Conversion rates
  final Map<String, double> conversionRates = {
    'EURO': 0.9,      // 1 USD = 0.9 EURO
    'RIELS': 4100.0,  // 1 USD = 4100 RIELS
    'DONG': 24000.0,  // 1 USD = 24000 DONG
  };

  String? _selectedDevice; // Selected device from the dropdown
  String _convertedAmount = ""; // Converted amount

  void _convert() {
    // Ensure valid input and device selection
    if (_dollarController.text.isEmpty || _selectedDevice == null) {
      setState(() {
        _convertedAmount = "Invalid input or no device selected!";
      });
      return;
    }

    // Parse the dollar amount
    double dollarAmount = double.tryParse(_dollarController.text) ?? 0;

    // Get the conversion rate for the selected device
    double conversionRate = conversionRates[_selectedDevice]!;
    double convertedValue = dollarAmount * conversionRate;

    // Update the state with the converted amount
    setState(() {
      _convertedAmount = convertedValue.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.money,
              size: 60,
              color: Colors.white,
            ),
            const Center(
              child: Text(
                "Converter",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
            const SizedBox(height: 50),
            const Text("Amount in dollars:", style: TextStyle(color: Colors.white)),
            const SizedBox(height: 10),

            // TextField for dollar input
            TextField(
              controller: _dollarController,
              decoration: InputDecoration(
                prefix: const Text('\$ '),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 1.0),
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'Enter an amount in dollars',
                hintStyle: const TextStyle(color: Colors.white),
              ),
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
            ),

            const SizedBox(height: 30),

            // Dropdown for device selection
            const Text("Device:", style: TextStyle(color: Colors.white)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: textDecoration,
              child: DropdownButton<String>(
                value: _selectedDevice,
                isExpanded: true,
                hint: const Text('Select a device', style: TextStyle(color: Colors.black)),
                items: devices.map((device) {
                  return DropdownMenuItem<String>(
                    value: device,
                    child: Text(device, style: const TextStyle(color: Colors.black)),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedDevice = newValue;
                  });
                },
              ),
            ),

            const SizedBox(height: 30),

            // Converted amount display
            const Text("Amount in selected device:", style: TextStyle(color: Colors.white)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: textDecoration,
              child: Text(
                _convertedAmount.isEmpty ? "Enter values to convert" : _convertedAmount,
                style: const TextStyle(color: Colors.black),
              ),
            ),

            const SizedBox(height: 30),

            // Convert Button
            ElevatedButton(
              onPressed: _convert,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Convert'),
            ),
          ],
        ),
      ),
    );
  }
}
