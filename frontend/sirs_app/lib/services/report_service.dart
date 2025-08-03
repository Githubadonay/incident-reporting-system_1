// lib/services/report_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class ReportService {
  // If you’re on Android emulator, use 10.0.2.2; on iOS simulator or web, localhost is fine:
  static const String baseUrl = 'http://localhost:3000'; 

  static Future<bool> submitReport({
    required String description,
    required String location,
    required bool isAnonymous,
    String? imagePath,
  }) async {
    final url = Uri.parse('$baseUrl/report');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'description': description,
          'location': location,
          'isAnonymous': isAnonymous,
          'image': imagePath ?? '',
          'timestamp': DateTime.now().toIso8601String(),
        }),
      );

      // DEBUG: log what we got back
      print('⚡️ POST $url → ${response.statusCode}');
      print('⚡️ Response body: ${response.body}');

      return response.statusCode == 200;
    } catch (e) {
      // Network or parsing error
      print('❌ submitReport error: $e');
      return false;
    }
  }
}

