import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../const/constants.dart';
import '../../const/utils.dart';

abstract class ForgotPasswordContract {
  void onError(String error);

  void onDataNotFound();

  void onCodeSent(String verificationId, int? resendToken);

  void onTimeout();

  void onGetPassword(String password);
}

class ForgotPasswordPresenter {
  final ForgotPasswordContract contract;
  final firestore = FirebaseFirestore.instance;

  ForgotPasswordPresenter({required this.contract});

  void verifyPhoneNumber(BuildContext context, String phoneNumber,
      int? resendToken, ThemeData theme) async {
    showLoaderDialog(context);

    final userRef = firestore.collection(USERS);
    userRef.where('phone', isEqualTo: phoneNumber).get().then((value) {
      if (value.size <= 0) {
        contract.onDataNotFound();
      } else {
        _doVerification(phoneNumber, resendToken);
      }
    });
  }

  void _doVerification(String phoneNumber, int? resendToken) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+62$phoneNumber',
      timeout: const Duration(seconds: 10),
      verificationCompleted: (credential) {},
      verificationFailed: (e) {
        String msg = e.message ?? 'Something happened!';

        if (e.code == 'invalid-phone-number') {
          msg = 'Nomor tidak valid!';
        }

        contract.onError(msg);
      },
      codeSent: (verificationId, resendToken) {
        contract.onCodeSent(verificationId, resendToken);
      },
      codeAutoRetrievalTimeout: (verificationId) => contract.onTimeout(),
      forceResendingToken: resendToken,
    );
  }

  void getPassword(BuildContext context, String phoneNumber) async {
    showLoaderDialog(context);
    final userRef = firestore.collection(USERS);
    userRef.where('phone', isEqualTo: phoneNumber).get().then((value) {
      contract.onGetPassword(value.docs.first['password']);
    }).catchError((error) {
      error as StateError;
      contract.onError(error.message);
    });
  }
}
