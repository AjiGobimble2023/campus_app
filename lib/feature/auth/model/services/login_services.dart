import 'package:campus_app/feature/auth/model/models/login_model.dart';
import 'package:dio/dio.dart';

class LoginService {
  final Dio dio = Dio();

  Future<Map<String, dynamic>> login(LoginModel model) async {
    try {
      final response = await dio.post("http://192.168.20.249:3000/api/login",
          data: model.toJson());
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
