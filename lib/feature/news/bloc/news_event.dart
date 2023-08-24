part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}

class GetNewsEvent extends NewsEvent {
  final int page;
  final String search;
  const GetNewsEvent({required this.page, required this.search});
}

class GetMoreNewsEvent extends NewsEvent {
  final int page;
  final String search;
  const GetMoreNewsEvent({required this.page, required this.search});
}

class GetTotalPages extends NewsEvent {
  final int pages;
  const GetTotalPages({
    required this.pages,
  });
}
