part of 'event_bloc.dart';

abstract class EventState extends Equatable {
  const EventState();

  @override
  List<Object> get props => [];
}

class EventInitial extends EventState {}

class EventLoading extends EventState {}

class EventSuccess extends EventState {
  final List<EventModel> data;
  final bool hasMorePages;
  final int currentPage;
  final int pages;

  const EventSuccess(
      {required this.data,
      this.hasMorePages = false,
      this.currentPage = 1,
      this.pages = 1});

  @override
  List<Object> get props => [data, hasMorePages, currentPage];

  EventSuccess copyWith({
    List<EventModel>? data,
    bool? hasMorePages,
    int? currentPage,
    int? pages,
  }) {
    return EventSuccess(
        data: data ?? this.data,
        hasMorePages: hasMorePages ?? this.hasMorePages,
        currentPage: currentPage ?? this.currentPage,
        pages: pages ?? this.pages);
  }
}

class EventError extends EventState {
  final String message;

  const EventError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
