import 'package:campus_app/core.dart';
import 'package:campus_app/feature/auth/bloc/login/login_bloc.dart';
import 'package:campus_app/feature/auth/view/register_page.dart';
import 'package:campus_app/feature/home/Bloc/home_bloc.dart';
import 'package:campus_app/feature/home/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    context.read<HomeBloc>().add(const HomeEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.token != '') {
            Future.delayed(Duration.zero, () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MyHomePage()),
              );
            });
          }
          return BlocProvider(
            create: (context) => LoginBloc(
                emailController: _emailController,
                passwordController: _passwordController),
            child: BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) async {
                if (state is LoginError) {
                  "Email atau password tidak valid. Mohon coba lagi."
                      .failedBar(context);
                  _emailController.clear();
                  _passwordController.clear();
                  context.read<LoginBloc>().add(const LoginInputChange());
                } else if (state is LoginSuccess) {
                  await context.pushAndRemoveUntil(
                      const MyHomePage(), (route) => false);
                  if (context.mounted) {
                    dispose();
                  }
                }
              },
              builder: (context, state) {
                if (state is LoginLoading) {
                  return const EcoLoading();
                }

                final loginButton = EcoFormButton(
                  label: 'Login',
                  onPressed: state.isLoginButtonDisabled
                      ? () {}
                      : () async {
                          if (_formKey.currentState!.validate()) {
                            context
                                .read<LoginBloc>()
                                .add(const LoginButtonPressed());
                          }
                        },
                  backgroundColor: state.isLoginButtonDisabled
                      ? AppColors.blue300
                      : AppColors.blue500,
                );

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(10),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppImages.logo,
                          width: 200,
                          height: 200,
                        ),
                        50.0.height,
                        EcoFormInput(
                          label: 'Email',
                          hint: 'Masukkan alamat email',
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email tidak boleh kosong';
                            } else if (!RegExp(
                                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value)) {
                              return 'Alamat email tidak valid';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            context
                                .read<LoginBloc>()
                                .add(const LoginInputChange());
                          },
                          icon: const ImageIcon(
                            AppIcons.email,
                            color: AppColors.grey500,
                          ),
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
                                .read<LoginBloc>()
                                .add(const LoginInputChange());
                          },
                        ),
                        20.0.height,
                        loginButton,
                        20.0.height,
                        EcoFormButton(
                          label: 'Belum punya akun? Daftar',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterPage()),
                            );
                          },
                          backgroundColor: Colors.transparent,
                          textColor: AppColors.grey700,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
