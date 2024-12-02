import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  final String _baseUrl =
      'http://localhost:3000'; // Replace with your backend URL
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  String? _token;
  // Private constructor
  ApiService._internal();

  // Static instance
  static final ApiService _instance = ApiService._internal();

  // Factory constructor
  factory ApiService() => _instance;

  // Save token to secure storage
  Future<void> _saveToken(String token) async {
    await _storage.write(key: 'auth_token', value: token);
    _token = token;
  }

  // Load token from secure storage
  Future<void> loadToken() async {
    _token = await _storage.read(key: 'auth_token');
  }

  // Clear token from secure storage
  Future<void> clearToken() async {
    await _storage.delete(key: 'auth_token');
    _token = null;
  }

  // Set token and save it
  Future<void> setToken(String token) async {
    _token = token;
    await _saveToken(token);
  }

  // Signup
  Future<void> signup(String username, String password, String name) async {
    final url = Uri.parse('$_baseUrl/signup');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
          {'username': username, 'password': password, 'name': name}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to sign up: ${response.body}');
    }
    final data = jsonDecode(response.body);
    print('Signup Response: ${response.body}');
    await setToken(data['token']);
  }

  Future<void> logout() async {
    await clearToken();
  }

  // Login
  Future<void> login(String username, String password) async {
    final url = Uri.parse('$_baseUrl/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await setToken(data['token']);
    } else {
      throw Exception('Failed to login: ${response.body}');
    }
  }

  Future<void> resetPassword(String? username) async {
    // Check if user exists

    // change password
    
  }

  // Fetch user information
  Future<Map<String, dynamic>> fetchUserInfo() async {
    final url = Uri.parse('$_baseUrl/user');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else if (response.statusCode == 404) {
      throw Exception('User not found');
    } else {
      throw Exception('Failed to fetch user info: ${response.body}');
    }
  }

  // Update user information
  Future<void> updateUser(String? password, String? name) async {
    final url = Uri.parse('$_baseUrl/user/update');
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token',
      },
      body: jsonEncode({'password': password, 'name': name}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update user: ${response.body}');
    }
  }

  // Toggle light
  Future<Map<String, dynamic>> toggleLight() async {
    final url = Uri.parse('$_baseUrl/devices/light/toggle');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to toggle light: ${response.body}');
    }
  }

  // Toggle TV
  Future<Map<String, dynamic>> toggleTV() async {
    final url = Uri.parse('$_baseUrl/devices/tv/toggle');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to toggle TV: ${response.body}');
    }
  }

  // Fetch full device state
  Future<Map<String, dynamic>> fetchDeviceState() async {
    final url = Uri.parse('$_baseUrl/devices/state');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['devices'];
    } else {
      throw Exception('Failed to fetch device state: ${response.body}');
    }
  }

  // Fetch usage metrics
  Future<Map<String, dynamic>> fetchMetrics() async {
    final url = Uri.parse('$_baseUrl/devices/metrics');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch metrics: ${response.body}');
    }
  }
}
