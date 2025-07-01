import 'package:flutter/material.dart';

void main() {
  runApp(TapTapGame());
}

class TapTapGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TapTap Game',
      debugShowCheckedModeBanner: false,
      home: TapGamePage(),
    );
  }
}

class TapGamePage extends StatefulWidget {
  @override
  _TapGamePageState createState() => _TapGamePageState();
}

class _TapGamePageState extends State<TapGamePage> {
  int _score = 0;
  int _timeLeft = 10;
  bool _isGameStarted = false;
  late final Stopwatch _stopwatch;

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
  }

  void _startGame() {
    setState(() {
      _score = 0;
      _timeLeft = 10;
      _isGameStarted = true;
    });
    _stopwatch.reset();
    _stopwatch.start();
    _startTimer();
  }

  void _startTimer() {
    Future.doWhile(() async {
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        _timeLeft--;
      });
      if (_timeLeft <= 0) {
        _stopwatch.stop();
        _isGameStarted = false;
        return false;
      }
      return true;
    });
  }

  void _tap() {
    if (_isGameStarted) {
      setState(() {
        _score++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _isGameStarted ? 'Tap!' : 'Tap to Start',
              style: TextStyle(fontSize: 32, color: Colors.white),
            ),
            SizedBox(height: 30),
            Text(
              'Score: $_score',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            Text(
              'Time Left: $_timeLeft s',
              style: TextStyle(fontSize: 20, color: Colors.white70),
            ),
            SizedBox(height: 40),
            GestureDetector(
              onTap: _isGameStarted ? _tap : _startGame,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  _isGameStarted ? 'TAP!' : 'START',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
