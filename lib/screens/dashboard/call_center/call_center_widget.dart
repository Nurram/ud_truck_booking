import 'package:flutter/material.dart';
import 'package:ud_truck_booking/const/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class CallCenterWidget extends StatelessWidget {
  const CallCenterWidget({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.contact_support_outlined,
            size: MediaQuery.of(context).size.width * .4,
          ),
          const SizedBox(
            height: 24,
          ),
          InkWell(
            onTap: () => _launchWa(context),
            child: Container(
              color: Theme.of(context).primaryColor,
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.whatsapp_outlined,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Tanya kami',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _launchWa(BuildContext context) async {
    try {
      await launch(
          "https://wa.me/+628118899071?text=Halo,%20ada%20yang%20mau%20saya%20tanyakan%20nih");
    } catch (e) {
      showSnackbar(
          context, 'Whatsapp tidak ditemukan!', Theme.of(context).errorColor);
    }
  }
}
