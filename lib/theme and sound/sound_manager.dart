import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SoundManager with ChangeNotifier {
  bool _soundEnabled = true;
  SharedPreferences? _prefs;

  SoundManager() {
    _loadSoundPref();
  }

  bool get soundEnabled => _soundEnabled;

  Future<void> _loadSoundPref() async {
    _prefs = await SharedPreferences.getInstance();
    _soundEnabled = _prefs?.getBool('soundEnabled') ?? true;
    notifyListeners();
  }

  void toggleSound(bool enabled) {
    _soundEnabled = enabled;
    _prefs?.setBool('soundEnabled', enabled);
    notifyListeners();
  }
}
