import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../bloc/orders/orders_bloc.dart';
import '../screen_util.dart';
import 'orders_history_item.dart';
import '../../globals.dart' as Globals;

class OrdersHistory extends StatefulWidget {
  @override
  _OrdersHistoryState createState() => _OrdersHistoryState();
}

class _OrdersHistoryState extends State<OrdersHistory> {
  final ScreenUtil _screenUtil = ScreenUtil();

  List<Map<String, dynamic>> _ordersHistory;

  @override
  void initState() {
    _ordersHistory = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _screenUtil.init(context);

    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          String token = snapshot.data.getString(Globals.token);
          return BlocProvider(
            create: (_) => OrdersBloc()..add(LoadingOrders(token)),
            child: BlocListener<OrdersBloc, OrdersState>(
              listener: (context, state) {
                if (state is OrdersLoadedState) {
                  setState(() {
                    for (var order in state.orders) {
                      Map<String, dynamic> data = {
                        'id': order.id,
                        'dateTime': order.dateTime,
                        'status': order.status.name,
                        'statusColor': order.status.id == 1
                            ? 0xFFffae42
                            : order.status.id == 2
                                ? 0xFF008000
                                : order.status.id == 3
                                    ? 0xFFFF0000
                                    : 0xFF000000
                      };

                      _ordersHistory.add(data);
                    }
                  });
                } else if (state is ErrorLoadingOrdersState) {
                  print(state.message);
                }
              },
              child: BlocBuilder<OrdersBloc, OrdersState>(
                builder: (context, state) {
                  if (state is LoadingOrdersState) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [CircularProgressIndicator()],
                      ),
                    );
                  }
                  return ListView(
                    children: List.generate(
                        _ordersHistory.length,
                        (index) => OrdersHistoryItem(
                              token: token,
                              orderId: _ordersHistory[index]['id'],
                              orderDateTime: _ordersHistory[index]['dateTime'],
                              orderStatus: _ordersHistory[index]['status'],
                              statusColor: _ordersHistory[index]['statusColor'],
                            )),
                  );
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