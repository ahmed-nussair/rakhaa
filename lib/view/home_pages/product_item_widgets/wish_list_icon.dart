import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/wish_list/wish_list_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../screen_util.dart';
import '../../../globals.dart' as Globals;

class WishListIcon extends StatefulWidget {
  final int id;

  WishListIcon({@required this.id});

  @override
  _WishListIconState createState() => _WishListIconState();
}

class _WishListIconState extends State<WishListIcon> {
  final ScreenUtil _screenUtil = ScreenUtil();

  bool _wishListed;

  @override
  void initState() {
    _wishListed = false;
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
              ..add(LoadingWishList(snapshot.data.getString(Globals.token),
                  productId: widget.id)),
            child: BlocListener<WishListBloc, WishListState>(
              listener: (context, state) {
                if (state is AddedToWishListState) {
                  setState(() {
                    _wishListed = true;
                  });
                } else if (state is DeletedFromWishListState) {
                  setState(() {
                    _wishListed = false;
                  });
                } else if (state is WishListLoadedState) {
                  setState(() {
                    _wishListed = state.products.length > 0 ? true : false;
                  });
                } else {
                  setState(() {
                    _wishListed = false;
                  });
                }
              },
              child: BlocBuilder<WishListBloc, WishListState>(
                builder: (context, state) {
                  if (state is LoadingWishListState ||
                      state is AddingToWishListState ||
                      state is DeletingFromWishListState) {
                    return Container(
                      alignment: Alignment.center,
                      width: _screenUtil.setWidth(40),
                      height: _screenUtil.setHeight(40),
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return GestureDetector(
                      onTap: () {
                        if (_wishListed) {
                          BlocProvider.of<WishListBloc>(context).add(
                              DeletingFromWishList(
                                  snapshot.data.getString(Globals.token),
                                  widget.id));
                        } else {
                          BlocProvider.of<WishListBloc>(context).add(
                              AddingToWishList(
                                  snapshot.data.getString(Globals.token),
                                  widget.id));
                        }
                        // BlocProvider.of<WishListBloc>(context).add(DeletingFromWishList(snapshot.data.getString(Globals.token), widget.id));
                        // setState(() {
                        //   _wishListed = _wishListed ? false : true;
                        // });
                      },
                      child: Icon(
                        _wishListed ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red,
                        size: _screenUtil.setSp(70),
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
