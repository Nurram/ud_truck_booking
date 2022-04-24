import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ud_truck_booking/const/constants.dart';

import '../../../../const/utils.dart';

abstract class BookingContract {
  void onError(String error);

  void onOrderSaved();
}

abstract class BookingThirdFormContract {
  void onError(String error);

  void onGetHours(List<Map<String, dynamic>> hours);
}

class BookingPresenter {
  BookingContract? contract;
  BookingThirdFormContract? thirdFormContract;

  BookingPresenter({this.contract, this.thirdFormContract});

  final firestore = FirebaseFirestore.instance;
  final List<String> hours = [];
  final List<int> quotas = [];

  void getHours(BuildContext context, String orderDate) async {
    showLoaderDialog(context);

    hours.clear();
    quotas.clear();

    final hourRef = firestore.collection(HOURS);
    await hourRef.get().then((value) {
      for (var element in value.docs) {
        hours.add(element.data()['hour']);
        quotas.add(element.data()['quota']);
      }
      _getOrderData(orderDate);
    }).catchError((error) {
      thirdFormContract!.onError(error.toString());
    });
  }

  _getOrderData(String orderDate) {
    final List<Map<String, dynamic>> result = [];
    final userRef = firestore.collection(ORDERS);

    userRef.where('orderDate', isEqualTo: orderDate).get().then((value) {
      if (value.size > 0) {
        for (var element in value.docs) {
          final data = element.data();
          final hour = data['orderHour'];
          if (hours.contains(hour)) {
            final index = hours.indexOf(hour);
            quotas[index] = quotas[index] - 1;
          }
        }
      }

      for (var i = 0; i < hours.length; i++) {
        result.add({'hour': hours[i], 'quota': quotas[i]});
      }

      thirdFormContract!.onGetHours(result);
    }).catchError((error) {
      thirdFormContract!.onError(error.toString());
    });
  }

  saveOrder(BuildContext context, Map<String, dynamic> request) async {
    showLoaderDialog(context);

    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('id') ?? '';

    request['bookingOwner'] = id;

    final orderRef = firestore.collection(ORDERS);
    await orderRef.add(request).then((value) {
      contract!.onOrderSaved();
    }).catchError((error) {
      contract!.onError(error);
    });
  }
}
