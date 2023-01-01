// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:timer/model/app_state.dart';
import 'package:timer/model/state_widget.dart';

class TimeWidget extends StatefulWidget {
  const TimeWidget({
    Key? key,
    required this.provider,
    required this.appState,
  }) : super(key: key);

  final Provider provider;
  final AppState appState;

  @override
  State<TimeWidget> createState() => _TimeWidgetState();
}

class _TimeWidgetState extends State<TimeWidget> {
  @override
  void initState() {
    super.initState();
  }

//activating the timer here to avoid recursion if done in the build method
  @override
  void didUpdateWidget(covariant TimeWidget oldWidget) {
    widget.provider.activateTimerTimer(setState: setState);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    print('### build 2 ${widget.appState.test2++}');
    return Text(
      'time ${widget.provider.formatDuration(widget.appState.sessionDuration + widget.appState.lapDuration)}',
    );
  }
}
