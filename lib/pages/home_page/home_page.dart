import 'package:flutter/material.dart';
import './timer.dart';

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
            flex: 6,
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
            flex: 0,
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
            flex: 0,
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
            flex: 0,
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

// class Timer extends StatefulWidget {
//   const Timer({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<Timer> createState() => _TimerState();
// }

//  class _TimerState extends State<Timer> {
//   List<Duration> sessions = [];
//   int x = 0;
//   var value = 0;
//   DateTime startTime = DateTime.now();
//   Duration durationPassed = const Duration(seconds: 0);
//   Duration sessionDuration = const Duration(seconds: 0);
//   Duration finalDuration = const Duration(seconds: 0);
//   bool isTicking = false;

//   Duration calcDuration({required DateTime startTime, DateTime? endTime}) {
//     endTime = endTime ?? DateTime.now();
//     return endTime.difference(startTime);
//   }

//   @override
//   Widget build(BuildContext context) {
//     Future.doWhile(() async {
//       value++;
//       await Future.delayed(const Duration(seconds: 1));
//       if (isTicking) {
//         setState(() {
//           x = value;
//           print(x);
//           durationPassed = sessionDuration +calcDuration(startTime: startTime);
//         });
//         return false;
//       }
//       return true;
//     });

//     return Column(
//       children: [
//         Text(x.toString()),
//         Text(
//           'time ${sessionDuration.toString().substring(0, sessionDuration.toString().indexOf('.'))}',
//         ),

//         ElevatedButton(
//           onPressed: () {
//             setState(() {
//               isTicking = isTicking ? false : true;
//               if (isTicking) {
//                 startTime = DateTime.now();
//                 //durationPassed = sessionDuration;
//                 print('### start $isTicking');
//                 print('###durationPassed $durationPassed');
//                 print('###sessionDuration $sessionDuration');
//                 print('###finalDuration $finalDuration');
//               } else {
//                 sessionDuration = durationPassed;
//                 //durationPassed = const Duration(seconds: 0);
//                 print('### stop $isTicking');
//                 print('###durationPassed $durationPassed');
//                 print('###sessionDuration $sessionDuration');
//                 print('###finalDuration $finalDuration');
//               }

//               print(isTicking);
//             });
//           },
//           child: Text(isTicking ? 'pause' : 'Resume'),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             setState(() {
//               isTicking = false;
//               finalDuration = sessionDuration + durationPassed;
//               sessions.add(sessionDuration);
//               print('### $isTicking');
//               print('###1 $durationPassed');
//               print('###2 $sessionDuration');
//               print('###3 $finalDuration');
//               durationPassed = const Duration(seconds: 0);
//               durationPassed = const Duration(seconds: 0);
//               sessionDuration = const Duration(seconds: 0);
//               print('### $isTicking');
//               print('###4 $durationPassed');
//               print('###5 $sessionDuration');
//               print('###6 $finalDuration');
//             });
//           },
//           child: const Text('Stop'),
//         ),

//         Text(
//             'total session time ${sessionDuration.toString().substring(0, sessionDuration.toString().indexOf('.'))}'),
//         ElevatedButton(
//             onPressed: () {
//               setState(() {
//                 sessions.clear();
//               });
//             },
//             child: const Text('clear list')),
//         ...sessions.map((e) => Text(e.toString()))

//         //: ${timePassed.inMinutes} :${timePassed.inSeconds}'
//       ],
//     );
//   }
// }

