import 'package:flutter/material.dart';
import 'package:ud_truck_booking/const/utils.dart';
import 'package:ud_truck_booking/models/user_response.dart';
import 'package:ud_truck_booking/screens/dashboard/call_center/call_center_widget.dart';
import 'package:ud_truck_booking/screens/dashboard/dashboard_presenter.dart';
import 'package:ud_truck_booking/screens/dashboard/home/home_widget.dart';
import 'package:ud_truck_booking/screens/dashboard/order/order_widget.dart';
import 'package:ud_truck_booking/screens/dashboard/profile/profile_widget.dart';
import 'package:ud_truck_booking/screens/login/login_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    implements DashboardContract {
  late DashboardPresenter _presenter;

  final _titles = ['', 'Order', '', 'Call Centre', ''];
  final List<Widget> _screens = [const HomeWidget()];

  int _botNavIndex = 0;
  String _username = 'Hi,';
  int _points = 0;

  @override
  void initState() {
    _presenter = DashboardPresenter(contract: this);
    Future.delayed(Duration.zero, () {
      _presenter.getUserDetail(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: _botNavIndex == 0 ? _buildTitle() : Text(_titles[_botNavIndex]),
        centerTitle: _botNavIndex == 0 ? false : true,
        elevation: 0,
        flexibleSpace: Image.asset(
          'assets/images/bg.webp',
          fit: BoxFit.cover,
        ),
        backgroundColor: Colors.transparent,
        actions: _botNavIndex == 4
            ? [
                IconButton(
                  onPressed: () => _logout(),
                  icon: const Icon(Icons.logout_outlined),
                ),
              ]
            : null,
      ),
      body: SafeArea(
        child: _screens[_botNavIndex],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        backgroundColor: Theme.of(context).primaryColor,
        child: Image.asset(
          'assets/images/ud_logo_transparent.webp',
          width: 40,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBotnav(),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              _username,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.yellow[200]),
            child: Row(
              children: [
                const Icon(
                  Icons.generating_tokens_outlined,
                  size: 14,
                  color: Colors.black,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  '$_points Point',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 14),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _logout() {
    _presenter.logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  Widget _buildBotnav() {
    return BottomNavigationBar(
        currentIndex: _botNavIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: (value) => setState(() {
              if (value != 2) {
                _botNavIndex = value;
              }
            }),
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home_outlined),
          ),
          BottomNavigationBarItem(
            label: 'Order',
            icon: Icon(Icons.add_chart),
          ),
          BottomNavigationBarItem(
            label: 'UD Truck',
            icon: Icon(
              Icons.tab,
              color: Colors.transparent,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Call Center',
            icon: Icon(Icons.phone_outlined),
          ),
          BottomNavigationBarItem(
            label: 'Profil',
            icon: Icon(Icons.person_outline),
          ),
        ]);
  }

  @override
  void onError(String error) {
    Navigator.pop(context);
    _logout();
    showSnackbar(context, error, Theme.of(context).errorColor);
  }

  @override
  void onGetProfile(UserResponse user) {
    setState(() {
      _username = 'Hi, ${user.fullname}';
      _screens.addAll([
        const OrderWidget(),
        const Text(''),
        CallCenterWidget(phoneNumber: user.phone),
        ProfileWidget(userName: user.fullname)
      ]);
    });
  }

  @override
  void onGetPoints(int points) {
    Navigator.pop(context);
    setState(() {
      _points = points;
    });
  }
}
