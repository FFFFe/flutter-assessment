// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

Uuid uuid = const Uuid();

class Contact extends Equatable {
  final int page;
  final int perPage;
  final int totalContact;
  final int totalPage;
  final List<ContactList> data;
  const Contact({
    required this.page,
    required this.perPage,
    required this.totalContact,
    required this.totalPage,
    required this.data,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      page: json['page'],
      perPage: json['per_page'],
      totalContact: json['total'],
      totalPage: json['total_pages'],
      data: List<ContactList>.from(
          json['data'].map((el) => ContactList.fromJson(el))),
    );
  }

  factory Contact.initial() {
    return const Contact(
      page: 0,
      perPage: 0,
      totalContact: 0,
      totalPage: 0,
      data: [],
    );
  }

  @override
  List<Object> get props {
    return [
      page,
      perPage,
      totalContact,
      totalPage,
      data,
    ];
  }

  @override
  bool get stringify => true;

  Contact copyWith({
    int? page,
    int? perPage,
    int? totalContact,
    int? totalPage,
    List<ContactList>? data,
  }) {
    return Contact(
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
      totalContact: totalContact ?? this.totalContact,
      totalPage: totalPage ?? this.totalPage,
      data: data ?? this.data,
    );
  }
}

class ContactList extends Equatable {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;
  final bool favourite;
  ContactList({
    String? id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
    this.favourite = false,
  }) : this.id = id ?? uuid.v4();

  factory ContactList.fromJson(Map<String, dynamic> json) {
    return ContactList(
      id: json['id'].toString(),
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      avatar: json['avatar'],
      favourite: json['favourite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'avatar': avatar,
      'favourite': favourite,
    };
  }

  factory ContactList.initial() {
    return ContactList(
      id: '0',
      email: '',
      firstName: '',
      lastName: '',
      avatar: '',
      favourite: false,
    );
  }

  @override
  List<Object> get props {
    return [
      id,
      email,
      firstName,
      lastName,
      avatar,
      favourite,
    ];
  }

  @override
  bool get stringify => true;

  ContactList copyWith({
    String? id,
    String? email,
    String? firstName,
    String? lastName,
    String? avatar,
    bool? favourite,
  }) {
    return ContactList(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      avatar: avatar ?? this.avatar,
      favourite: favourite ?? this.favourite,
    );
  }
}
