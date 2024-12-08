// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final Map<String, dynamic>? organisation;
  final String username;
  final List<Map<String, dynamic>>? roles;
  final String createdAt;
  final String updatedAt;
  const User({
    required this.id,
    required this.name,
    required this.organisation,
    required this.username,
    required this.roles,
    required this.createdAt,
    required this.updatedAt,
  });

  User copyWith({
    String? id,
    String? name,
    Map<String, dynamic>? organisation,
    String? username,
    List<Map<String, dynamic>>? roles,
    String? createdAt,
    String? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      organisation: organisation ?? this.organisation,
      username: username ?? this.username,
      roles: roles ?? this.roles,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'organisation': organisation,
      'username': username,
      'roles': roles?.map((e) => e),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      name: map['name'] as String,
      organisation: map['organisation'] as Map<String, dynamic>?,
      username: map['username'] as String,
      roles:
          List<Map<String, dynamic>>.from(map['roless'] as List<dynamic>? ?? []),
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      name,
      organisation,
      username,
      roles,
      createdAt,
      updatedAt,
    ];
  }
}
