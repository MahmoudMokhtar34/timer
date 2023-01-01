// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:async';

import 'package:flutter/foundation.dart';

class AppState {
  int test = 0;
  int test2 = 0;
  int press = 0;
  List<Duration> sessions;
  static const Duration zeroingDuration = Duration(seconds: 0);
  DateTime? sessionStartTime;
  //each (start or resume)/pause  cycle has its own currentduration
  Duration lapDuration;
  Duration sessionDuration;
  bool isStarted;
  Timer? timerObject;

  AppState({
    required this.sessions,
    this.sessionStartTime,
    this.lapDuration = zeroingDuration,
    this.sessionDuration = zeroingDuration,
    this.isStarted = false,
    this.timerObject,
  });

  AppState copyWith({
    List<Duration>? sessions,
    DateTime? sessionStartTime,
    Duration? lapDuration,
    Duration? sessionDuration,
    bool? isStarted,
    Timer? timerObject,
  }) {
    return AppState(
      sessions: sessions ?? this.sessions,
      sessionStartTime: sessionStartTime ?? this.sessionStartTime,
      lapDuration: lapDuration ?? this.lapDuration,
      sessionDuration: sessionDuration ?? this.sessionDuration,
      isStarted: isStarted ?? this.isStarted,
      timerObject: timerObject ?? this.timerObject,
    );
  }

  @override
  String toString() {
    return 'AppState(sessions: $sessions, sessionStartTime: $sessionStartTime, currentDuration: $lapDuration, sessionDuration: $sessionDuration, isStarted: $isStarted, timerObject: $timerObject)';
  }

  @override
  bool operator ==(covariant AppState other) {
    if (identical(this, other)) return true;

    return listEquals(other.sessions, sessions) &&
        other.sessionStartTime == sessionStartTime &&
        other.lapDuration == lapDuration &&
        other.sessionDuration == sessionDuration &&
        other.isStarted == isStarted &&
        other.timerObject == timerObject;
  }

  @override
  int get hashCode {
    return sessions.hashCode ^
        sessionStartTime.hashCode ^
        lapDuration.hashCode ^
        sessionDuration.hashCode ^
        isStarted.hashCode ^
        timerObject.hashCode;
  }
}
