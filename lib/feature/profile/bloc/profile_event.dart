part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class GetProfile extends ProfileEvent {
  const GetProfile();
}

// ignore: must_be_immutable

class UpdateProfile extends ProfileEvent {
  final UpdateProfileModel updatedProfile;

  const UpdateProfile({required this.updatedProfile});
}
