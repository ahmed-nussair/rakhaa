import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../screen_util.dart';

import '../../bloc/sub_categories/sub_categories_bloc.dart';
import '../../bloc/products/products_bloc.dart';

import 'products_page.dart';

final int subCategoriesSate = 0;
final int productsState = 1;

class CategoryPage extends StatefulWidget {
  final int categoryId;
  final String categoryName;
  final Function onBackTapped;

  CategoryPage({
    @required this.onBackTapped,
    @required this.categoryName,
    @required this.categoryId,
  });

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final ScreenUtil _screenUtil = ScreenUtil();

  int _subCategoryId;
  int _pageState;

  String _subCategoryName;

  @override
  void initState() {
    _subCategoryId = -1;
    _pageState = subCategoriesSate;
    _subCategoryName = 'كل المنتجات';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _screenUtil.init(context);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild.unfocus();
        }
      },
      child: BlocProvider(
        create: (_) =>
            SubCategoriesBloc()..add(LoadingSubCategories(widget.categoryId)),
        child: BlocBuilder<SubCategoriesBloc, SubCategoriesState>(
          builder: (context, state) {
            return SafeArea(
              child: Scaffold(
                  appBar: AppBar(
                    title: Text(
                      widget.categoryName,
                      style: TextStyle(
                        fontSize: _screenUtil.setSp(50),
                        color: Colors.white,
                      ),
                    ),
                    leading: GestureDetector(
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        widget.onBackTapped();
                      },
                      child: Icon(Icons.arrow_back_ios),
                    ),
                    centerTitle: true,
                    backgroundColor: Color(0xff4599d7),
                  ),
                  body: _pageState == subCategoriesSate
                      ? state is LoadingSubCategoriesState
                          ? Container()
                          : state is SubCategoriesLoadedState
                              ? Builder(
                                  builder: (context) {
                                    if (state.subCategories.length > 0) {
                                      return Builder(
                                        builder: (context) {
                                          List _subCategories = [];

                                          for (var item
                                              in state.subCategories) {
                                            Map map = {
                                              'imageUrl': item.imageUrl,
                                              'title': item.name,
                                              'onTapped': () {
                                                setState(() {
                                                  _subCategoryId = item.id;
                                                  _pageState = productsState;
                                                  _subCategoryName = item.name;
                                                });
                                              },
                                              'categoryId': item.categoryId,
                                              'id': item.id
                                            };

                                            _subCategories.add(map);
                                          }

                                          if (_subCategories.length > 0) {
                                            _subCategories.add({
                                              'imageUrl':
                                                  'assets/all_sub_categories.png',
                                              'title': 'الكل',
                                              'onTapped': () {
                                                setState(() {
                                                  _subCategoryId = -1;
                                                  _pageState = productsState;
                                                  _subCategoryName =
                                                      'كل المنتجات';
                                                });
                                              },
                                              'categoryId': widget.categoryId,
                                              'id': -1,
                                            });
                                          }

                                          return GridView.count(
                                            crossAxisCount: 3,
                                            children: List.generate(
                                                _subCategories.length, (index) {
                                              return Padding(
                                                padding: EdgeInsets.all(
                                                    _screenUtil.setWidth(10)),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    FocusScope.of(context)
                                                        .requestFocus(
                                                            FocusNode());
                                                    _subCategories[index]
                                                        ['onTapped']();
                                                  },
                                                  child: Column(
                                                    children: [
                                                      Flexible(
                                                        flex: 5,
                                                        child: Container(
                                                          height: _screenUtil
                                                              .setWidth(150),
                                                          width: _screenUtil
                                                              .setWidth(150),
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                              width: _screenUtil
                                                                  .setHeight(1),
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            borderRadius: BorderRadius.all(
                                                                Radius.circular(
                                                                    _screenUtil
                                                                        .setHeight(
                                                                            100))),
                                                            image: index <
                                                                    _subCategories
                                                                            .length -
                                                                        1
                                                                ? DecorationImage(
                                                                    fit: BoxFit
                                                                        .fill,
                                                                    image:
                                                                        NetworkImage(
                                                                      _subCategories[
                                                                              index]
                                                                          [
                                                                          'imageUrl'],
                                                                    ),
                                                                  )
                                                                : DecorationImage(
                                                                    scale: _screenUtil
                                                                        .setWidth(
                                                                            10),
                                                                    image:
                                                                        AssetImage(
                                                                      _subCategories[
                                                                              index]
                                                                          [
                                                                          'imageUrl'],
                                                                    ),
                                                                  ),
                                                          ),
                                                        ),
                                                      ),
                                                      Flexible(
                                                        flex: 2,
                                                        child: Text(
                                                          _subCategories[index]
                                                              ['title'],
                                                          style: TextStyle(
                                                              fontSize:
                                                                  _screenUtil
                                                                      .setSp(
                                                                          35),
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),
                                          );
                                        },
                                      );
                                    }
                                    return ProductsView(
                                      categoryId: widget.categoryId,
                                      subCategoryId: _subCategoryId,
                                      subCategoryName: _subCategoryName,
                                      onBackTapped: () {
                                        setState(() {
                                          _pageState = subCategoriesSate;
                                        });
                                      },
                                    );
                                  },
                                )
                              : Container()
                      : _pageState == productsState
                          ? ProductsView(
                              categoryId: widget.categoryId,
                              subCategoryId: _subCategoryId,
                              subCategoryName: _subCategoryName,
                              onBackTapped: () {
                                setState(() {
                                  _pageState = subCategoriesSate;
                                });
                              },
                            )
                          : Container()),
            );
          },
        ),
      ),
    );
  }
}

class ProductsView extends StatelessWidget {
  final int categoryId;
  final int subCategoryId;
  final String subCategoryName;
  final Function onBackTapped;

  final ScreenUtil _screenUtil = ScreenUtil();

  ProductsView({
    @required this.categoryId,
    @required this.subCategoryId,
    @required this.subCategoryName,
    @required this.onBackTapped,
  });

  @override
  Widget build(BuildContext context) {
    _screenUtil.init(context);
    return BlocProvider(
      create: (_) => ProductsBloc()
        ..add(LoadingProducts(categoryId, subCategoryId: subCategoryId)),
      child: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          if (state is ProductsLoadedState) {
            return state.products.length > 0
                ? ProductsPage(
                    subCategoryName: subCategoryName,
                    onBackTapped: () {
                      onBackTapped();
                    },
                    productsList: state.products,
                  )
                : Center(
                    child: Text(
                      'لا يوجد أي منتجات تحت هذه الفئة',
                      style: TextStyle(
                        fontSize: _screenUtil.setSp(50),
                      ),
                    ),
                  );
          }
          return Container();
        },
      ),
    );
  }
}
