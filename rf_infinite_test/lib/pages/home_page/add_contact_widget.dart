import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rf_infinite_test/blocs/contact/contact_bloc.dart';
import 'package:rf_infinite_test/constants/color.dart';
import 'package:rf_infinite_test/cubits/media_selector/media_selector_cubit.dart';
import 'package:rf_infinite_test/gen/assets.gen.dart';
import 'package:rf_infinite_test/models/contact.dart';

class AddContactWidget extends StatefulWidget {
  const AddContactWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<AddContactWidget> createState() => _AddContactWidgetState();
}

class _AddContactWidgetState extends State<AddContactWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: const Duration(milliseconds: 300),
      padding: EdgeInsets.only(
          top: 20.0, bottom: MediaQuery.of(context).viewInsets.bottom),
      curve: Curves.decelerate,
      child: SingleChildScrollView(
        // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20.0),
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(4.0),
                  decoration:
                      const BoxDecoration(shape: BoxShape.circle, color: green),
                  child: context.watch<MediaSelectorCubit>().state.media.isEmpty
                      ? CircleAvatar(
                          backgroundColor: green,
                          backgroundImage:
                              Assets.images.profilePlaceholder.provider(),
                          radius: 40.0,
                        )
                      : CircleAvatar(
                          backgroundColor: green,
                          backgroundImage:
                              Assets.images.profilePlaceholder.provider(),
                          foregroundImage: FileImage(File(
                              context.watch<MediaSelectorCubit>().state.media)),
                          radius: 40.0,
                        ),
                ),
                Positioned(
                  bottom: 0,
                  right: 5,
                  child: GestureDetector(
                    onTap: () {
                      context
                          .read<MediaSelectorCubit>()
                          .selectMedia(MediaType.image, ImageSource.gallery);
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
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Form(
              key: _formKey,
              autovalidateMode: autovalidateMode,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text(
                        'First Name',
                        style:
                            TextStyle(height: 2, color: green, fontSize: 12.0),
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
                        style:
                            TextStyle(height: 2, color: green, fontSize: 12.0),
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
                        style:
                            TextStyle(height: 2, color: green, fontSize: 12.0),
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
                        setState(() {
                          autovalidateMode = AutovalidateMode.always;
                        });
                        if (_formKey.currentState != null) {
                          _formKey.currentState!.validate();
                        }

                        if (_formKey.currentState != null &&
                            _formKey.currentState!.validate()) {
                          // form.save();
                          context.read<ContactBloc>().add(AddContactEvent(
                                  contact: ContactList(
                                email: email.text,
                                firstName: firstName.text.trim(),
                                lastName: lastName.text.trim(),
                                avatar: context
                                    .read<MediaSelectorCubit>()
                                    .state
                                    .media,
                              )));
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
                          'Add Contact',
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
        ),
      ),
    );
  }
}
