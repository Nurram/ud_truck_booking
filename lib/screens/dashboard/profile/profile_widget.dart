import 'package:flutter/material.dart';
import 'package:ud_truck_booking/screens/dashboard/profile_detail/profile_detail_screen.dart';

class ProfileWidget extends StatefulWidget {
  final String? userName;

  const ProfileWidget({Key? key, required this.userName}) : super(key: key);

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/bg.webp',
          width: double.infinity,
          height: MediaQuery.of(context).size.height * .2,
          fit: BoxFit.cover,
        ),
        Column(
          children: [
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height * .1,
                width: MediaQuery.of(context).size.height * .1,
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(99),
                ),
                child: Icon(
                  Icons.person,
                  size: MediaQuery.of(context).size.height * .05,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              widget.userName ?? '',
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileDetailScreen(),
                  ),
                );
              },
              child: const Text(
                'Edit Profile',
                style: TextStyle(
                    color: Colors.white, decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
