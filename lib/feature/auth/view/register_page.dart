import 'package:campus_app/core.dart';
import 'package:campus_app/feature/auth/bloc/register/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _noTelpController = TextEditingController();
  final TextEditingController _addresController = TextEditingController();
  final TextEditingController _nameCampusController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _noTelpController.dispose();
    _addresController.dispose();
    _nameCampusController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Sekarang'),
      ),
      body: BlocProvider(
        create: (context) => RegisterBloc(
            emailController: _emailController,
            passwordController: _passwordController,
            noTelpController: _noTelpController,
            nameController: _nameController,
            birthDayController: _birthdayController,
            addresController: _addresController,
            cityController: _cityController,
            nameCampusController: _nameCampusController),
        child: BlocConsumer<RegisterBloc, RegisterState>(
            listener: (context, state) async {
          if (state is RegisterError) {
            "Email Sudah Digunakan.".failedBar(context);
          }
          if (state is RegisterSuccess) {
            await context.push(const LoginPage());
            if (context.mounted) {
              dispose();
            }
          }
        }, builder: (context, state) {
          if (state is RegisterLoading) {
            return const EcoLoading();
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  30.0.height,
                  EcoFormInput(
                      label: 'Nama',
                      controller: _nameController,
                      hint: 'Masukan Nama Anda',
                      icon: const ImageIcon(
                        AppIcons.name,
                        color: AppColors.grey500,
                      ),
                      onChanged: (value) {
                        context
                            .read<RegisterBloc>()
                            .add(const RegisterInputChange());
                      }),
                  20.0.height,
                  EcoFormInput(
                    label: 'Email',
                    hint: 'Masukkan alamat email',
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email tidak boleh kosong';
                      } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                        return 'Alamat email tidak valid';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      context
                          .read<RegisterBloc>()
                          .add(const RegisterInputChange());
                    },
                    icon: const ImageIcon(
                      AppIcons.email,
                      color: AppColors.grey500,
                    ),
                  ),

                  20.0.height,
                  EcoFormInput(
                    label: 'Tanggal Lahir',
                    hint: 'Pilih Tanggal Lahir',
                    controller: _birthdayController,
                    validator: (value) {
                      if (_selectedDate == null) {
                        return 'Tanggal Lahir harus dipilih';
                      }
                      return null;
                    },
                    icon: const Icon(
                      Icons.calendar_today,
                      size: 40,
                    ),
                    readOnly: true,
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null && picked != _selectedDate) {
                        setState(() {
                          _selectedDate = picked;
                          _birthdayController.text =
                              DateFormat('MM-dd-yyyy').format(picked);
                        });
                      }
                    },
                  ),
                  20.0.height,

                  EcoFormInput(
                    label: 'Alamat',
                    controller: _addresController,
                    hint: 'Masukan Alamat Anda',
                    icon: const ImageIcon(
                      AppIcons.alamat,
                      color: AppColors.grey500,
                    ),
                    onChanged: (value) {
                      context
                          .read<RegisterBloc>()
                          .add(const RegisterInputChange());
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Alamat tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  20.0.height,
                  EcoFormInput(
                    label: 'Nama Kampus',
                    controller: _nameCampusController,
                    hint: 'Masukan Nama Kampus Anda',
                    icon: const ImageIcon(
                      AppIcons.ubahProfil,
                      color: AppColors.grey500,
                    ),
                    onChanged: (value) {
                      context
                          .read<RegisterBloc>()
                          .add(const RegisterInputChange());
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Alamat tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  20.0.height,
                  EcoFormInput(
                    label: 'Kota',
                    controller: _cityController,
                    hint: 'Masukan Nama Kota Anda',
                    icon: const ImageIcon(
                      AppIcons.coin,
                      color: AppColors.grey500,
                    ),
                    onChanged: (value) {
                      context
                          .read<RegisterBloc>()
                          .add(const RegisterInputChange());
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Alamat tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  20.0.height,
                  EcoFormInput(
                    label: 'No. Telepon',
                    controller: _noTelpController,
                    keyboardType: TextInputType.number,
                    hint: 'Masukan Nomor telefon Anda',
                    icon: const ImageIcon(
                      AppIcons.numberPhone,
                      color: AppColors.grey500,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'No telepon tidak boleh kosong';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      context
                          .read<RegisterBloc>()
                          .add(const RegisterInputChange());
                    },
                  ),
                  20.0.height,
                  EcoFormInputPassword(
                    label: 'Password',
                    hint: 'Masukkan password',
                    controller: _passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password tidak boleh kosong';
                      } else if (value.length < 8) {
                        return 'Password harus memiliki setidaknya 8 karakter';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      context
                          .read<RegisterBloc>()
                          .add(const RegisterInputChange());
                    },
                  ),

                  20.0.height,
                  EcoFormInputPassword(
                    label: 'Konfirmasi Password',
                    hint: 'Masukkan konfirmasi password',
                    controller: _confirmPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password tidak boleh kosong';
                      } else if (value.length < 8) {
                        return 'Password harus memiliki setidaknya 8 karakter';
                      } else if (value != _passwordController.text) {
                        return 'Password tidak sesuai';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      context
                          .read<RegisterBloc>()
                          .add(const RegisterInputChange());
                    },
                  ),
                  20.0.height,
                  // Other form inputs like email and password
                  EcoFormButton(
                    label: 'Register',
                    onPressed: state.isRegisterButtonDisabled
                        ? () {}
                        : () async {
                            if (_formKey.currentState!.validate()) {
                              context
                                  .read<RegisterBloc>()
                                  .add(const RegisterButtonPressed());
                              "pendaftaran Berhasil, Silahkan Login"
                                  .succeedBar(context);
                            }
                          },
                    backgroundColor: state.isRegisterButtonDisabled
                        ? AppColors.blue300
                        : AppColors.blue500,
                  ),
                  36.0.height,
                  const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Dengan daftar. Anda setuju dengan ",
                          style: TextStyle(color: AppColors.grey500),
                        ),
                        TextSpan(
                          text: "Persyaratan dan Ketentuan & Kebijakan Privasi",
                          style: TextStyle(color: AppColors.blue500),
                        ),
                        TextSpan(
                          text: " kami",
                          style: TextStyle(color: AppColors.grey500),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
