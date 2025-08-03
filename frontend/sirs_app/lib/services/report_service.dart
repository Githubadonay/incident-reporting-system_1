import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/report.dart';

class ReportService {
  static final _host = Platform.isAndroid ? '10.0.2.2' : 'localhost';
  final String _baseUrl = 'http://$_host:3000';

  Future<bool> submitReport(Report report, {bool anonymous = false}) async {
    final url = Uri.parse('$_baseUrl/report');
    try {
      final response = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              ...report.toJson(),
              'anonymous': anonymous,
            }),
          )
          .timeout(const Duration(seconds: 10));
      return response.statusCode == 200;
    } catch (e) {
      debugPrint('Error submitting report: $e');
      return false;
    }
  }
}

