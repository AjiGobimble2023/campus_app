part of 'event_bloc.dart';

abstract class EventEvent extends Equatable {
  const EventEvent();

  @override
  List<Object> get props => [];
}

class GetEvent extends EventEvent {
  final int page;
  final String search;
  const GetEvent({required this.page, required this.search});
}

class GetMoreEvent extends EventEvent {
  final int page;
  final String search;
  const GetMoreEvent({required this.page, required this.search});
}


