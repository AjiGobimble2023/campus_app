part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final ProfileModel data;
  const ProfileSuccess({required this.data});

  @override
  List<Object> get props => [data];

  ProfileSuccess copyWith({
    ProfileModel? data,
  }) {
    return ProfileSuccess(
      data: data ?? this.data,
    );
  }
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
