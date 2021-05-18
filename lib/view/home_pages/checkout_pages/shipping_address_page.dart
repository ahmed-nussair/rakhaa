import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../bloc/addresses/addresses_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../screen_util.dart';
import 'shipping_addresses_pages/addresses_list.dart';
import 'shipping_addresses_pages/new_address.dart';
import '../../../globals.dart' as Globals;

class ShippingAddressPage extends StatefulWidget {
  final Function(Map<String, dynamic>) onAddressSelected;
  final Function(Map<String, dynamic>) onConfirmAddress;

  ShippingAddressPage({
    @required this.onAddressSelected,
    @required this.onConfirmAddress,
  });

  @override
  _ShippingAddressPageState createState() => _ShippingAddressPageState();
}

class _ShippingAddressPageState extends State<ShippingAddressPage> {
  final ScreenUtil _screenUtil = ScreenUtil();

  ShippingAddress _address;

  List<Map<String, dynamic>> addresses;

  Map<String, dynamic> chosenAddress;

  @override
  void initState() {
    // _address = ShippingAddress.FromAddresses;
    addresses = [];
    chosenAddress = {
      'id': 0,
      'buildingNo': '',
      'street': '',
      'governorate': {
        'id': 0,
        'name': '',
      },
      'city': {
        'id': 0,
        'name': '',
      },
      'floor': -1,
      'department': -1,
      'moreDescription': '',
    };
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
            create: (_) => AddressesBloc(),
            child: BlocListener<AddressesBloc, AddressesState>(
              listener: (context, state) {
                if (state is AddressesLoadedState) {
                  setState(() {
                    addresses.clear();
                    for (int i = 0; i < state.addresses.length; i++) {
                      Map<String, dynamic> address = {
                        'id': state.addresses[i].id,
                        'buildingNo': state.addresses[i].buildingNo,
                        'street': state.addresses[i].street,
                        'governorate': {
                          'id': state.addresses[i].governorate.id,
                          'name': state.addresses[i].governorate.name,
                        },
                        'city': {
                          'id': state.addresses[i].city.id,
                          'name': state.addresses[i].city.name
                        },
                        'floor': state.addresses[i].floor,
                        'department': state.addresses[i].department,
                        'moreDescription': state.addresses[i].moreDescription,
                      };
                      addresses.add(address);
                    }
                  });
                } else if (state is AddressAddedState) {
                  setState(() {
                    chosenAddress['id'] = state.response.data.id;
                  });
                  // print('chosenAddress: $chosenAddress');
                  widget.onAddressSelected(chosenAddress);
                  widget.onConfirmAddress(chosenAddress);
                } else if (state is ErrorAddingAddress) {
                  print('ErrorAddingAddress');
                  print(state.message);
                }
              },
              child: BlocBuilder<AddressesBloc, AddressesState>(
                builder: (context, state) {
                  return Stack(
                    children: [
                      Scaffold(
                        body: Column(
                          children: [
                            Expanded(
                              child: ListView(
                                children: [
                                  // title
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'حدد عنوان الشحن',
                                      style: TextStyle(
                                        fontSize: _screenUtil.setSp(70),
                                      ),
                                    ),
                                  ),

                                  // Option 1: Choose from your addresses list.
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        'اختر من قائمة عناوينك',
                                        style: TextStyle(
                                          fontSize: _screenUtil.setSp(50),
                                        ),
                                      ),
                                      Radio(
                                          value: ShippingAddress.FromAddresses,
                                          groupValue: _address,
                                          onChanged: (value) {
                                            setState(() {
                                              _address = value;
                                              chosenAddress = {};
                                            });
                                            BlocProvider.of<AddressesBloc>(
                                                    context)
                                                .add(LoadingAddresses(token));
                                          }),
                                    ],
                                  ),

                                  // Addresses list when the option 1 is chosen
                                  _address == ShippingAddress.FromAddresses
                                      ? AddressesList(
                                          addressesList: addresses,
                                          onAddressSelected: (data) {
                                            setState(() {
                                              chosenAddress = data;
                                              chosenAddress = {
                                                'id': 0,
                                                'buildingNo': '',
                                                'street': '',
                                                'governorate': {
                                                  'id': 0,
                                                  'name': '',
                                                },
                                                'city': {
                                                  'id': 0,
                                                  'name': '',
                                                },
                                                'floor': -1,
                                                'department': -1,
                                                'moreDescription': '',
                                              };
                                            });
                                            widget.onAddressSelected(data);
                                          },
                                        )
                                      : Container(),

                                  // Option 2: Create your own address.
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        'إنشاء عنوان جديد',
                                        style: TextStyle(
                                          fontSize: _screenUtil.setSp(50),
                                        ),
                                      ),
                                      Radio(
                                          value: ShippingAddress.NewAddress,
                                          groupValue: _address,
                                          onChanged: (value) {
                                            setState(() {
                                              _address = value;
                                              chosenAddress = {
                                                'id': 0,
                                                'buildingNo': '',
                                                'street': '',
                                                'governorate': {
                                                  'id': 0,
                                                  'name': '',
                                                },
                                                'city': {
                                                  'id': 0,
                                                  'name': '',
                                                },
                                                'floor': -1,
                                                'department': -1,
                                                'moreDescription': '',
                                              };
                                            });
                                          }),
                                    ],
                                  ),

                                  // New address form when option 2 is chosen
                                  _address == ShippingAddress.NewAddress
                                      ? NewAddress(
                                          token: token,
                                          onAddressAdded: (data) {
                                            setState(() {
                                              chosenAddress = data;
                                            });
                                            print(chosenAddress);
                                          },
                                        )
                                      : Container(),
                                ],
                              ),
                            ),

                            // the bottom button
                            Padding(
                              padding: EdgeInsets.all(_screenUtil.setWidth(10)),
                              child: Stack(
                                children: [
                                  Container(
                                    color: Color(0xff3573ac),
                                    child: ListTile(
                                      onTap: () {
                                        if (_address == null) {
                                          Fluttertoast.showToast(
                                            msg:
                                                'اختر أولًا إذا كنت تريد أن تحدد من قائمة عناوينك أو أن تنشئ عنوانًا جديدًا',
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.black54,
                                            textColor: Colors.white,
                                            fontSize: _screenUtil.setSp(50),
                                          );
                                          return;
                                        }
                                        switch (_address) {
                                          case ShippingAddress.FromAddresses:
                                            if (chosenAddress.isEmpty) {
                                              Fluttertoast.showToast(
                                                msg:
                                                    'اختر أولًا من قائمة عناوينك',
                                                toastLength: Toast.LENGTH_LONG,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.black54,
                                                textColor: Colors.white,
                                                fontSize: _screenUtil.setSp(50),
                                              );
                                              return;
                                            }
                                            widget.onConfirmAddress(
                                                chosenAddress);
                                            break;
                                          case ShippingAddress.NewAddress:
                                            if (chosenAddress['buildingNo'] ==
                                                '') {
                                              Fluttertoast.showToast(
                                                msg:
                                                    'من فضلك أدخل رقم العمارة / المبنى / المنشأة',
                                                toastLength: Toast.LENGTH_LONG,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.black54,
                                                textColor: Colors.white,
                                                fontSize: _screenUtil.setSp(50),
                                              );
                                              return;
                                            }

                                            if (chosenAddress['street'] == '') {
                                              Fluttertoast.showToast(
                                                msg:
                                                    'من فضلك أدخل اسم الشارع بالتفصيل',
                                                toastLength: Toast.LENGTH_LONG,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.black54,
                                                textColor: Colors.white,
                                                fontSize: _screenUtil.setSp(50),
                                              );
                                              return;
                                            }

                                            if (chosenAddress['floor'] == -2) {
                                              Fluttertoast.showToast(
                                                msg: 'من فضلك أدخل الدور',
                                                toastLength: Toast.LENGTH_LONG,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.black54,
                                                textColor: Colors.white,
                                                fontSize: _screenUtil.setSp(50),
                                              );
                                              return;
                                            }

                                            if (chosenAddress['department'] ==
                                                -2) {
                                              Fluttertoast.showToast(
                                                msg: 'من فضلك أدخل رقم الشقة',
                                                toastLength: Toast.LENGTH_LONG,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.black54,
                                                textColor: Colors.white,
                                                fontSize: _screenUtil.setSp(50),
                                              );
                                              return;
                                            }

                                            if (chosenAddress['governorate']
                                                    ['id'] <=
                                                0) {
                                              Fluttertoast.showToast(
                                                msg: 'من فضلك اختر المحافظة',
                                                toastLength: Toast.LENGTH_LONG,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.black54,
                                                textColor: Colors.white,
                                                fontSize: _screenUtil.setSp(50),
                                              );
                                              return;
                                            }

                                            if (chosenAddress['city']['id'] <=
                                                0) {
                                              Fluttertoast.showToast(
                                                msg:
                                                    'من فضلك اختر الحي أو المركز التابع للمحافظة',
                                                toastLength: Toast.LENGTH_LONG,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.black54,
                                                textColor: Colors.white,
                                                fontSize: _screenUtil.setSp(50),
                                              );
                                              return;
                                            }
                                            BlocProvider.of<AddressesBloc>(
                                                    context)
                                                .add(AddingAddress({
                                              'token': token,
                                              'buildingNo':
                                                  chosenAddress['buildingNo'],
                                              'street': chosenAddress['street'],
                                              'floor': chosenAddress['floor'],
                                              'department':
                                                  chosenAddress['department'],
                                              'moreDescription': chosenAddress[
                                                  'moreDescription'],
                                              'governorateId':
                                                  chosenAddress['governorate']
                                                      ['id'],
                                              'cityId': chosenAddress['city']
                                                  ['id'],
                                            }));
                                            break;
                                        }
                                      },
                                      title: Text(
                                        // 'حدد طريقة الدفع',
                                        'راجع تفاصيل طلبك',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: _screenUtil.setSp(50),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 0.0,
                                    bottom: 0.0,
                                    right: _screenUtil.setWidth(30),
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                      size: _screenUtil.setSp(50),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      state is LoadingAddressesState ||
                              state is AddingAddressState
                          ? Positioned(
                              top: 0.0,
                              bottom: 0.0,
                              left: 0.0,
                              right: 0.0,
                              child: Container(
                                color: Colors.black.withOpacity(0.5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        width: 100,
                                        height: 100,
                                        child: CircularProgressIndicator()),
                                  ],
                                ),
                              ),
                            )
                          : Container(),
                    ],
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

enum ShippingAddress { FromAddresses, NewAddress }
