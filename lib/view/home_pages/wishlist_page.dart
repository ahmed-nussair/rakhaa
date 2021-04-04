import 'package:flutter/material.dart';
import 'wishlist_item.dart';
import '../screen_util.dart';

class WishListPage extends StatefulWidget {
  @override
  _WishListPageState createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  final ScreenUtil _screenUtil = ScreenUtil();

  List _list;

  @override
  void initState() {
    _list = _wishListItems;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _screenUtil.init(context);
    return _list.length > 0
        ? SafeArea(
            child: Scaffold(
              body: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.all(_screenUtil.setWidth(30)),
                    sliver: SliverGrid.count(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      crossAxisSpacing: _screenUtil.setWidth(30),
                      mainAxisSpacing: _screenUtil.setWidth(30),
                      children: List.generate(_wishListItems.length, (index) {
                        return Stack(
                          children: [
                            WishListItem(
                              title: _list[index]['title'],
                              imageUrl: _list[index]['imageUrl'],
                              price: _list[index]['price'],
                              afterDiscount: _list[index]['afterDiscount'],
                              rating: _list[index]['rating'],
                              // onMerchantNameTapped: widget.onMerchantNameTapped,
                            ),
                            Positioned(
                              top: _screenUtil.setHeight(20),
                              left: _screenUtil.setWidth(20),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      _wishListItems
                                          .remove(_wishListItems[index]);
                                      setState(() {
                                        _list = _wishListItems;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(
                                            _screenUtil.setWidth(50)),
                                      ),
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: _screenUtil.setHeight(30),
                                  ),
                                  Icon(
                                    Icons.shopping_cart_outlined,
                                    size: _screenUtil.setSp(70),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Center(
            child: Text(
              'ليس لديك أي صنف في المفضلة',
              style: TextStyle(
                fontSize: _screenUtil.setSp(50),
              ),
            ),
          );
  }
}

List _wishListItems = [
  {
    'imageUrl': 'https://i.ibb.co/M9f86L6/aquafina-0-5.jpg',
    'title': 'أكوافينا 0.5 لتر',
    'price': 3.0,
    'afterDiscount': 3.0,
  },
  {
    'imageUrl': 'https://i.ibb.co/80CFJtt/aquafina-19.jpg',
    'title': 'أكوافينا 19 جالون',
    'price': 100.0,
    'afterDiscount': 100.0,
  },
  {
    'imageUrl': 'https://i.ibb.co/LSpKByw/baraka-1-5.jpg',
    'title': 'بركة 1.5 لتر',
    'price': 5.0,
    'afterDiscount': 5.0,
  },
  {
    'imageUrl': 'https://i.ibb.co/wQsPDVD/nestle-0-5.jpg',
    'title': 'نستله 0.5 لتر',
    'price': 3.0,
    'afterDiscount': 3.0,
  },
];
