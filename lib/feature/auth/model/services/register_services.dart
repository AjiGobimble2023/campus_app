import 'package:dio/dio.dart';
import 'package:campus_app/core.dart';

import '../models/register_model.dart';

class RegisterService {
  final Dio dio = Dio();

  Future<bool> register(RegisterModel user) async {
    try {
      final respone = await dio.post(
        '${BaseURL.api}/register',
        data: user.toJson(),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      if (respone.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
