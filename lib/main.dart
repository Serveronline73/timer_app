import 'package:flutter/material.dart';
import 'package:timer_app/timer_button.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Stopwatch",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.blue,
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Bitte stelle Timer ein",
                    hintStyle: TextStyle(fontSize: 20),
                  ),
                  textAlign: TextAlign.center),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TimerButton(text: "Start"),
                  SizedBox(width: 10),
                  TimerButton(text: "Stop"),
                  SizedBox(width: 10),
                  TimerButton(text: "Clear"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
