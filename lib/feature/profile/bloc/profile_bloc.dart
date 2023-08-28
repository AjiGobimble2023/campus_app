import 'package:campus_app/feature/profile/model/api/profile_service.dart';
import 'package:campus_app/feature/profile/model/profile.dart';
import 'package:campus_app/feature/profile/model/update_profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileService service;
  ProfileBloc(this.service) : super(ProfileInitial()) {
    on<GetProfile>((event, emit) async {
      try {
        emit(ProfileLoading());
        final ProfileModel result = await service.getProfile();
        emit(
          ProfileSuccess(data: result),
        );
      } catch (e) {
        emit(ProfileError(message: e.toString()));
      }
    });
    
    on<UpdateProfile>((event, emit) async {
      try {
        emit(ProfileLoading());
        final ProfileModel? result = await service.updateUser(event.updatedProfile);
        if (result != null) {
          emit(ProfileSuccess(data: result));
        }else{
           emit(const ProfileError(message: "Update Gagal"));
        }
      } catch (e) {
        emit(ProfileError(message: e.toString()));
      }
    });
  }
}
