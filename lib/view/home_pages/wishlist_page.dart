import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../bloc/wish_list/wish_list_bloc.dart';
import 'wishlist_item.dart';
import '../screen_util.dart';
import '../../globals.dart' as Globals;

class WishListPage extends StatefulWidget {
  @override
  _WishListPageState createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  final ScreenUtil _screenUtil = ScreenUtil();

  List _list;

  @override
  void initState() {
    _list = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _screenUtil.init(context);
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return BlocProvider(
            create: (_) => WishListBloc()
              ..add(LoadingWishList(snapshot.data.getString(Globals.token))),
            child: BlocListener<WishListBloc, WishListState>(
              listener: (context, state) {
                if (state is WishListLoadedState) {
                  setState(() {
                    _list = state.products;
                  });
                }
                if (state is DeletedFromWishListState) {
                  List list = _list;

                  for (int i = 0; i < list.length; i++) {
                    if (list[i].id == state.productId) {
                      list.remove(list[i]);
                      break;
                    }
                  }

                  setState(() {
                    _list = list;
                  });
                }
              },
              child: BlocBuilder<WishListBloc, WishListState>(
                builder: (context, state) {
                  if (state is LoadingWishListState) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                        ],
                      ),
                    );
                  } else {
                    return _list.length > 0
                        ? SafeArea(
                            child: Stack(
                              children: [
                                Scaffold(
                                  body: CustomScrollView(
                                    slivers: [
                                      SliverPadding(
                                        padding: EdgeInsets.all(
                                            _screenUtil.setWidth(30)),
                                        sliver: SliverGrid.count(
                                          crossAxisCount: 2,
                                          childAspectRatio: 1,
                                          crossAxisSpacing:
                                              _screenUtil.setWidth(30),
                                          mainAxisSpacing:
                                              _screenUtil.setWidth(30),
                                          children: List.generate(_list.length,
                                              (index) {
                                            return WishListItem(
                                              id: _list[index].id,
                                              title: _list[index].name,
                                              imageUrl: _list[index].imageUrl,
                                              price: _list[index].price,
                                              afterDiscount: _list[index]
                                                      .price -
                                                  (_list[index].price *
                                                      _list[index].discount /
                                                      100),
                                              onItemBeingDeleted: () {
                                                BlocProvider.of<WishListBloc>(
                                                        context)
                                                    .add(DeletingFromWishList(
                                                        snapshot.data.getString(
                                                            Globals.token),
                                                        _list[index].id));
                                              },
                                              // onMerchantNameTapped: widget.onMerchantNameTapped,
                                            );
                                          }),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                state is DeletingFromWishListState
                                    ? Positioned(
                                        top: 0.0,
                                        bottom: 0.0,
                                        left: 0.0,
                                        right: 0.0,
                                        child: Container(
                                          color: Colors.black.withOpacity(0.5),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                  width: 100,
                                                  height: 100,
                                                  child:
                                                      CircularProgressIndicator()),
                                            ],
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ],
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
                },
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}

// List _wishListItems = [
//   {
//     'imageUrl': 'https://i.ibb.co/M9f86L6/aquafina-0-5.jpg',
//     'title': 'أكوافينا 0.5 لتر',
//     'price': 3.0,
//     'afterDiscount': 3.0,
//   },
//   {
//     'imageUrl': 'https://i.ibb.co/80CFJtt/aquafina-19.jpg',
//     'title': 'أكوافينا 19 جالون',
//     'price': 100.0,
//     'afterDiscount': 100.0,
//   },
//   {
//     'imageUrl': 'https://i.ibb.co/LSpKByw/baraka-1-5.jpg',
//     'title': 'بركة 1.5 لتر',
//     'price': 5.0,
//     'afterDiscount': 5.0,
//   },
//   {
//     'imageUrl': 'https://i.ibb.co/wQsPDVD/nestle-0-5.jpg',
//     'title': 'نستله 0.5 لتر',
//     'price': 3.0,
//     'afterDiscount': 3.0,
//   },
// ];
