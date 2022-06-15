import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ud_truck_booking/const/utils.dart';

class BookingSuccessWidget extends StatelessWidget {
  final String bookingId;

  const BookingSuccessWidget({Key? key, required this.bookingId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Center(
        child: Column(
          children: [
            Text(
              'BOOKING TERDAFTAR',
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Image.asset('assets/images/booking_success.png'),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Text(
                'Kode Booking',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            InkWell(
              onTap: () {
                Clipboard.setData(ClipboardData(text: bookingId));
                showSnackbar(context, 'Kode telah dicopy!', Colors.green);
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[400]!, width: 1.5),
                ),
                child: Text(bookingId),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text(
                'Tunjukan Kode Booking ke SA dan\n di Mohon Datang 30 menit Sebelum Jadwal Booking',
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
