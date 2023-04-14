import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Challenge',
      home: PomodoroScreen(),
    );
  }
}

class PomodoroScreen extends StatefulWidget {
  const PomodoroScreen({super.key});

  @override
  State<PomodoroScreen> createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
  static const int initSeconds = 900;
  static const int initRound = 5;
  static const int initGoal = 13;
  int checkedSeconds = initSeconds;
  int seconds = initSeconds;
  bool isPlay = false;
  late Timer timer;
  int round = 0;
  int goal = 0;

  String formatMinutes(int seconds) {
    final duration = Duration(seconds: seconds);
    return duration.toString().substring(2, 4);
  }

  String formatSeconds(int seconds) {
    final duration = Duration(seconds: seconds);
    return duration.toString().substring(5, 7);
  }

  void _onTick(Timer timer) {
    if (seconds == 0) {
      round++;
      seconds = checkedSeconds;

      if (round == initRound) {
        round = 0;
        goal++;
      }

      if (goal == initGoal) {
        goal = 0;
        isPlay = false;
        timer.cancel();
      }
    } else {
      seconds--;
    }

    setState(() {});
  }

  void _onPlayTap() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      _onTick,
    );
    isPlay = true;
    setState(() {});
  }

  void _onPausedTap() {
    timer.cancel();
    isPlay = false;
    setState(() {});
  }

  void _onResetPressed() {
    seconds = checkedSeconds;
    round = 0;
    goal = 0;
    _onPausedTap();
    setState(() {});
  }

  void _onSampleSecondTap(int seconds) {
    checkedSeconds = seconds;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                "POMODOROTIMER",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      formatMinutes(checkedSeconds),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: Center(
                    child: Text(
                      ':',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 120,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      formatSeconds(seconds),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SampleButton(
                  seconds: 900,
                  onTap: _onSampleSecondTap,
                  isSelected: checkedSeconds == 900,
                ),
                const SizedBox(
                  width: 10,
                ),
                SampleButton(
                  seconds: 1200,
                  onTap: _onSampleSecondTap,
                  isSelected: checkedSeconds == 1200,
                ),
                const SizedBox(
                  width: 10,
                ),
                SampleButton(
                  seconds: 1500,
                  onTap: _onSampleSecondTap,
                  isSelected: checkedSeconds == 1500,
                ),
                const SizedBox(
                  width: 10,
                ),
                SampleButton(
                  seconds: 1800,
                  onTap: _onSampleSecondTap,
                  isSelected: checkedSeconds == 1800,
                ),
                const SizedBox(
                  width: 10,
                ),
                SampleButton(
                  seconds: 2100,
                  onTap: _onSampleSecondTap,
                  isSelected: checkedSeconds == 2100,
                ),
              ],
            ),
            const SizedBox(
              height: 80,
            ),
            !isPlay
                ? GestureDetector(
                    onTap: _onPlayTap,
                    child: const Icon(
                      Icons.play_circle_outline,
                      color: Colors.white,
                      size: 80,
                    ),
                  )
                : GestureDetector(
                    onTap: _onPausedTap,
                    child: const Icon(
                      Icons.pause_circle_outline,
                      color: Colors.white,
                      size: 80,
                    ),
                  ),
            const SizedBox(
              height: 30,
            ),
            if (isPlay)
              GestureDetector(
                onTap: _onResetPressed,
                child: Container(
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      'RESET',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      '$round/${initRound - 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    const Text(
                      'ROUND',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Text(
                      '$goal/${initGoal - 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    const Text(
                      'GOAL',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SampleButton extends StatelessWidget {
  const SampleButton(
      {super.key,
      required this.seconds,
      required this.onTap,
      required this.isSelected});

  final int seconds;
  final Function(int) onTap;
  final bool isSelected;

  String formatMinutes(int seconds) {
    final duration = Duration(seconds: seconds);
    return duration.toString().substring(2, 4);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(seconds),
      child: Container(
        width: 60,
        height: 40,
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.grey.shade900,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            formatMinutes(seconds),
            style: TextStyle(
              color: isSelected ? Colors.black : Colors.white,
              fontSize: 25,
            ),
          ),
        ),
      ),
    );
  }
}
