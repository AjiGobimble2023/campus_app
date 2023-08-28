import 'package:campus_app/core.dart';
import 'package:campus_app/feature/profile/model/profile.dart';
import 'package:campus_app/feature/profile/model/update_profile.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileService {
  late Dio _dio;
  late String token;

  Future<void> init() async {
    _dio = Dio();
  }

  ProfileService() {
    init();
  }

  Future<ProfileModel> getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;

    try {
      String url = '${BaseURL.api}/user';

      final response = await _dio.get(
        url,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        ProfileModel profileModel = ProfileModel.fromJson(data);
        return profileModel;
      } else {
        throw 'Failed to get profile';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<ProfileModel?> updateUser(UpdateProfileModel formData) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token')!;
      print(formData.toJson());
      final response = await _dio.put(
        '${BaseURL.api}/user',
        data: formData.toJson(),
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      if (response.statusCode == 200) {
        final data = response.data;
        ProfileModel profileModel = ProfileModel.fromJson(data);
        return profileModel;
      } else {
        return null;
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error updating: $error');
      }
    }
    return null;
  }
}
