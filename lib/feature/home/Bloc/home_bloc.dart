import 'package:campus_app/feature/auth/model/services/logout_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.initial()) {
    on<HomeEvent>((event, emit) async {
      if (event is UpdateSharedPreferences) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String userId = prefs.getString('token') ?? '';
          emit(state.copyWith(token: userId));
        } catch (error) {
          await Future.delayed(const Duration(seconds: 2));
        }
      }
    });

    on<OnBottomNavTap>((event, emit) {
      emit(state.copyWith(index: event.index));
    });

    on<LogOut>((event, emit) async {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String userId = prefs.getString('token') ?? '';
        final logoutService = LogoutService();

        await logoutService.logout(userId);
        prefs.remove('token');
        emit(state.copyWith(token: ''));
      } catch (e) {}
      emit(state.copyWith(token: ''));
    });
  }

  void changeSharedPreferences() {
    add(const UpdateSharedPreferences());
  }
}
