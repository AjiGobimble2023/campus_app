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

  Future<ProfileModel?> updatePhoto(FormData formData) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token')!;

      final response = await _dio.patch(
        '${BaseURL.api}/user/photo',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data'
          },
        ),
      );
      if (response.statusCode == 200) {
        final data = response.data;
        ProfileModel profileModel = ProfileModel.fromJson(data);
        return profileModel;
      } else {}
    } catch (error) {
      if (kDebugMode) {
        print('Error updating photo: $error');
      }
    }
    return null;
  }

  Future<ProfileModel?> updateUser(UpdateProfileModel formData) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token')!;
      print(formData.toJson());
      final response = await _dio.patch(
        '${BaseURL.api}/user',
        data: formData.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data'
          },
        ),
      );
      print(response.data);
      if (response.statusCode == 200) {
        final data = response.data;
        ProfileModel profileModel = ProfileModel.fromJson(data);
        return profileModel;
      } else {
        return null;
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error updating photo: $error');
      }
    }
    return null;
  }
}
