import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_app/auth.dart';
import 'package:my_app/firebase_options.dart';
import 'package:my_app/main.dart';

class MockUser extends Mock implements User {}

final MockUser _user = MockUser();

class MockAuth extends Mock implements FirebaseAuth {
  @override
  Stream<User?> authStateChanges() {
    return Stream.fromIterable([
      _user,
    ]);
  }
}

void main() {
  final MockAuth Mock = MockAuth();
  final Auth auth = Auth(auth: Mock);
  setUp() {}

  test("connexion d'un user", () async {
    expectLater(auth.authStateChanges, emitsInOrder([_user]));
  });

}
