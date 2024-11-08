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

final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class _MainAppState extends State<MainApp> {
  final TextEditingController _controller = TextEditingController();
  int _remainingTime = 0; // Verbleinde Zeit des Timers
  bool _isRunning = false; //Zeigt an, ob der Timer läuft

  Future<void> _startTimer() async {
    while (_remainingTime > 0 && _isRunning) {
      await Future<void>.delayed(const Duration(seconds: 1));
      setState(() {
        _remainingTime--; // Zeit um 1 Sekunde reduzieren
      });
    }
    if (_remainingTime == 0) {
      // Ende der Zeit wenn timer auf 0 ist
      setState(() {
        _isRunning = false; // Timer stoppen, wenn die Zeit abgelaufen ist
      });
      scaffoldMessengerKey.currentState!.showSnackBar(
        const SnackBar(content: Text("Timer abgelaufen!")),
      );
    }
  }

  void _onStart() {
    // Timer wird gestarten
    if (_controller.text.isEmpty) return;
    setState(() {
      _remainingTime = int.parse(_controller.text);
      _isRunning = true;
    });
    _startTimer();

    scaffoldMessengerKey.currentState!.showSnackBar(
      const SnackBar(content: Text("Timer gestartet!")),
    );
  }

  void _onStop() {
    // Timer wird gestoppt
    setState(() {
      _isRunning = false;
    });
    scaffoldMessengerKey.currentState!.showSnackBar(
      const SnackBar(content: Text("Timer gestoppt!")),
    );
  }

  void _onClear() {
    // Timer wird zurückgesetzt
    _controller.clear();
    setState(() {
      _remainingTime = 0;
      _isRunning = false;
    });
    scaffoldMessengerKey.currentState!
        .showSnackBar(const SnackBar(content: Text("Timer zurückgesetzt!")));
  }

  String _formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int secs = seconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: scaffoldMessengerKey,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text(
            "Timer",
            style: TextStyle(
                color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 25),
          ),
          backgroundColor: Colors.black,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.amber, fontSize: 30),
                  cursorColor: Colors
                      .amber, // Nur Zahlen erlaubt damit die Eingabe funktioniert
                  decoration: const InputDecoration(
                    hintText: "Bitte stelle Timer ein",
                    hintStyle: TextStyle(fontSize: 25, color: Colors.amber),
                  ),
                  textAlign: TextAlign.center),
              const SizedBox(height: 30),
              const Text(
                "CountDown Zähler:",

                textAlign: TextAlign.center, // Anzeige der verbleibenden Zeit
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber),
              ),
              Text(
                _formatTime(_remainingTime),
                style: TextStyle(
                  fontSize: 50,
                  color: _remainingTime == 0 ? Colors.amber : Colors.red,
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TimerButton(
                      text: "Start",
                      onTap: _onStart,
                      color: Colors.green,
                      textColor: Colors.white),
                  const SizedBox(width: 10),
                  TimerButton(
                      text: "Stop",
                      onTap: _onStop,
                      color: Colors.red,
                      textColor: Colors.white),
                  const SizedBox(width: 10),
                  TimerButton(
                      text: "Clear",
                      onTap: _onClear,
                      color: Colors.grey,
                      textColor: Colors.white),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
