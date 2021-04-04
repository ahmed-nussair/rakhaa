import 'package:flutter/material.dart';
import '../screen_util.dart';
import '../../globals.dart' as globals;

class MainPage extends StatefulWidget {
  final Function onCategoryTapped;

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
    return GridView.count(
      crossAxisCount: 2,
      padding: EdgeInsets.all(_screenUtil.setWidth(50)),
      crossAxisSpacing: _screenUtil.setWidth(50),
      mainAxisSpacing: _screenUtil.setWidth(50),
      children: List.generate(globals.categories.length, (index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(_screenUtil.setWidth(50)),
          child: GestureDetector(
            onTap: () {
              widget.onCategoryTapped();
            },
            child: Stack(
              children: [
                Image.network(
                  '${globals.categories[index]['imageUrl']}',
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
                      '${globals.categories[index]['name']}',
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
}
