import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rakhaa/bloc/search/search_bloc.dart';

import '../screen_util.dart';
import 'product_item.dart';

class SearchResult extends StatelessWidget {
  final String keyword;

  final ScreenUtil _screenUtil = ScreenUtil();

  SearchResult({
    @required this.keyword,
  });

  @override
  Widget build(BuildContext context) {
    _screenUtil.init(context);

    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild.unfocus();
        }
      },
      child: BlocProvider(
        create: (_) => SearchBloc()..add(Searching(keyword)),
        child: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            if (state is SearchingState) {
              return Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              );
            } else if (state is SearchedState) {
              return state.products.length > 0
                  ? Column(
                      children: [
                        // Title
                        Padding(
                          padding: EdgeInsets.all(_screenUtil.setWidth(50)),
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              'نتائج البحث',
                              style: TextStyle(
                                fontSize: _screenUtil.setSp(100),
                              ),
                            ),
                          ),
                        ),

                        // Search result
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(_screenUtil.setWidth(10)),
                            child: GridView.count(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              crossAxisCount: 2,
                              childAspectRatio: (itemWidth / itemHeight),
                              crossAxisSpacing: _screenUtil.setWidth(40),
                              mainAxisSpacing: _screenUtil.setWidth(40),
                              children:
                                  List.generate(state.products.length, (index) {
                                return ProductItem(
                                  id: state.products[index].id,
                                  title: state.products[index].name,
                                  imageUrl: state.products[index].imageUrl,
                                  price: state.products[index].price,
                                  afterDiscount: state.products[index].price -
                                      (state.products[index].price *
                                          state.products[index].discount /
                                          100),
                                  percentage: state.products[index].discount,
                                  // onMerchantNameTapped: widget.onMerchantNameTapped,
                                );
                              }),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Center(
                      child: Text(
                        'عفوًا لا يوجد نتائج',
                        style: TextStyle(
                          fontSize: _screenUtil.setSp(50),
                        ),
                      ),
                    );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
