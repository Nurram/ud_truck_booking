import 'package:flutter/material.dart';
import 'package:ud_truck_booking/const/constants.dart';
import 'package:ud_truck_booking/const/utils.dart';
import 'package:ud_truck_booking/screens/dashboard/order/order_detail_screen.dart';
import 'package:ud_truck_booking/screens/dashboard/order/order_presenter.dart';
import 'package:ud_truck_booking/widgets/elevated_button.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({Key? key}) : super(key: key);

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> implements OrderContract {
  late OrderPresenter _presenter;

  final _orders = <String, dynamic>{
    ON_PROGRESS: <Map<String, dynamic>>[],
    COMPLETE: <Map<String, dynamic>>[]
  };

  bool _isInService = true;

  @override
  void initState() {
    _presenter = OrderPresenter(contract: this);
    Future.delayed(Duration.zero, () {
      _presenter.getOrders(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_buildTopButton(), _buildServiceWidget()],
    );
  }

  Widget _buildTopButton() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _isInService = true;
                });
              },
              child: const Text('Service'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(_isInService
                    ? Theme.of(context).primaryColor
                    : Colors.grey),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _isInService = false;
                });
              },
              child: const Text('Completed'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(_isInService
                    ? Colors.grey
                    : Theme.of(context).primaryColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceWidget() {
    final List<Map<String, dynamic>> onProgressOrders = _orders[ON_PROGRESS];
    final List<Map<String, dynamic>> completedOrders = _orders[COMPLETE];

    return Expanded(
      child: ListView.builder(
          itemCount:
              _isInService ? onProgressOrders.length : completedOrders.length,
          itemBuilder: (context, index) {
            final Map<String, dynamic> order =
                _isInService ? onProgressOrders[index] : completedOrders[index];

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[400]!, width: 2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildColumnItem(
                            'Tipe Kendaraan', order['vehicleType']),
                        _buildColumnItem('Nomor Polisi', order['platNo']),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildColumnItem('Tanggal', order['orderDate']),
                        const SizedBox(
                          width: 16,
                        ),
                        _buildColumnItem('Jam', order['orderHour']),
                      ],
                    ),
                    InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderDetailScreen(order: order),
                        ),
                      ),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(top: 24),
                        child: const Text(
                          'Lihat lebih banyak',
                          textAlign: TextAlign.end,
                          style:
                              TextStyle(decoration: TextDecoration.underline),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }

  Widget _buildColumnItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Padding(padding: const EdgeInsets.only(top: 4), child: Text(value)),
      ],
    );
  }

  @override
  void onError(String error) {
    Navigator.pop(context);
    showSnackbar(context, error, Theme.of(context).errorColor);
  }

  @override
  void onGetOrders(Map<String, dynamic> orders) {
    Navigator.pop(context);

    setState(() {
      _orders.clear();
      _orders.addAll(orders);
    });
  }
}
