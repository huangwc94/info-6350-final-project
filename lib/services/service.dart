import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  final apiService = ApiService('http://localhost:3000');

  try {
    // Sign up a user
    await apiService.signup('testuser', 'testpassword', 'Test User');

    // Login
    await apiService.login('testuser', 'testpassword');

    // Fetch device state
    final deviceState = await apiService.fetchDeviceState();
    print('Light Status: ${deviceState.lightStatus}');
    print('TV Status: ${deviceState.tvStatus}');

    // Fetch device metrics
    final deviceMetrics = await apiService.fetchDeviceMetrics();
    print('Light Metrics: ${deviceMetrics.lightMetrics}');
    print('TV Metrics: ${deviceMetrics.tvMetrics}');
  } catch (e) {
    print('Error: $e');
  }
}

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  // Token for authentication
  String? _token;

  // Set token after login or signup
  void setToken(String token) {
    _token = token;
  }

  // Signup API
  Future<void> signup(String username, String password, String name) async {
    final url = Uri.parse('$baseUrl/signup');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
          {'username': username, 'password': password, 'name': name}),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to sign up: ${response.body}');
    }
  }

  // Login API
  Future<void> login(String username, String password) async {
    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setToken(data['token']);
    } else {
      throw Exception('Failed to login: ${response.body}');
    }
  }

  // Fetch device state
  Future<DeviceState> fetchDeviceState() async {
    final url = Uri.parse('$baseUrl/devices/state');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return DeviceState.fromJson(data['devices']);
    } else {
      throw Exception('Failed to fetch device state: ${response.body}');
    }
  }

  // Fetch metrics
  Future<DeviceMetrics> fetchDeviceMetrics() async {
    final url = Uri.parse('$baseUrl/devices/metrics');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return DeviceMetrics.fromJson(data);
    } else {
      throw Exception('Failed to fetch metrics: ${response.body}');
    }
  }
}

// Classes for device state and metrics
class DeviceState {
  final String lightStatus;
  final String tvStatus;

  DeviceState({required this.lightStatus, required this.tvStatus});

  factory DeviceState.fromJson(Map<String, dynamic> json) {
    return DeviceState(
      lightStatus: json['light']['status'],
      tvStatus: json['tv']['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'light': {'status': lightStatus},
      'tv': {'status': tvStatus},
    };
  }
}

class DeviceMetrics {
  final List<int> lightMetrics;
  final List<int> tvMetrics;

  DeviceMetrics({required this.lightMetrics, required this.tvMetrics});

  factory DeviceMetrics.fromJson(Map<String, dynamic> json) {
    return DeviceMetrics(
      lightMetrics: List<int>.from(json['light']['metrics']),
      tvMetrics: List<int>.from(json['tv']['metrics']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'light': {'metrics': lightMetrics},
      'tv': {'metrics': tvMetrics},
    };
  }
}
