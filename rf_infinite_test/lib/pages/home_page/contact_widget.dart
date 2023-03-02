import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:rf_infinite_test/blocs/contact/contact_bloc.dart';
import 'package:rf_infinite_test/constants/color.dart';
import 'package:rf_infinite_test/cubits/contact_profile_setting/contact_profile_setting_cubit.dart';
import 'package:rf_infinite_test/cubits/current_selected_contact/current_selected_contact_cubit.dart';
import 'package:rf_infinite_test/cubits/filtered_contact/filtered_contact_cubit.dart';
import 'package:rf_infinite_test/cubits/media_selector/media_selector_cubit.dart';
import 'package:rf_infinite_test/gen/assets.gen.dart';
import 'package:rf_infinite_test/pages/profile_page/profile_page.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactWidget extends StatefulWidget {
  const ContactWidget({super.key});

  @override
  State<ContactWidget> createState() => _ContactWidgetState();
}

class _ContactWidgetState extends State<ContactWidget> {
  @override
  Widget build(BuildContext context) {
    final contactList =
        context.watch<FilteredContactCubit>().state.filteredContactList;

    if (contactList.isEmpty) {
      return Center(
        child: Column(
          children: [
            const SizedBox(height: 40.0),
            Assets.images.emptyState.image(scale: 1.5),
            const SizedBox(height: 40.0),
            const Text('No list of contact here, add contact now'),
          ],
        ),
      );
    }
    return ListView.builder(
      itemBuilder: (context, index) {
        if (index < contactList.length) {
          return Slidable(
            key: ValueKey(contactList[index].id),
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              extentRatio: 0.35,
              openThreshold: 0.2,
              children: [
                Expanded(
                  child: Container(
                    color: green.withOpacity(0.09),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Builder(builder: (context) {
                            return GestureDetector(
                                onTap: () {
                                  context
                                      .read<CurrentSelectedContactCubit>()
                                      .setCurrentSelectedContact(
                                          contactList[index]);
                                  context
                                      .read<ContactProfileSettingCubit>()
                                      .changeProfileSetting(
                                          ProfileSetting.edit);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BlocProvider<MediaSelectorCubit>(
                                                create: (context) =>
                                                    MediaSelectorCubit(),
                                                child:
                                                    Builder(builder: (context) {
                                                  return const ProfilePage();
                                                }),
                                              )));
                                  Slidable.of(context)!.close();
                                },
                                child: Assets.images.editIcon
                                    .image(height: 18.0, width: 18.0));
                          }),
                          const VerticalDivider(
                            thickness: 1.3,
                            endIndent: 18.0,
                            indent: 18.0,
                          ),
                          Builder(builder: (context) {
                            return GestureDetector(
                                onTap: () async {
                                  final confirm = await showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Center(
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 40.0, vertical: 20.0),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(5.0)),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20.0,
                                                    vertical: 15.0),
                                                child: Text(
                                                    'Are you sure you want to delete this contact?',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      height: 1.8,
                                                      color: Colors.black87,
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    )),
                                              ),
                                              const Divider(
                                                height: 0,
                                                thickness: 1.2,
                                              ),
                                              IntrinsicHeight(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(
                                                            context, true);
                                                      },
                                                      child: const Text('Yes',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.red)),
                                                    ),
                                                    const VerticalDivider(
                                                      thickness: 1.2,
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(
                                                            context, false);
                                                      },
                                                      child: const Text(
                                                        'No',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );

                                  if (mounted) {
                                    Slidable.of(context)!.close();
                                    if (confirm == true) {
                                      context.read<ContactBloc>().add(
                                          DeleteContactEvent(
                                              id: contactList[index].id));
                                    }
                                  }
                                },
                                child: Assets.images.deleteIcon
                                    .image(height: 18.0, width: 18.0));
                          }),
                        ]),
                  ),
                )
              ],
            ),
            child: ListTile(
              onTap: () {
                context
                    .read<CurrentSelectedContactCubit>()
                    .setCurrentSelectedContact(contactList[index]);
                context
                    .read<ContactProfileSettingCubit>()
                    .changeProfileSetting(ProfileSetting.view);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BlocProvider<MediaSelectorCubit>(
                              create: (context) => MediaSelectorCubit(),
                              child: Builder(builder: (context) {
                                return const ProfilePage();
                              }),
                            )));
              },
              onLongPress: () {
                context
                    .read<ContactBloc>()
                    .add(MarkFavouriteContactEvent(id: contactList[index].id));
              },
              contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
              leading: contactList[index].avatar.isEmpty
                  ? CircleAvatar(
                      backgroundColor: green,
                      backgroundImage:
                          Assets.images.profilePlaceholder.provider(),
                    )
                  : contactList[index].avatar.contains('http')
                      ? CachedNetworkImage(
                          imageUrl: contactList[index].avatar,
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
                            );
                          },
                        )
                      : CircleAvatar(
                          backgroundColor: green,
                          backgroundImage:
                              Assets.images.profilePlaceholder.provider(),
                          foregroundImage:
                              FileImage(File(contactList[index].avatar)),
                        ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '${contactList[index].firstName} ${contactList[index].lastName}'
                                .length >
                            25
                        ? '${contactList[index].firstName} ${contactList[index].lastName}'
                            .substring(1, 20)
                        : '${contactList[index].firstName} ${contactList[index].lastName}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  contactList[index].favourite
                      ? Assets.images.favIcon.image(height: 15.0, width: 15.0)
                      : const SizedBox.shrink(),
                  const SizedBox(
                    width: 20.0,
                  ),
                ],
              ),
              subtitle: Text(contactList[index].email),
              trailing: InkResponse(
                onTap: () async {
                  String email = Uri.encodeComponent(contactList[index].email);
                  String subject = Uri.encodeComponent("New Subject");
                  String body = Uri.encodeComponent("Hello!");
                  print(subject);
                  Uri mail =
                      Uri.parse("mailto:$email?subject=$subject&body=$body");
                  if (await launchUrl(mail)) {
                    //email app opened
                  } else {
                    //email app is not opened
                  }
                },
                radius: 25.0,
                child: Assets.images.sendIcon.image(),
              ),
            ),
          );
        }
        return const SizedBox(height: 80.0);
      },
      itemCount: contactList.length + 1,
    );
  }
}
