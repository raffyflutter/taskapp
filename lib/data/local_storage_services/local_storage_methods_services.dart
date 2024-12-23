import 'package:taskapp/data/local_storage_services/shared_preferences.dart';

class LocalStorageMethods {
  LocalStorageMethods._();
  static final instance = LocalStorageMethods._();

  Future<void> writeUserApiToken(String token) async {
    await Prefs.setString("api_token", token);
  }

  String? getUserApiToken() {
    String? token = Prefs.getString("api_token");
    return token;
  }

  // Write the Username
  Future<void> writeUsername(String name) async {
    await Prefs.setString("name", name);
  }

  // Get the stored Username
  String? getUsername() {
    String? name = Prefs.getString("name");
    return name;
  }

  // Clear all stored data
  Future<void> clear() async {
    await Prefs.remove("api_token");
    await Prefs.remove("name");
  }
}
