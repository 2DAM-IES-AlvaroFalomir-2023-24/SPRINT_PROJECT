import 'package:flutter/material.dart';
import 'package:sprint/screens/temporal_location_screen.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TemporalLocationScreen()), // Navega a TemporalLocationScreen cuando se presiona el botón
            );
          },
          child: Text('Ir a Temporal Location Screen'),
        ),
      ),
    );
  }
}