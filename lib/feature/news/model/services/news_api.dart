import 'package:campus_app/feature/news/model/news.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InformationService {
  late Dio _dio;
  late String token;

  Future<void> init() async {
    _dio = Dio();
  }

  InformationService() {
    init();
  }
  Future<List<InformationModel>> getInformation(String search, int page) async {
    try {
      String url =
          'http://192.168.20.249:3000/api/news?search=$search&page=$page';
      final response = await _dio.get(url);
      if (response.statusCode == 200) {
        final List data = response.data['data'];
        int page = response.data['totalPages'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setInt(
          'pages',page
        );
        List<InformationModel> informationModels =
            data.map((json) => InformationModel.fromJson(json)).toList();
        return informationModels;
      } else {
        throw 'get informations failed';
      }
    } catch (e) {
      rethrow;
    }
  }
}
