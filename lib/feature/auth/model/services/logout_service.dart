import 'package:dio/dio.dart';

class LogoutService {
  final Dio dio = Dio();

  Future<Map<String, dynamic>> logout(String token) async {
    try {
      final response = await dio.post("http://192.168.20.249:3000/api/logout",
      options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return {
          'success': false,
          'message': 'Logout failed',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: $e',
      };
    }
  }
}
