import 'package:campus_app/core/utils/injector.dart' as di;
import 'package:campus_app/feature/events/bloc/event_bloc.dart';
import 'package:campus_app/feature/home/Bloc/home_bloc.dart';
import 'package:campus_app/feature/news/bloc/news_bloc.dart';
import 'package:campus_app/feature/profile/bloc/profile_bloc.dart';
import 'package:campus_app/feature/topicDiscus/bloc/discus_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Providers {
  static final List<BlocProvider> init = [
    BlocProvider<HomeBloc>(create: (context) => di.locator<HomeBloc>()),
    BlocProvider<NewsBloc>(create: (context) => di.locator<NewsBloc>()),
    BlocProvider<EventBloc>(create: (context) => di.locator<EventBloc>()),
    BlocProvider<DiscusBloc>(create: (context) => di.locator<DiscusBloc>()),
    BlocProvider<ProfileBloc>(create: (context) => di.locator<ProfileBloc>()),
  ];
}
