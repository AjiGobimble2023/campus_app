import 'package:campus_app/feature/events/model/api/eventService.dart';
import 'package:campus_app/feature/events/model/eventModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final EventService service;
  EventBloc(this.service) : super(EventInitial()) {
    on<GetEvent>((event, emit) async {
      try {
        emit(EventLoading());
        final List<EventModel> result =
            await service.getEvent(event.search, event.page);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        int totalPages = prefs.getInt('eventpages')!;
        emit(
          EventSuccess(
              data: result,
              currentPage: event.page,
              hasMorePages: event.page < totalPages),
        );
      } catch (e) {
        emit(EventError(message: e.toString()));
      }
    });
    on<GetMoreEvent>((event, emit) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int totalPages = prefs.getInt('eventpages')!;
      try {
        final List<EventModel> result =
            await service.getEvent(event.search, event.page);

        final EventSuccess currentState = state as EventSuccess;
        emit(EventSuccess(
            data: [...currentState.data, ...result],
            currentPage: event.page,
            hasMorePages: event.page < totalPages));
      } catch (e) {
        emit(EventError(message: e.toString()));
      }
    });
  }
}
