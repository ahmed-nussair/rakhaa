import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screen_util.dart';

import 'product_item.dart';

List _subCategories = [
  {
    'imageUrl': 'https://i.ibb.co/BPqCChL/nestle.png',
    'title': 'نستله',
    'onTapped': () {
      print('tapped');
    },
  },
  {
    'imageUrl': 'https://i.ibb.co/C5zBYtJ/baraka.jpg',
    'title': 'بركة',
    'onTapped': () {
      print('tapped');
    },
  },
  {
    'imageUrl': 'https://i.ibb.co/zfF6Zdg/aquafina.png',
    'title': 'أكوافينا',
    'onTapped': () {
      print('tapped');
    },
  },
  {
    'imageUrl': 'assets/all_sub_categories.png',
    'title': 'الكل',
    'onTapped': () {
      print('tapped');
    },
  },
];

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

  @override
  Widget build(BuildContext context) {
    _screenUtil.init(context);
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(
                widget.categoryName,
                style: TextStyle(
                  fontSize: _screenUtil.setSp(50),
                  color: Colors.white,
                ),
              ),
              leading: GestureDetector(
                onTap: () {
                  widget.onBackTapped();
                },
                child: Icon(Icons.arrow_back_ios),
              ),
              centerTitle: true,
              backgroundColor: Color(0xff4599d7),
            ),
            SliverGrid.count(
              crossAxisCount: 4,
              children: List.generate(_subCategories.length, (index) {
                return Padding(
                  padding: EdgeInsets.all(_screenUtil.setWidth(10)),
                  child: Column(
                    children: [
                      Flexible(
                        flex: 5,
                        child: Container(
                          height: _screenUtil.setWidth(150),
                          width: _screenUtil.setWidth(150),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: _screenUtil.setHeight(1),
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.all(
                                Radius.circular(_screenUtil.setHeight(100))),
                            image: index < _subCategories.length - 1
                                ? DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                      _subCategories[index]['imageUrl'],
                                    ),
                                  )
                                : DecorationImage(
                                    scale: _screenUtil.setWidth(10),
                                    image: AssetImage(
                                      _subCategories[index]['imageUrl'],
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Text(
                          _subCategories[index]['title'],
                          style: TextStyle(
                              fontSize: _screenUtil.setSp(35),
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
            SliverPadding(
              padding: EdgeInsets.all(_screenUtil.setWidth(30)),
              sliver: SliverGrid.count(
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: _screenUtil.setWidth(30),
                mainAxisSpacing: _screenUtil.setWidth(30),
                children: List.generate(_products.length, (index) {
                  return ProductItem(
                    title: _products[index]['title'],
                    imageUrl: _products[index]['imageUrl'],
                    price: _products[index]['price'],
                    afterDiscount: _products[index]['afterDiscount'],
                    percentage: _products[index]['percentage'],
                    // onMerchantNameTapped: widget.onMerchantNameTapped,
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List _products = [
  {
    'imageUrl': 'https://i.ibb.co/M9f86L6/aquafina-0-5.jpg',
    'title': 'أكوافينا 0.5 لتر',
    'price': 3.0,
    'afterDiscount': 3.0,
    'percentage': 20.0,
  },
  {
    'imageUrl': 'https://i.ibb.co/80CFJtt/aquafina-19.jpg',
    'title': 'أكوافينا 19 جالون',
    'price': 100.0,
    'afterDiscount': 100.0,
    'percentage': 15.0,
  },
  {
    'imageUrl': 'https://i.ibb.co/LSpKByw/baraka-1-5.jpg',
    'title': 'بركة 1.5 لتر',
    'price': 5.0,
    'afterDiscount': 5.0,
    'percentage': 10.0,
  },
  {
    'imageUrl': 'https://i.ibb.co/wQsPDVD/nestle-0-5.jpg',
    'title': 'نستله 0.5 لتر',
    'price': 3.0,
    'afterDiscount': 3.0,
    'percentage': 0.0,
  },
  {
    'imageUrl': 'https://i.ibb.co/HTt6JyG/nestle-1-5.jpg',
    'title': 'نستله 1.5 لتر',
    'price': 5.0,
    'afterDiscount': 5.0,
    'percentage': 0.0,
  },
  {
    'imageUrl': 'https://i.ibb.co/wQsPDVD/nestle-0-5.jpg',
    'title': 'نستله 0.5 لتر',
    'price': 3.0,
    'afterDiscount': 3.0,
    'percentage': 0.0,
  },
];