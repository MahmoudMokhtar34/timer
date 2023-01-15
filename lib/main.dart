import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'model/state_widget.dart';

import 'pages/home_page/home_page.dart';

void main() {
  debugPaintSizeEnabled = false;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const StateWidget(
      child: MaterialApp(
        title: 'Timer',
        home: HomePage(),
      ),
    );
  }
}



// // ignore_for_file: avoid_print

// import 'package:flutter/material.dart';
// import 'package:timer/model/app_state.dart';
// import 'package:timer/model/state_widget.dart';

// class TimeWidget extends StatefulWidget {
//   const TimeWidget({
//     Key? key,
//     required this.provider,
//     required this.appState,
//     required this.textStyle,
//   }) : super(key: key);

//   final Provider provider;
//   final AppState appState;
//   final TextStyle textStyle;

//   @override
//   State<TimeWidget> createState() => _TimeWidgetState();
// }

// class _TimeWidgetState extends State<TimeWidget> {
//   final tenHours =
//       const Duration(hours: 10, minutes: 0, seconds: 0, milliseconds: 0);
//   @override
//   void initState() {
//     super.initState();
//   }

// //activating the timer here to avoid recursion if done in the build method
//   @override
//   void didUpdateWidget(covariant TimeWidget oldWidget) {
//     widget.provider.activateTimerTimer(setState: setState);
//     super.didUpdateWidget(oldWidget);
//   }

//   @override
//   Widget build(BuildContext context) {
//     print('### build 2 ${widget.appState.test2++}');

//     return time();
//   }

//   Text time() {
//     Duration currentSession =
//         widget.appState.sessionDuration + widget.appState.lapDuration;
//     return Text(
//       //add extra zero at the left for less than 10 hours duration
//       '${currentSession < tenHours ? '0' : ''}${widget.provider.formatDuration(currentSession)}',
//       style: widget.textStyle,
//     );
//   }
// }
