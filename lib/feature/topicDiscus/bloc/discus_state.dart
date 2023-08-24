part of 'discus_bloc.dart';


abstract class DiscusState extends Equatable {
  const DiscusState();

  @override
  List<Object> get props => [];
}

class DiscusInitial extends DiscusState {}

class DiscusLoading extends DiscusState {}

class DiscusSuccess extends DiscusState {
  final List<DiscussionTopicModel> data;
  final bool hasMorePages;
  final int currentPage;
  final int pages;

  const DiscusSuccess(
      {required this.data,
      this.hasMorePages = false,
      this.currentPage = 1,
      this.pages = 1});

  @override
  List<Object> get props => [data, hasMorePages, currentPage];

  DiscusSuccess copyWith({
    List<DiscussionTopicModel>? data,
    bool? hasMorePages,
    int? currentPage,
    int? pages,
  }) {
    return DiscusSuccess(
        data: data ?? this.data,
        hasMorePages: hasMorePages ?? this.hasMorePages,
        currentPage: currentPage ?? this.currentPage,
        pages: pages ?? this.pages);
  }
}

class DiscusError extends DiscusState {
  final String message;

  const DiscusError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
