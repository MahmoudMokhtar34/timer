import 'dart:async';

import 'package:flutter/material.dart';

import './app_state.dart';
import './inherited_state.dart';

class StateWidget extends StatefulWidget {
  const StateWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<StateWidget> createState() => Provider();
}

class Provider extends State<StateWidget> {
  AppState appState = AppState(sessions: []);

  @override
  Widget build(BuildContext context) {
    return InheritedState(
      appState: appState,
      provider: this,
      child: widget.child,
    );
  }

  void activateTimerTimer({required Function setState}) {
    print('### to 1 ${appState.timerObject?.isActive}');
    if (appState.isStarted) {
      //check activity of timerObject
      if (appState.timerObject != null && appState.timerObject!.isActive) {
        return;
      }
      appState.timerObject = Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          setState(
            () {
              if (appState.sessionStartTime == null) return;
              appState.lapDuration =
                  DateTime.now().difference(appState.sessionStartTime!);
            },
          );
        },
      );
      print('### to 2 ${appState.timerObject?.isActive}');
    } else {
      appState.timerObject?.cancel();
    }
  }

//if any bug add these params
//
  void startPAuseResume({
    required AppState appState,
    required Provider provider,
    required Function setState,
  }) {
    setState(() {
      appState.isStarted = appState.isStarted ? false : true;
      if (appState.isStarted) {
        appState.sessionStartTime = DateTime.now();
        appState.lapDuration = AppState.zeroingDuration;
      } else {
        appState.timerObject?.cancel();
        appState.sessionDuration =
            appState.sessionDuration + appState.lapDuration;
        appState.lapDuration = AppState.zeroingDuration;
      }
    });
  }

//
  void stop({
    required AppState appState,
    required Function setState,
  }) {
    setState(() {
      appState.timerObject?.cancel();
      appState.isStarted = false;
      appState.sessionDuration =
          appState.sessionDuration + appState.lapDuration;
      appState.sessions.add(appState.sessionDuration);
      appState.lapDuration = AppState.zeroingDuration;
      appState.sessionDuration = AppState.zeroingDuration;
    });
  }

//
  void deleteSessions({
    required AppState appState,
    required Function setState,
  }) {
    setState(() {
      appState.sessions.clear();
    });
  }

  void deleteOneSession(AppState appState, int index, Function setState) {
    setState(() {
      appState.sessions.removeAt(index);
    });
  }

  String formatDuration(Duration duration) {
    return duration.toString().substring(0, duration.toString().indexOf('.'));
  }

  Duration sumSessions() {
    Duration sum = AppState.zeroingDuration;

    for (var element in appState.sessions) {
      sum += element;
    }

    return sum;
  }

  Duration avgSessions() {
    if (appState.sessions.isEmpty) {
      return AppState.zeroingDuration;
    }
    double avgInSeconds = sumSessions().inSeconds / appState.sessions.length;

    return Duration(seconds: avgInSeconds.floor());
  }
}
