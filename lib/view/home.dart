import 'package:flutter/material.dart';
import 'package:rakhaa/view/home_pages/category_page.dart';

import 'home_pages/profile_page.dart';
import 'home_pages/orders_history.dart';
import 'home_pages/wishlist_page.dart';
import 'home_pages/shopping_cart_page.dart';
import 'screen_util.dart';

import 'home_pages/main_page.dart';

import 'signin.dart';

int _mainPageIndex = 0;
int _categoryPageIndex = 1;
int _profilePageIndex = 2;
int _ordersHistoryIndex = 3;
int _wishListPageIndex = 4;
int _shoppingCartIndex = 5;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScreenUtil _screenUtil = ScreenUtil();
  final _key = GlobalKey<ScaffoldState>();

  int _index;

  @override
  void initState() {
    super.initState();
    _index = _mainPageIndex;
  }

  @override
  Widget build(BuildContext context) {
    _screenUtil.init(context);

    return SafeArea(
      child: Scaffold(
        key: _key,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(_screenUtil.setHeight(300)),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: _screenUtil.setHeight(200),
            color: Color(0xff4599d7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // profile image
                Flexible(
                  flex: 1,
                  child: CircleAvatar(
                    radius: _screenUtil.setWidth(70),
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage('assets/person.png'),
                  ),
                ),

                // Search bar
                Flexible(
                  flex: 5,
                  child: Stack(
                    children: [
                      Container(
                        height: _screenUtil.setHeight(150),
                        child: TextFormField(
                          textAlign: TextAlign.right,
                          textAlignVertical: TextAlignVertical.center,
                          textDirection: TextDirection.rtl,
                          decoration: InputDecoration(
                            hintText: 'اكتب هنا ما تريد',
                            hintStyle:
                                TextStyle(fontSize: _screenUtil.setSp(50)),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  _screenUtil.setWidth(100)),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0.0,
                        bottom: 0.0,
                        left: 0.0,
                        child: Container(
                          width: _screenUtil.setWidth(130),
                          decoration: BoxDecoration(
                            color: Color(0xff3573ac),
                            borderRadius: BorderRadius.only(
                              topLeft:
                                  Radius.circular(_screenUtil.setWidth(100)),
                              bottomLeft:
                                  Radius.circular(_screenUtil.setWidth(100)),
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              print('Tapped');
                            },
                            child: Icon(
                              Icons.search,
                              color: Colors.white,
                              size: _screenUtil.setSp(70),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Drawer opener
                Flexible(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      _key.currentState.openEndDrawer();
                    },
                    child: Image.asset(
                      'assets/more.png',
                      width: _screenUtil.setWidth(100),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        endDrawer: Container(
          width: _screenUtil.setWidth(700),
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Flexible(
                flex: 8,
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      onTap: () {
                        setState(() {
                          _index = _mainPageIndex;
                        });
                        Navigator.of(context).pop();
                      },
                      title:
                          _drawerItem(context, Icons.home, 'الصفحة الرئيسية'),
                    ),
                    ListTile(
                      onTap: () {
                        setState(() {
                          _index = _profilePageIndex;
                        });
                        Navigator.of(context).pop();
                      },
                      title: _drawerItem(
                          context, Icons.person_outline, 'الملف الشخصي'),
                    ),
                    ListTile(
                      onTap: () {
                        setState(() {
                          _index = _ordersHistoryIndex;
                        });
                        Navigator.of(context).pop();
                      },
                      title: _drawerItem(context, Icons.list, 'سجل الطلبات'),
                    ),
                    ListTile(
                      onTap: () {
                        setState(() {
                          _index = _wishListPageIndex;
                        });
                        Navigator.of(context).pop();
                      },
                      title: _drawerItem(context, Icons.favorite, 'المفضلة'),
                    ),
                    ListTile(
                      onTap: () {
                        setState(() {
                          _index = _shoppingCartIndex;
                        });
                        Navigator.of(context).pop();
                      },
                      title: _drawerItem(
                          context, Icons.shopping_cart, 'عربة التسوق'),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => SignIn()));
                      },
                      title: _drawerItem(
                          context, Icons.exit_to_app, 'تسجيل الخروج'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: _index == _mainPageIndex
            ? MainPage(
                onCategoryTapped: () {
                  setState(() {
                    _index = _categoryPageIndex;
                  });
                },
              )
            : _index == _categoryPageIndex
                ? CategoryPage(
                    onBackTapped: () {
                      setState(() {
                        _index = _mainPageIndex;
                      });
                    },
                  )
                : _index == _profilePageIndex
                    ? ProfilePage()
                    : _index == _wishListPageIndex
                        ? WishListPage()
                        : _index == _ordersHistoryIndex
                            ? OrdersHistory()
                            : _index == _shoppingCartIndex
                                ? ShoppingCartPage()
                                : Container(),
      ),
    );
  }

  Widget _drawerItem(BuildContext context, IconData icon, String title) {
    _screenUtil.init(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Flexible(
          flex: 5,
          child: Text(
            title,
            style: TextStyle(
              fontSize: _screenUtil.setSp(40),
            ),
          ),
        ),
        SizedBox(
          width: _screenUtil.setWidth(30),
        ),
        Flexible(
          flex: 1,
          child: Icon(
            icon,
            color: Color(0xff4599d7),
            size: _screenUtil.setSp(50),
          ),
        ),
      ],
    );
  }
}
