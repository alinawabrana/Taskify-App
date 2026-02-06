import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  //Singleton instance
  static final SharedPreferencesService _instance =
      SharedPreferencesService._internal();

  // Factory constructor
  factory SharedPreferencesService() {
    return _instance;
  }

  // Internal constructor
  SharedPreferencesService._internal();

  // SHaredPreferences instance
  static SharedPreferences? _prefs;

  // Initialize it once (call this in main() before runAPP)
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  //------------------SETTERS-------------------//

  Future<void> setString(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  Future<void> setBool(String key, bool value) async {
    await _prefs?.setBool(key, value);
  }

  Future<void> setInt(String key, int value) async {
    await _prefs?.setInt(key, value);
  }

  Future<void> setStringList(String key, String value) async {
    List<String> updatedList = _prefs?.getStringList(key) ?? [];
    if (updatedList.contains(value)) return;
    updatedList.add(value);
    await _prefs?.setStringList(key, updatedList);
  }

  Future<void> addSearchQueryUsingKey(String key, String query) async {
    List<String> history = _prefs?.getStringList(key) ?? [];
    // If the query is already done then remove previous instance
    history.remove(query);
    // Add the query at the top/start of the list
    history.insert(0, query);
    // If list increases than 10 then show first 10 values only
    if (history.length > 10) {
      history = history.sublist(0, 10);
    }
    await _prefs?.setStringList(key, history);
  }

  Future<void> addSearchQuery(String query) async {
    List<String> history = _prefs?.getStringList('searchHistory') ?? [];
    // If the query is already done then remove previous instance
    history.remove(query);
    // Add the query at the top/start of the list
    history.insert(0, query);
    // If list increases than 10 then show first 10 values only
    if (history.length > 10) {
      history = history.sublist(0, 10);
    }
    await _prefs?.setStringList('searchHistory', history);
  }

  //------------------GETTERS-------------------//
  String? getString(String key) {
    return _prefs?.getString(key) ?? '';
  }

  int? getInt(String key) {
    return _prefs?.getInt(key) ?? 0;
  }

  bool? getBool(String key) {
    return _prefs?.getBool(key) ?? false;
  }

  List<String> getStringList(String key) {
    return _prefs?.getStringList(key) ?? [];
  }

  List<String> getSearchHistory() {
    return _prefs?.getStringList('searchHistory') ?? [];
  }

  //------------------REMOVE & CLEAR-------------------//
  Future<void> remove(String key) async {
    await _prefs?.remove(key);
  }

  Future<void> removeAddedSearchHistory(String value) async {
    List<String> history = _prefs?.getStringList('searchHistory') ?? [];

    if (history.isEmpty) return;

    history.remove(value);

    await _prefs?.setStringList('searchHistory', history);
  }

  Future<void> clearAll() async {
    await _prefs?.clear();
  }
}
