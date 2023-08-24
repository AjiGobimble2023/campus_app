import 'package:campus_app/feature/news/model/news.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/services/news_api.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final InformationService service;
  NewsBloc(this.service) : super(InformationInitial()) {
    on<GetNewsEvent>((event, emit) async {
      try {
        emit(InformationLoading());
        final List<InformationModel> result =
            await service.getInformation(event.search, event.page);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        int totalPages = prefs.getInt('pages')!;
        emit(
          NewsSuccess(
              data: result,
              currentPage: event.page,
              hasMorePages: event.page < totalPages),
        );
      } catch (e) {
        emit(InformationError(message: e.toString()));
      }
    });
    on<GetMoreNewsEvent>((event, emit) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int totalPages = prefs.getInt('pages')!;
      try {
        final List<InformationModel> result =
            await service.getInformation(event.search, event.page);

        final NewsSuccess currentState = state as NewsSuccess;
        emit(NewsSuccess(
            data: [...currentState.data, ...result],
            currentPage: event.page,
            hasMorePages: event.page < totalPages));
      } catch (e) {
        emit(InformationError(message: e.toString()));
      }
    });
    on<GetTotalPages>((event, emit) async {
      final currentState = state;
      if (currentState is NewsSuccess) {
        emit(currentState.copyWith(pages: event.pages));
      }
    });
  }
}
