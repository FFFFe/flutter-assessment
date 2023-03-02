import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rf_infinite_test/constants/color.dart';
import 'package:rf_infinite_test/cubits/cubits.dart';
import 'package:rf_infinite_test/gen/assets.gen.dart';
import 'package:rf_infinite_test/models/contact.dart';

class EditProfileWidget extends StatefulWidget {
  const EditProfileWidget({super.key});

  @override
  State<EditProfileWidget> createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<EditProfileWidget> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController email = TextEditingController();

  @override
  void initState() {
    super.initState();
    final contact =
        context.read<CurrentSelectedContactCubit>().state.selectedContact;

    firstName.text = contact.firstName;
    lastName.text = contact.lastName;
    email.text = contact.email;
  }

  @override
  void dispose() {
    firstName.dispose();
    lastName.dispose();
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final contact =
        context.watch<CurrentSelectedContactCubit>().state.selectedContact;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 45.0,
        ),
        Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(4.0),
              decoration:
                  const BoxDecoration(shape: BoxShape.circle, color: green),
              child: contact.avatar.isEmpty &&
                      context.watch<MediaSelectorCubit>().state.media.isEmpty
                  ? CircleAvatar(
                      backgroundColor: green,
                      backgroundImage:
                          Assets.images.profilePlaceholder.provider(),
                      radius: 40.0,
                    )
                  : contact.avatar.contains('http') &&
                          context
                              .watch<MediaSelectorCubit>()
                              .state
                              .media
                              .isEmpty
                      ? CachedNetworkImage(
                          imageUrl: contact.avatar,
                          placeholder: (context, url) => CircleAvatar(
                            backgroundColor: green,
                            backgroundImage:
                                Assets.images.profilePlaceholder.provider(),
                          ),
                          imageBuilder: (context, imageProvider) {
                            return CircleAvatar(
                              backgroundColor: green,
                              backgroundImage:
                                  Assets.images.profilePlaceholder.provider(),
                              foregroundImage: imageProvider,
                              radius: 40.0,
                            );
                          },
                        )
                      : CircleAvatar(
                          backgroundColor: green,
                          backgroundImage:
                              Assets.images.profilePlaceholder.provider(),
                          foregroundImage: context
                                  .watch<MediaSelectorCubit>()
                                  .state
                                  .media
                                  .isEmpty
                              ? FileImage(File(contact.avatar))
                              : FileImage(File(context
                                  .watch<MediaSelectorCubit>()
                                  .state
                                  .media)),
                          radius: 40.0,
                        ),
            ),
            Positioned(
                bottom: 0,
                right: 5,
                child: context
                            .watch<ContactProfileSettingCubit>()
                            .state
                            .profileSetting ==
                        ProfileSetting.edit
                    ? GestureDetector(
                        onTap: () {
                          context.read<MediaSelectorCubit>().selectMedia(
                              MediaType.image, ImageSource.gallery);
                        },
                        child: Container(
                            padding: const EdgeInsets.all(5.0),
                            decoration: const BoxDecoration(
                              color: green,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 10.0,
                            )),
                      )
                    : contact.favourite
                        ? Assets.images.favIcon.image(height: 25.0, width: 25.0)
                        : const SizedBox.shrink()),
          ],
        ),
        const SizedBox(height: 10.0),
        Text(
          '${contact.firstName} ${contact.lastName}',
          style: const TextStyle(fontSize: 16.0),
        ),
        const SizedBox(height: 15.0),
        Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    'First Name',
                    style: TextStyle(height: 2, color: green, fontSize: 12.0),
                  ),
                ),
                TextFormField(
                  controller: firstName,
                  maxLength: 15,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: const BorderSide(
                        color: green,
                        style: BorderStyle.solid,
                      ),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20.0),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  validator: (String? input) {
                    if (input != null && input.trim().length < 2) {
                      return 'Name must be at least 2 characters long!';
                    }
                    return null;
                  },
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Last Name',
                    style: TextStyle(height: 2, color: green, fontSize: 12.0),
                  ),
                ),
                TextFormField(
                  controller: lastName,
                  maxLength: 15,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: const BorderSide(
                        color: green,
                        style: BorderStyle.solid,
                      ),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20.0),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  validator: (String? input) {
                    if (input != null && input.trim().length < 2) {
                      return 'Name must be at least 2 characters long!';
                    }
                    return null;
                  },
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Email',
                    style: TextStyle(height: 2, color: green, fontSize: 12.0),
                  ),
                ),
                TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: const BorderSide(
                        color: green,
                        style: BorderStyle.solid,
                      ),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20.0),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  validator: (String? input) {
                    if (input != null &&
                        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(input)) {
                      return 'Invalid email format!';
                    }
                    return null;
                  },
                ),
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState != null) {
                      _formKey.currentState!.validate();
                    }

                    if (_formKey.currentState != null &&
                        _formKey.currentState!.validate()) {
                      // form.save();

                      context
                          .read<CurrentSelectedContactCubit>()
                          .setCurrentSelectedContact(ContactList(
                            id: contact.id,
                            email: email.text,
                            firstName: firstName.text.trim(),
                            lastName: lastName.text.trim(),
                            avatar: context
                                    .read<MediaSelectorCubit>()
                                    .state
                                    .media
                                    .isNotEmpty
                                ? context.read<MediaSelectorCubit>().state.media
                                : contact.avatar,
                          ));
                      context
                          .read<ContactProfileSettingCubit>()
                          .changeProfileSetting(ProfileSetting.view);
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(vertical: 20.0),
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: green,
                    ),
                    child: const Text(
                      'Done',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
