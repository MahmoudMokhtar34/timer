import 'package:flutter/material.dart';

class Timer extends StatefulWidget {
  const Timer({
    Key? key,
  }) : super(key: key);

  @override
  State<Timer> createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  List<Duration> sessions = [];
  int x = 0;
  var value = 0;
  int z = 0;
  static const Duration zero = Duration(seconds: 0);
  DateTime startTime = DateTime.now();
  Duration currentDuration = zero;
  Duration sessionDuration = zero;
  bool isStarted = false;

  Duration calcDuration({required DateTime startTime, DateTime? endTime}) {
    print('### calc ${value++}');
    endTime = endTime ?? DateTime.now();

    return endTime.difference(startTime);
  }

  void activateTimer() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));

      if (isStarted) {
        setState(() {
          // value += 1;
          // x = value;
          // print(x);
          currentDuration = calcDuration(startTime: startTime);
        });
        return false;
      }
      return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('### build ${x++}');
    activateTimer();
    return Column(
      children: [
        Text(x.toString()),
        Text(
          'time ${formatDuration(sessionDuration + currentDuration)}',
        ),

        ElevatedButton(
          onPressed: () {
            setState(() {
              isStarted = isStarted ? false : true;
              if (isStarted) {
                startTime = DateTime.now();
                currentDuration = zero;
              } else {
                sessionDuration = sessionDuration + currentDuration;
                currentDuration = zero;
              }
            });
          },
          child: Text(isStarted
              ? 'pause'
              : (sessionDuration == zero ? 'Start' : 'Resume')),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              isStarted = false;
              sessionDuration = sessionDuration + currentDuration;
              sessions.add(sessionDuration);
              currentDuration = zero;
              sessionDuration = zero;
            });
          },
          child: const Text('Stop'),
        ),

        Text('total session time ${formatDuration(sessionDuration)}'),
        Builder(builder: (context) {
          print('### builer 2 ${z++}');
          return ElevatedButton(
              onPressed: () {
                setState(() {
                  sessions.clear();
                });
              },
              child: const Text('clear list'));
        }),
        ...sessions.map((e) => Text(e.toString()))

        //: ${timePassed.inMinutes} :${timePassed.inSeconds}'
      ],
    );
  }

  String formatDuration(Duration duration) {
    return duration.toString();
    //substring(0, duration.toString().indexOf('.'))
  }
}
