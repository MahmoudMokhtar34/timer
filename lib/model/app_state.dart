// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:async';

import 'package:flutter/foundation.dart';

class AppState {
  int test;
  int test2;
  int press;
  List<Duration> sessions;
  static const Duration zeroingDuration = Duration(seconds: 0);
  DateTime? sessionStartTime;
  //each (start or resume)/pause  cycle has its own currentduration
  Duration lapDuration;
  Duration sessionDuration;
  bool isStarted;
  Timer? timerObject;
  Duration sessionLimit;

  AppState({
    this.test = 0,
    this.test2 = 0,
    this.press = 0,
    required this.sessions,
    this.sessionStartTime,
    this.lapDuration = zeroingDuration,
    this.sessionDuration = zeroingDuration,
    this.isStarted = false,
    this.timerObject,
    this.sessionLimit = const Duration(minutes: 1, seconds: 30),
  });

  AppState copyWith({
    int? test,
    int? test2,
    int? press,
    List<Duration>? sessions,
    DateTime? sessionStartTime,
    Duration? lapDuration,
    Duration? sessionDuration,
    bool? isStarted,
    Timer? timerObject,
    Duration? sessionLimit,
  }) {
    return AppState(
      test: test ?? this.test,
      test2: test2 ?? this.test2,
      press: press ?? this.press,
      sessions: sessions ?? this.sessions,
      sessionStartTime: sessionStartTime ?? this.sessionStartTime,
      lapDuration: lapDuration ?? this.lapDuration,
      sessionDuration: sessionDuration ?? this.sessionDuration,
      isStarted: isStarted ?? this.isStarted,
      timerObject: timerObject ?? this.timerObject,
      sessionLimit: sessionLimit ?? this.sessionLimit,
    );
  }

  @override
  String toString() {
    return 'AppState(test: $test, test2: $test2, press: $press, sessions: $sessions, sessionStartTime: $sessionStartTime, lapDuration: $lapDuration, sessionDuration: $sessionDuration, isStarted: $isStarted, timerObject: $timerObject, sessionLimit: $sessionLimit)';
  }

  @override
  bool operator ==(covariant AppState other) {
    if (identical(this, other)) return true;

    return other.test == test &&
        other.test2 == test2 &&
        other.press == press &&
        listEquals(other.sessions, sessions) &&
        other.sessionStartTime == sessionStartTime &&
        other.lapDuration == lapDuration &&
        other.sessionDuration == sessionDuration &&
        other.isStarted == isStarted &&
        other.timerObject == timerObject &&
        other.sessionLimit == sessionLimit;
  }

  @override
  int get hashCode {
    return test.hashCode ^
        test2.hashCode ^
        press.hashCode ^
        sessions.hashCode ^
        sessionStartTime.hashCode ^
        lapDuration.hashCode ^
        sessionDuration.hashCode ^
        isStarted.hashCode ^
        timerObject.hashCode ^
        sessionLimit.hashCode;
  }
}
