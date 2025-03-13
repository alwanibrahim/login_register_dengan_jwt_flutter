import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image/models/task_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskApi {
  final String baseUrl = dotenv.env['API_URL'] ?? '';
  final Dio _dio = Dio();

  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<List<Task>> fetchTasks() async {
    String? token = await _getToken();
    if (token == null) {
      throw Exception('Token tidak ditemukan');
    }

    try {
      final response = await _dio.get(
        '$baseUrl/api/tasks', // 🔹 Ubah ke GET jika API mendukung
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      print('Response Status: ${response.statusCode}');
      print('Response Data: ${response.data}'); // ✅ Debugging

      if (response.statusCode == 200) {
        if (response.data is List) {
          // 🔹 Respons API berbentuk List langsung, tidak perlu containsKey()
          return response.data
              .map((task) => Task.fromJson(task))
              .toList();
        } else if (response.data is Map && response.data.containsKey('tasks')) {
          // 🔹 Jika API berbentuk Map yang berisi 'tasks'
          List jsonResponse = response.data['tasks'];
          return jsonResponse.map((task) => Task.fromJson(task)).toList();
        } else {
          throw Exception("Invalid response format");
        }
      } else {
        throw Exception('Gagal mengambil tugas: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      print('Error Details: ${e.response?.data ?? e.message}');
      throw Exception(
          'Gagal mengambil tugas: ${e.response?.data ?? e.message}');
    }
  }

}
