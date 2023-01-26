import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? prefs;

  static const keysessions = 'sessions';

  static Future<SharedPreferences> intitPrefs() async {
    return prefs = await SharedPreferences.getInstance();
  }

  static Future saveAllSessions(List<Duration> sessions) async {
    List<String> sessionsString = sessions.map((e) => e.toString()).toList();
    return await prefs?.setStringList(keysessions, sessionsString);
  }

  static Future saveOneSession(Duration session) async {
    String sessionsString = session.toString();
    List<String> storedSessions = prefs?.getStringList(keysessions) ?? [];
    storedSessions.add(sessionsString);
    return await prefs?.setStringList(keysessions, storedSessions);
  }

  // static Future deleteOneSession(int index) async {
  //   List<String> storedSessions = prefs?.getStringList(keysessions) ?? [];
  //   storedSessions.removeAt(index);
  //   return await prefs?.setStringList(keysessions, storedSessions);
  // }

  static List<Duration> getSessions() {
    List<String> sessionsString = prefs?.getStringList(keysessions) ?? [];
    return sessionsString.map((e) => parseDuration(e)).toList();
  }

  static Future deleteSessions() async {
    return await prefs?.setStringList(keysessions, []);
  }

  static Duration parseDuration(String s) {
    int hours = 0;
    int minutes = 0;
    int micros;
    List<String> parts = s.split(':');
    if (parts.length > 2) {
      hours = int.parse(parts[parts.length - 3]);
    }
    if (parts.length > 1) {
      minutes = int.parse(parts[parts.length - 2]);
    }
    micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
    return Duration(hours: hours, minutes: minutes, microseconds: micros);
  }
}
