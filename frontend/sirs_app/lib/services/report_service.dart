import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/report.dart';

class ReportService {
  //error system doesnt know what my host is, created an if method to see which im using android or IOS
  static final _host = Platform.isAndroid ? '10.0.2.2' : 'localhost';
  final String _baseUrl = 'http://$_host:3000';
  // function for after submitting the report, timeout after 10sec, and dropping it of to nodejs as json file to store
  Future<bool> submitReport(Report report, {bool anonymous = false}) async {
    final url = Uri.parse('$_baseUrl/report');
    try {
      final response = await http.post(
            url, headers: {'Content-Type': 'application/json'},
            body: jsonEncode({...report.toJson(), 'anonymous': anonymous}),
          )
          .timeout(const Duration(seconds: 10));
      return response.statusCode == 200;
    } catch (e) {
      debugPrint('Error submitting report: $e');
      return false;
    }
  }
//function for fetching the report and allows the report history to use fetchreport
  Future<List<Report>> fetchReports() async {
    final url = Uri.parse('$_baseUrl/reports');
    try {
      final response = await http.get(url).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body) as List;
        return data
            .map((e) => Report.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      debugPrint('Error fetching reports: $e');
    }
    return [];
  }
}
