import 'package:campus_app/core.dart';
import 'package:campus_app/feature/events/model/eventModel.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventService {
  late Dio _dio;
  late String token;

  Future<void> init() async {
    _dio = Dio();
  }

  EventService() {
    init();
  }
  Future<List<EventModel>> getEvent(String search, int page) async {
    try {
      String url = '${BaseURL.api}/events?search=$search&page=$page';
      final response = await _dio.get(url);
      if (response.statusCode == 200) {
        final List data = response.data['data'];
        int page = response.data['totalPages'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setInt('eventpages', page);
        List<EventModel> eventModels =
            data.map((json) => EventModel.fromJson(json)).toList();
        return eventModels;
      } else {
        throw 'get Events failed';
      }
    } catch (e) {
      rethrow;
    }
  }
}
