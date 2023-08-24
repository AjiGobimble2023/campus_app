part of 'news_bloc.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

class InformationInitial extends NewsState {}

class InformationLoading extends NewsState {}

class NewsSuccess extends NewsState {
  final List<InformationModel> data;
  final bool hasMorePages;
  final int currentPage;
  final int pages;

  const NewsSuccess(
      {required this.data,
      this.hasMorePages = false,
      this.currentPage = 1,
      this.pages = 1});

  @override
  List<Object> get props => [data, hasMorePages, currentPage];

  NewsSuccess copyWith({
    List<InformationModel>? data,
    bool? hasMorePages,
    int? currentPage,
    int? pages,
  }) {
    return NewsSuccess(
        data: data ?? this.data,
        hasMorePages: hasMorePages ?? this.hasMorePages,
        currentPage: currentPage ?? this.currentPage,
        pages: pages ?? this.pages);
  }
}

class InformationError extends NewsState {
  final String message;

  const InformationError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
