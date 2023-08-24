import 'package:campus_app/feature/topicDiscus/model/topic_discus.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DiscusService {
  late Dio _dio;
  late String token;

  Future<void> init() async {
    _dio = Dio();
  }

  DiscusService() {
    init();
  }
  Future<List<DiscussionTopicModel>> getDiscus(String search, int page) async {
    try {
      String url =
          'http://192.168.20.249:3000/api/discussionTopic?search=$search&page=$page';
      final response = await _dio.get(url);
      if (response.statusCode == 200) {
        final List data = response.data['data'];
        int page = response.data['totalPages'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setInt('discuspages', page);
        List<DiscussionTopicModel> discusModels =
            data.map((json) => DiscussionTopicModel.fromJson(json)).toList();
        return discusModels;
      } else {
        throw 'get Discuss failed';
      }
    } catch (e) {
      rethrow;
    }
  }
}
