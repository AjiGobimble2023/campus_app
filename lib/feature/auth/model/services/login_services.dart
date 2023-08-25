import 'package:campus_app/core.dart';
import 'package:campus_app/feature/auth/model/models/login_model.dart';
import 'package:dio/dio.dart';

class LoginService {
  final Dio dio = Dio();
  final baseUrl = BaseURL.api;
  Future<Map<String, dynamic>> login(LoginModel model) async {
    try {
      final response =
          await dio.post("${BaseURL.api}/login", data: model.toJson());
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return {
          'success': false,
          'message': 'Login failed',
          'data': null,
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: $e',
        'data': null,
      };
    }
  }
}
