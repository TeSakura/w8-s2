import 'package:flutter/material.dart';
import 'screen/device_converter.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.orange,
      fontFamily: 'Roboto',
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Device Converter'),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 252, 115, 47),
              Color.fromARGB(255, 201, 79, 17),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: DeviceConverter(),
        ),
      ),
    ),
  ));
}
