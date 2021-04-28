import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rakhaa/view/home_pages/category_page.dart';

import 'home_pages/profile_page.dart';
import 'home_pages/orders_history.dart';
import 'home_pages/wishlist_page.dart';
import 'home_pages/shopping_cart_page.dart';
import 'screen_util.dart';

import '../bloc/home_page/home_page_bloc.dart';

import 'home_pages/main_page.dart';

import 'signin.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScreenUtil _screenUtil = ScreenUtil();
  final _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _screenUtil.init(context);

    return BlocProvider(
      create: (_) => HomePageBloc()..add(NavigateToMainPage()),
      child: BlocBuilder<HomePageBloc, HomePageState>(
        builder: (context, state) {
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
                                    hintStyle: TextStyle(
                                        fontSize: _screenUtil.setSp(50)),
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
                                      topLeft: Radius.circular(
                                          _screenUtil.setWidth(100)),
                                      bottomLeft: Radius.circular(
                                          _screenUtil.setWidth(100)),
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
                                BlocProvider.of<HomePageBloc>(context)
                                    .add(NavigateToMainPage());
                                Navigator.of(context).pop();
                              },
                              title: _drawerItem(
                                  context, Icons.home, 'الصفحة الرئيسية'),
                            ),
                            ListTile(
                              onTap: () {
                                BlocProvider.of<HomePageBloc>(context)
                                    .add(NavigateToProfilePage());
                                Navigator.of(context).pop();
                              },
                              title: _drawerItem(context, Icons.person_outline,
                                  'الملف الشخصي'),
                            ),
                            ListTile(
                              onTap: () {
                                BlocProvider.of<HomePageBloc>(context)
                                    .add(NavigateToOrdersHistoryPage());
                                Navigator.of(context).pop();
                              },
                              title: _drawerItem(
                                  context, Icons.list, 'سجل الطلبات'),
                            ),
                            ListTile(
                              onTap: () {
                                BlocProvider.of<HomePageBloc>(context)
                                    .add(NavigateToWishListPage());
                                Navigator.of(context).pop();
                              },
                              title: _drawerItem(
                                  context, Icons.favorite, 'المفضلة'),
                            ),
                            ListTile(
                              onTap: () {
                                BlocProvider.of<HomePageBloc>(context)
                                    .add(NavigateToShoppingCartPage());
                                Navigator.of(context).pop();
                              },
                              title: _drawerItem(
                                  context, Icons.shopping_cart, 'عربة التسوق'),
                            ),
                            ListTile(
                              onTap: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => SignIn()));
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
                body: state is MainPageState
                    ? MainPage(
                        onCategoryTapped:
                            (int categoryId, String categoryName) {
                          BlocProvider.of<HomePageBloc>(context).add(
                              NavigateToCategoryPage(categoryId, categoryName));
                        },
                      )
                    : state is CategoryPageState
                        ? CategoryPage(
                  categoryId: state.categoryId,
                            categoryName: state.categoryName,
                            onBackTapped: () {
                              BlocProvider.of<HomePageBloc>(context)
                                  .add(NavigateToMainPage());
                            },
                          )
                        : state is ProfilePageState
                            ? ProfilePage()
                            : state is OrdersHistoryPageState
                                ? OrdersHistory()
                                : state is WishListPageState
                                    ? WishListPage()
                                    : state is ShoppingCartPageState
                                        ? ShoppingCartPage()
                                        : Container()),
          );
        },
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
