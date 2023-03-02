import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rf_infinite_test/constants/color.dart';
import 'package:rf_infinite_test/cubits/cubits.dart';
import 'package:rf_infinite_test/gen/assets.gen.dart';
import 'package:rf_infinite_test/pages/profile_page/edit_profile_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final contact =
        context.watch<CurrentSelectedContactCubit>().state.selectedContact;

    return Scaffold(
      appBar: AppBar(
        leading: InkResponse(
          onTap: () {
            Navigator.pop(context);
          },
          radius: 20.0,
          child: const Icon(
            Icons.keyboard_arrow_left,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: context
                    .watch<ContactProfileSettingCubit>()
                    .state
                    .profileSetting ==
                ProfileSetting.edit
            ? const EditProfileWidget()
            : Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 45.0,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                context
                                    .read<ContactProfileSettingCubit>()
                                    .changeProfileSetting(ProfileSetting.edit);
                              },
                              child: const Text(
                                'Edit',
                              ),
                            ),
                          ),
                        ),
                        Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4.0),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: green),
                              child: contact.avatar.isEmpty
                                  ? CircleAvatar(
                                      backgroundColor: green,
                                      backgroundImage: Assets
                                          .images.profilePlaceholder
                                          .provider(),
                                      radius: 40.0,
                                    )
                                  : contact.avatar.contains('http')
                                      ? CachedNetworkImage(
                                          imageUrl: contact.avatar,
                                          placeholder: (context, url) =>
                                              CircleAvatar(
                                            backgroundColor: green,
                                            backgroundImage: Assets
                                                .images.profilePlaceholder
                                                .provider(),
                                          ),
                                          imageBuilder:
                                              (context, imageProvider) {
                                            return CircleAvatar(
                                              backgroundColor: green,
                                              backgroundImage: Assets
                                                  .images.profilePlaceholder
                                                  .provider(),
                                              foregroundImage: imageProvider,
                                              radius: 40.0,
                                            );
                                          },
                                        )
                                      : CircleAvatar(
                                          backgroundColor: green,
                                          backgroundImage: Assets
                                              .images.profilePlaceholder
                                              .provider(),
                                          foregroundImage:
                                              FileImage(File(contact.avatar)),
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
                                          context
                                              .read<MediaSelectorCubit>()
                                              .selectMedia(MediaType.image,
                                                  ImageSource.gallery);
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
                                        ? Assets.images.favIcon
                                            .image(height: 25.0, width: 25.0)
                                        : const SizedBox.shrink()),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          '${contact.firstName} ${contact.lastName}',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        const SizedBox(height: 15.0),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        color: Colors.grey.shade300,
                        child: Column(
                          children: [
                            Assets.images.emailIcon.image(),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              contact.email,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      GestureDetector(
                        onTap: () async {
                          String email = Uri.encodeComponent(contact.email);
                          String subject = Uri.encodeComponent("New Subject");
                          String body = Uri.encodeComponent("Hello!");
                          print(subject);
                          Uri mail = Uri.parse(
                              "mailto:$email?subject=$subject&body=$body");
                          if (await launchUrl(mail)) {
                            //email app opened
                          } else {
                            //email app is not opened
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(horizontal: 20.0),
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: green,
                          ),
                          child: const Text(
                            'Send Email',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
