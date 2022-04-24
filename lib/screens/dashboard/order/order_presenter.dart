import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ud_truck_booking/const/utils.dart';

import '../../../const/constants.dart';

abstract class OrderContract {
  void onError(String error);

  void onGetOrders(Map<String, dynamic> orders) {}
}

class OrderPresenter {
  OrderContract contract;

  OrderPresenter({required this.contract});

  getOrders(BuildContext context) async {
    showLoaderDialog(context);

    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('id') ?? '';

    final onProgressOrder = <Map<String, dynamic>>[];
    final completedOrder = <Map<String, dynamic>>[];

    final firestore = FirebaseFirestore.instance;
    final orderRef = firestore.collection(ORDERS);

    orderRef.where('bookingOwner', isEqualTo: id).get().then((value) {
      for (var element in value.docs) {
        if (element.data()['status'] == ON_PROGRESS) {
          onProgressOrder.add(element.data());
        } else {
          completedOrder.add(element.data());
        }
      }

      contract.onGetOrders(
        {ON_PROGRESS: onProgressOrder, COMPLETE: completedOrder},
      );
    }).catchError((error) {
      contract.onError(error);
    });
  }
}
