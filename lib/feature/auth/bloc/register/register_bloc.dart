import 'package:campus_app/feature/auth/model/models/register_model.dart';
import 'package:campus_app/feature/auth/model/services/register_services.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController noTelpController;
  final TextEditingController addresController;
  final TextEditingController nameCampusController;
  final TextEditingController cityController;
  final TextEditingController birthDayController;
 

  RegisterBloc(
      {required this.emailController,
      required this.passwordController,
      required this.nameController,
      required this.noTelpController,
      required this.birthDayController,
      required this.addresController,
      required this.cityController,
      required this.nameCampusController})
      : super(RegisterState.initial()) {
    on<RegisterInputChange>((event, emit) {
      final isRegisterButtonDisabled = emailController.text.isEmpty ||
          passwordController.text.isEmpty ||
          nameController.text.isEmpty ||
          noTelpController.text.isEmpty ||
          addresController.text.isEmpty ||
          cityController.text.isEmpty ||
          nameCampusController.text.isEmpty;

      emit(RegisterState(isRegisterButtonDisabled: isRegisterButtonDisabled));
    });

    on<RegisterButtonPressed>((event, emit) async {
      try {
        emit(const RegisterLoading(
            isRegisterButtonDisabled: true, isLoading: true));

        final isRegistered = await RegisterService().register(
          RegisterModel(
            email: emailController.text,
            password: passwordController.text,
            fullName: nameController.text,
            phoneNumber: noTelpController.text,
            birthDate: birthDayController.text,
            address: addresController.text,
            campusName: nameCampusController.text,
            city: cityController.text,
          ),
        );

        emit(const RegisterLoading(
            isRegisterButtonDisabled: true, isLoading: false));

        if (isRegistered) {
          emit(const RegisterSuccess(
              isRegisterButtonDisabled: true, message: 'Berhasil'));
        } else {
          emit(const RegisterError(
            isRegisterButtonDisabled: true,
            errorMessage: 'Gagal melakukan registrasi',
            isEmailUsed: false,
            isUsernameUsed: false,
          ));
        }
      } catch (error) {
        await Future.delayed(const Duration(seconds: 2));
        emit(const RegisterError(
          isRegisterButtonDisabled: true,
          errorMessage: 'Terjadi kesalahan',
          isEmailUsed: false,
          isUsernameUsed: false,
        ));
      }
    });
  }
}
