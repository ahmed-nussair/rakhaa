import 'package:flutter/material.dart';
import '../screen_util.dart';

import 'product_item.dart';

class ProductsPage extends StatelessWidget {
  final String subCategoryName;
  final List productsList;
  final Function onBackTapped;

  final ScreenUtil _screenUtil = ScreenUtil();

  ProductsPage({
    @required this.subCategoryName,
    @required this.productsList,
    @required this.onBackTapped,
  });

  @override
  Widget build(BuildContext context) {
    _screenUtil.init(context);

    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          subCategoryName,
          style: TextStyle(
            fontSize: _screenUtil.setSp(50),
            color: Colors.white,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
            onBackTapped();
          },
          child: Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff4599d7),
      ),
      body: Padding(
        padding: EdgeInsets.all(_screenUtil.setWidth(50)),
        child: GridView.count(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          crossAxisCount: 2,
          childAspectRatio: (itemWidth / itemHeight),
          crossAxisSpacing: _screenUtil.setWidth(40),
          mainAxisSpacing: _screenUtil.setWidth(40),
          children: List.generate(productsList.length, (index) {
            return ProductItem(
              id: productsList[index].id,
              title: productsList[index].name,
              imageUrl: productsList[index].imageUrl,
              price: productsList[index].price,
              afterDiscount: productsList[index].price -
                  (productsList[index].price *
                      productsList[index].discount /
                      100),
              percentage: productsList[index].discount,
              // onMerchantNameTapped: widget.onMerchantNameTapped,
            );
          }),
        ),
      ),
    );
  }
}
