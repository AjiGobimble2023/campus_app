import 'package:campus_app/feature/events/bloc/event_bloc.dart';
import 'package:campus_app/feature/events/model/api/eventService.dart';
import 'package:campus_app/feature/home/Bloc/home_bloc.dart';
import 'package:campus_app/feature/news/bloc/news_bloc.dart';
import 'package:campus_app/feature/news/model/services/news_api.dart';
import 'package:campus_app/feature/profile/bloc/profile_bloc.dart';
import 'package:campus_app/feature/profile/model/api/profile_service.dart';
import 'package:campus_app/feature/topicDiscus/bloc/discus_bloc.dart';
import 'package:campus_app/feature/topicDiscus/model/api/discus_services.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

void init() {
  locator.registerFactory(() => HomeBloc());
  locator.registerFactory(() => NewsBloc(locator()));
  locator.registerFactory(() => EventBloc(locator()));
  locator.registerFactory(() => DiscusBloc(locator()));
  locator.registerFactory(() => ProfileBloc(locator()));
  

  locator.registerLazySingleton<InformationService>(() => InformationService());
  locator.registerLazySingleton<EventService>(() => EventService() );
  locator.registerLazySingleton<DiscusService>(() => DiscusService() );
  locator.registerLazySingleton<ProfileService>(() => ProfileService() );
}
