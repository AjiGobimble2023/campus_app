import 'dart:io';

import 'package:campus_app/core.dart';
import 'package:campus_app/feature/profile/bloc/profile_bloc.dart';
import 'package:campus_app/feature/profile/model/update_profile.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File? _image;
  String? imageUrl;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _noTelpController = TextEditingController();

  final TextEditingController _addresController = TextEditingController();
  final TextEditingController _nameCampusController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(const GetProfile());
  }

  bool isChackButton = false;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isExist = ValueNotifier<bool>(false);
    Future<void> pickImage() async {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.image);

      if (result != null) {
        setState(() {
          _image = File(result.files.single.path!);
        });
        if (context.mounted) {
          "Berhasil! Foto profil berhasil diubah".succeedBar(context);
          isChackButton = true;
        }
      } else {
        if (context.mounted) {
          "Ups! Foto profil gagal diunggah. Coba lagi ya".failedBar(context);
        }
      }
    }

    return Scaffold(
        appBar: AppBar(title: const Text("Saya")),
        body: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
          if (state is ProfileSuccess) {
            final userdata = state.data;
            _nameController.text = userdata.fullName;
            _emailController.text = userdata.email;
            _usernameController.text = userdata.fullName;
            _noTelpController.text = userdata.phoneNumber;
            _addresController.text = userdata.address;
            _birthdayController.text = DateFormat('MM-dd-yyyy')
                .format(DateTime.parse(userdata.birthDate));
            _cityController.text = userdata.city;
            _nameCampusController.text = userdata.campusName;
            imageUrl = userdata.imageUrl;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.primary),
                child: Center(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 40.0,
                          backgroundColor: AppColors.blue50,
                          child: ClipOval(
                            child: _image != null
                                ? Image.file(
                                    _image!,
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  )
                                : state.data.imageUrl != ''
                                    ? Image.network(
                                        state.data.imageUrl!,
                                        width: 200.0,
                                        height: 200.0,
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
                        10.0.height,
                        TextButton(
                          onPressed: pickImage,
                          child: const Text(
                            'Ubah Foto Profile',
                            style: TextStyle(
                                color: AppColors.blue500,
                                fontWeight: AppFontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                        30.0.height,
                        EcoFormInput(
                            label: 'Nama',
                            controller: _nameController,
                            hint: 'Masukan Nama Anda',
                            icon: const ImageIcon(
                              AppIcons.name,
                              color: AppColors.grey500,
                            ),
                            onChanged: (value) {}),
                        20.0.height,
                        EcoFormInput(
                          label: 'Tanggal Lahir',
                          hint: 'Pilih Tanggal Lahir',
                          controller: _birthdayController,
                          validator: (value) {
                            _birthdayController.text =
                                DateFormat('MM-dd-yyyy').format(selectedDate);
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
                            if (picked != null && picked != selectedDate) {
                              setState(() {
                                selectedDate = picked;
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
                          onChanged: (value) {},
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
                          onChanged: (value) {},
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
                          onChanged: (value) {},
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
                          onChanged: (value) {},
                        ),
                        20.0.height,
                        ValueListenableBuilder(
                          valueListenable: isExist,
                          builder: (context, value, child) => EcoFormButton(
                            label: 'Simpan',
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                UpdateProfileModel profileModel = UpdateProfileModel(
                                    fullName: _nameController.text,
                                    birthDate: _birthdayController.text,
                                    address: _addresController.text,
                                    phoneNumber: _noTelpController.text,
                                    campusName: _noTelpController.text,
                                    city: _cityController.text,
                                    image: _image) ;
                                context.read<ProfileBloc>().add(UpdateProfile(
                                    updatedProfile: profileModel));
                                if (context.mounted) {
                                  "Yey! Profil kamu berhasil diubah"
                                      .succeedBar(context);
                                }
                              }
                            },
                            backgroundColor: AppColors.blue500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return 10.0.height;
        }));
  }
}
