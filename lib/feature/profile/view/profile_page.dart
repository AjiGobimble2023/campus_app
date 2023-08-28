import 'dart:io';

import 'package:campus_app/core.dart';
import 'package:campus_app/feature/home/Bloc/home_bloc.dart';
import 'package:campus_app/feature/profile/bloc/profile_bloc.dart';
import 'package:campus_app/feature/profile/view/edit_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  File? _image;
  @override
  void initState() {
    context.read<ProfileBloc>().add(const GetProfile());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              context.push(const EditProfilePage());
            },
          ),
        ],
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const EcoLoading();
          } else if (state is ProfileSuccess) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    color: Colors.blue,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 40.0,
                          backgroundColor: AppColors.primary50,
                          child: GestureDetector(
                            child: ClipOval(
                              child: state.data.imageUrl != ''
                                  ? Image.network(
                                      state.data.imageUrl!,
                                      width: 200.0,
                                      height: 200.0,
                                      fit: BoxFit.cover,
                                    )
                                  : _image != null
                                      ? Image.file(
                                          _image!,
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.cover,
                                        )
                                      : const Image(
                                          image: AppIcons.profile,
                                          color: AppColors.blue500,
                                          width: 40,
                                          height: 40,
                                        ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          state.data.fullName,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.mail),
                    title: Text(state.data.email),
                  ),
                  ListTile(
                    leading: const Icon(Icons.location_on),
                    title: Text(state.data.address),
                  ),
                  ListTile(
                      leading: const Icon(Icons.cake),
                      title: Text(
                        DateFormat.yMMMMd()
                            .format(DateTime.parse(state.data.birthDate)),
                      )),
                  ListTile(
                    leading: const Icon(Icons.phone),
                    title: Text(state.data.phoneNumber),
                  ),
                  ListTile(
                    leading: const Icon(Icons.school),
                    title: Text(state.data.campusName),
                  ),
                  ListTile(
                    leading: const Icon(Icons.location_city),
                    title: Text(state.data.city),
                  ),
                  BlocListener<HomeBloc, HomeState>(
                    listener: (context, state) {},
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: EcoFormButton(
                        label: 'Log out',
                        onPressed: () async {
                          context.read<HomeBloc>().add(LogOut());
                        },
                        backgroundColor: AppColors.error500,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return 10.0.height;
        },
      ),
    );
  }
}
