import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../core/constants/app_constants.dart';
import '../../domain/models/habit_analysis_input.dart';

class ApiService {
  static Future<List<dynamic>> generateAISuggestions(
      HabitAnalysisInput input) async {
    final url = Uri.parse('${AppConstants.baseUrl}/suggestions/analyze');

    debugPrint('Sending request to url...');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode(input.toJson()),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      debugPrint("Decode response.body: ${jsonData.length} suggestions");
      return jsonData;
    } else {
      throw Exception("Failed to load suggestions: ${response.body}");
    }
  }
}
