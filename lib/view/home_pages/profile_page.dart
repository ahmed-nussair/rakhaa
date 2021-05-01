import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screen_util.dart';
import 'profile_pages/addresses_page.dart';
import 'profile_pages/details_page.dart';

import '../../globals.dart' as Globals;

final List addresses = [
  {
    'firstLine': '40 ب ، السويسري ب ، الحي العاشر',
    'secondLine': 'أمام مدرسة سعد بن أبي وقاص',
    'city': 'مدينة نصر',
    'state': 'القاهرة',
    'country': 'مصر',
    'zipPostalCode': '5435435',
    'latitude': '30.046348',
    'longitude': '31.366725',
  },
  {
    'firstLine': '40B, El-Swissry B, The 10th District',
    'secondLine': '',
    'city': 'Nasr City',
    'state': 'Cairo',
    'country': 'Egypt',
    'zipPostalCode': '11134',
    'latitude': '30.047508',
    'longitude': '31.352309',
  },
];

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  TabController _tabController;
  int _currentTabIndex = 1;
  final _screenUtil = ScreenUtil();

  List _tabs = [
    'عناوين',
    'بيانات',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _tabs.length,
      vsync: this,
      initialIndex: _currentTabIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    _screenUtil.init(context);
    return Scaffold(
      appBar: TabBar(
        isScrollable: false,
        controller: _tabController,
        onTap: (index) {
          setState(() {
            _currentTabIndex = index;
          });
        },
        tabs: List.generate(_tabs.length, (index) {
          return Tab(
            child: Text(
              '${_tabs[index]}',
              style: TextStyle(
                color: Colors.black,
                fontSize: _screenUtil.setSp(40),
                // fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          );
        }),
      ),
      body: TabBarView(
        controller: _tabController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          AddressesPage(addresses: addresses),
          FutureBuilder<SharedPreferences>(
            future: SharedPreferences.getInstance(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return DetailsPage(
                  name: snapshot.data.getString(Globals.name),
                  imageUrl: snapshot.data.getString(Globals.imageUrl),
                  email: snapshot.data.getString(Globals.email),
                  password: snapshot.data.getString(Globals.password),
                  phone: snapshot.data.getString(Globals.phone),
                  token: snapshot.data.getString(Globals.token),
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
