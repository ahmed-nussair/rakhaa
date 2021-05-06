import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../screen_util.dart';
import '../../bloc/categories/categories_bloc.dart';

class MainPage extends StatefulWidget {
  final Function(int, String) onCategoryTapped;

  MainPage({
    @required this.onCategoryTapped,
  });

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final ScreenUtil _screenUtil = ScreenUtil();

  @override
  Widget build(BuildContext context) {
    _screenUtil.init(context);
    return BlocProvider(
      create: (_) => CategoriesBloc()..add(LoadingCategories()),
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            currentFocus.focusedChild.unfocus();
          }
        },
        child: BlocListener<CategoriesBloc, CategoriesState>(
            listener: (context, state) {
          if (state is CategoryLoadedState) {
            widget.onCategoryTapped(state.category.id, state.category.name);
          }
        }, child: BlocBuilder<CategoriesBloc, CategoriesState>(
          builder: (context, state) {
            if (state is LoadingCategoriesState) {
              return Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                ),
              );
            } else if (state is CategoriesLoadedState) {
              return GridView.count(
                crossAxisCount: 2,
                padding: EdgeInsets.all(_screenUtil.setWidth(50)),
                crossAxisSpacing: _screenUtil.setWidth(50),
                mainAxisSpacing: _screenUtil.setWidth(50),
                children: List.generate(state.categories.length, (index) {
                  return ClipRRect(
                    borderRadius:
                        BorderRadius.circular(_screenUtil.setWidth(50)),
                    child: GestureDetector(
                      onTap: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        BlocProvider.of<CategoriesBloc>(context)
                            .add(LoadCategory(state.categories[index].id));
                      },
                      child: Stack(
                        children: [
                          Image.network(
                            '${state.categories[index].imageUrl}',
                            height: MediaQuery.of(context).size.height,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            color: Colors.blueAccent.withOpacity(0.5),
                          ),
                          Positioned(
                            top: 0.0,
                            bottom: 0.0,
                            left: 0.0,
                            right: 0.0,
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                '${state.categories[index].name}',
                                style: TextStyle(
                                  fontSize: _screenUtil.setSp(100),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              );
            }
            return Container();
          },
        )),
      ),
    );
  }
}
