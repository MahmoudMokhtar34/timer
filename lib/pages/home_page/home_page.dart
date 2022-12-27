import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timer'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 4,
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
              ),
              child: const Center(child: Timer()),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            flex: 10,
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
              ),
              child: const Center(child: TimesList()),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            flex: 2,
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
              ),
              child: const Center(child: Statistics()),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            flex: 2,
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
              ),
              child: const Center(child: Controls()),
            ),
          ),
        ],
      ),
    );
  }
}

class Controls extends StatelessWidget {
  const Controls({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text('controls');
  }
}

class Statistics extends StatelessWidget {
  const Statistics({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text('statistics');
  }
}

class TimesList extends StatelessWidget {
  const TimesList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text('item'),
      ],
    );
  }
}

class Timer extends StatefulWidget {
  const Timer({
    Key? key,
  }) : super(key: key);

  @override
  State<Timer> createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  final DateTime start = DateTime.now();
  int x = 0;
  var value = 0;
  Duration timePassed = const Duration(seconds: 0);
  bool isPaused = true;

  Duration duration() {
    return DateTime.now().difference(start);
  }

  @override
  Widget build(BuildContext context) {
    Future.doWhile(() async {
      value++;
      await Future.delayed(const Duration(seconds: 1));
      if (value < 1000 && !isPaused) {
        setState(() {
          x = value;
          print(x);
          timePassed = duration();
        });
        return false;
      }
      return true;
    });
    return Column(
      children: [
        Text(x.toString()),
        Text(
            'time \ ${timePassed.toString().substring(0, timePassed.toString().indexOf('.'))}'),
        ElevatedButton(
            onPressed: () {
              setState(() {
                isPaused = isPaused ? false : true;
                print(isPaused);
              });
            },
            child: Text(
                'pause')) //: ${timePassed.inMinutes} :${timePassed.inSeconds}'
      ],
    );
  }
}
