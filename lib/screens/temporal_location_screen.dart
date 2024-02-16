import 'package:sprint/bloc_location/location.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const TemporalLocationScreen());
}

class TemporalLocationScreen extends StatelessWidget {
  const TemporalLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp( // Agrega MaterialApp aquí
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Geolocator'),
          backgroundColor: Colors.blue,
          centerTitle: true,
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              Location().getCurrentLocation();
            },
            child: const Text('Ubicación'),
          ),
        ),
      ),
    );
  }
}