import 'package:campus_app/feature/topicDiscus/model/api/discus_services.dart';
import 'package:campus_app/feature/topicDiscus/model/topic_discus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';


part 'discus_event.dart';
part 'discus_state.dart';

class DiscusBloc extends Bloc<DiscusEvent, DiscusState> {
  final DiscusService service;
  DiscusBloc(this.service) : super(DiscusInitial()) {
    on<GetDiscus>((event, emit) async {
      try {
        emit(DiscusLoading());
        final List<DiscussionTopicModel> result =
            await service.getDiscus(event.search, event.page);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        int totalPages = prefs.getInt('discuspages')!;
        emit(
          DiscusSuccess(
            data: result,
            currentPage: event.page,
            hasMorePages: event.page < totalPages,
          ),
        );
      } catch (e) {
        emit(DiscusError(message: e.toString()));
      }
    });
    on<GetMoreDiscus>((event, emit) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int totalPages = prefs.getInt('discuspages')!;
      try {
        final List<DiscussionTopicModel> result =
            await service.getDiscus(event.search, event.page);

        final DiscusSuccess currentState = state as DiscusSuccess;
        emit(
          DiscusSuccess(
            data: [...currentState.data, ...result],
            currentPage: event.page,
            hasMorePages: event.page < totalPages,
          ),
        );
      } catch (e) {
        emit(DiscusError(message: e.toString()));
      }
    });
  }
}
