import 'dart:typed_data';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  // ------------------ Basic Info ------------------
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _phoneNumber;
  String? _countryCode;
  DateTime? _dob;
  int? _age;
  String? _classGrade;
  String? _board;

  // ------------------ Parent Info ------------------
  String? _parentName;
  String? _parentEmail;
  String? _parentPhone;
  String? _parentCountryCode;

  // ------------------ Profile Info ------------------
  String? _bio;
  String? _gender;
  String? _profileImagePath; // Mobile/Desktop
  Uint8List? _profileImageBytes; // Web

  // ------------------ Learning ------------------
  String? _learningGoal;
  int? _learningMinutes;

  // ------------------ Reminders ------------------
  bool _dailyReminder = false;
  int? _reminderHour;
  int? _reminderMinute;
  String? _reminderPeriod;

  // ------------------ Stats ------------------
  int _trophies = 5;
  int _coins = 200;
  int _streak = 3;

  // ------------------ Getters ------------------
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  String? get phoneNumber => _phoneNumber;
  String? get countryCode => _countryCode;
  DateTime? get dob => _dob;
  int? get age => _age;
  String? get classGrade => _classGrade;
  String? get board => _board;

  String? get parentName => _parentName;
  String? get parentEmail => _parentEmail;
  String? get parentPhone => _parentPhone;
  String? get parentCountryCode => _parentCountryCode;

  String? get bio => _bio;
  String? get gender => _gender;
  String? get profileImagePath => _profileImagePath;
  Uint8List? get profileImageBytes => _profileImageBytes;

  String? get learningGoal => _learningGoal;
  int? get learningMinutes => _learningMinutes;

  bool get dailyReminder => _dailyReminder;
  int? get reminderHour => _reminderHour;
  int? get reminderMinute => _reminderMinute;
  String? get reminderPeriod => _reminderPeriod;

  int get trophies => _trophies;
  int get coins => _coins;
  int get streak => _streak;

  // ------------------ Setters ------------------
  void setName(String fName, String lName) {
    _firstName = fName;
    _lastName = lName;
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPhoneNumber(String countryCode, String phone) {
    _countryCode = countryCode;
    _phoneNumber = phone;
    notifyListeners();
  }

  void setDobAndAge(DateTime dob) {
    _dob = dob;
    _age = _calculateAge(dob);
    notifyListeners();
  }

  void setClassAndBoard(String classGrade, String board) {
    _classGrade = classGrade;
    _board = board;
    notifyListeners();
  }

  void setParentDetails(String name, String email, String countryCode, String phone) {
    _parentName = name;
    _parentEmail = email;
    _parentCountryCode = countryCode;
    _parentPhone = phone;
    notifyListeners();
  }

  void setBio(String newBio) {
    _bio = newBio;
    notifyListeners();
  }

  void setGender(String newGender) {
    _gender = newGender;
    notifyListeners();
  }

  /// Set profile image for mobile/desktop
  void setProfileImagePath(String path) {
    _profileImagePath = path;
    _profileImageBytes = null;
    notifyListeners();
  }

  /// Set profile image for web
  void setProfileImageBytes(Uint8List bytes) {
    _profileImageBytes = bytes;
    _profileImagePath = null;
    notifyListeners();
  }

  /// Clear profile image (works for all platforms)
  void clearProfileImage() {
    _profileImagePath = null;
    _profileImageBytes = null;
    notifyListeners();
  }

  bool get hasCustomProfileImage =>
    (_profileImagePath != null && _profileImagePath!.isNotEmpty) ||
    (_profileImageBytes != null);
    

  void setLearningGoal(String goal, int minutes) {
    _learningGoal = goal;
    _learningMinutes = minutes;
    notifyListeners();
  }

  // ------------------ Reminder ------------------
  void setReminderTime(int hour, int minute, String period) {
    _reminderHour = hour;
    _reminderMinute = minute;
    _reminderPeriod = period;
    _dailyReminder = true;
    notifyListeners();
  }

  void setDailyReminder(bool enabled) {
    _dailyReminder = enabled;
    if (!enabled) {
      _reminderHour = null;
      _reminderMinute = null;
      _reminderPeriod = null;
    }
    notifyListeners();
  }

  void refreshReminderStatus() {
    _dailyReminder = _dailyReminder || (_reminderHour != null && _reminderMinute != null);
    notifyListeners();
  }

  // ------------------ Stats ------------------
  void addTrophies(int amount) {
    _trophies += amount;
    notifyListeners();
  }

  void addCoins(int amount) {
    _coins += amount;
    notifyListeners();
  }

  void spendCoins(int amount) {
    _coins = (_coins - amount).clamp(0, _coins);
    notifyListeners();
  }

  void updateStreak(int newValue) {
    _streak = newValue;
    notifyListeners();
  }

  // ------------------ Helpers ------------------
  int _calculateAge(DateTime dob) {
    final now = DateTime.now();
    int age = now.year - dob.year;
    if (now.month < dob.month || (now.month == dob.month && now.day < dob.day)) {
      age--;
    }
    return age;
  }

  // ------------------ Clear User ------------------
  void clearUser() {
    _firstName = null;
    _lastName = null;
    _email = null;
    _phoneNumber = null;
    _countryCode = null;
    _dob = null;
    _age = null;
    _classGrade = null;
    _board = null;

    _parentName = null;
    _parentEmail = null;
    _parentPhone = null;
    _parentCountryCode = null;

    _bio = null;
    _gender = null;
    _profileImagePath = null;
    _profileImageBytes = null;

    _learningGoal = null;
    _learningMinutes = null;

    _dailyReminder = false;
    _reminderHour = null;
    _reminderMinute = null;
    _reminderPeriod = null;

    _trophies = 5;
    _coins = 200;
    _streak = 3;

    notifyListeners();
  }
}
