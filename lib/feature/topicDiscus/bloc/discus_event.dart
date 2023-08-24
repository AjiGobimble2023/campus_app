part of  'discus_bloc.dart';

abstract class DiscusEvent extends Equatable {
  const DiscusEvent();
@override
  List<Object> get props => [];
}

class GetDiscus extends DiscusEvent {
  final int page;
  final String search;
  const GetDiscus({required this.page, required this.search});
}

class GetMoreDiscus extends DiscusEvent {
  final int page;
  final String search;
  const GetMoreDiscus({required this.page, required this.search});
}


