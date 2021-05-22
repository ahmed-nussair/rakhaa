import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'update_address.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../screen_util.dart';

import '../../../bloc/addresses/addresses_bloc.dart';
import '../../../globals.dart' as Globals;

import '../../custom_show_dialog.dart';
import 'add_address.dart';
import '../address_item.dart';

class AddressesPage extends StatefulWidget {
  @override
  _AddressesPageState createState() => _AddressesPageState();
}

class _AddressesPageState extends State<AddressesPage> {
  final _screenUtil = ScreenUtil();
  final bloc = AddressesBloc();

  List _addressesList;

  @override
  void initState() {
    _addressesList = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          String token = snapshot.data.getString(Globals.token);
          return BlocProvider(
            create: (_) => bloc..add(LoadingAddresses(token)),
            child: BlocListener<AddressesBloc, AddressesState>(
              listener: (context, state) {
                if (state is AddressesLoadedState) {
                  List addresses = [];
                  for (int i = 0; i < state.addresses.length; i++) {
                    Map address = {
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
                  setState(() {
                    _addressesList = addresses;
                  });
                } else if (state is AddressAddedState) {
                  setState(() {
                    _addressesList.add({
                      'id': state.response.data.id,
                      'buildingNo': state.response.data.buildingNo,
                      'street': state.response.data.street,
                      'governorate': {
                        'id': state.response.data.governorate.id,
                        'name': state.response.data.governorate.name,
                      },
                      'city': {
                        'id': state.response.data.city.id,
                        'name': state.response.data.city.name,
                      },
                      'floor': state.response.data.floor,
                      'department': state.response.data.department,
                      'moreDescription': state.response.data.moreDescription,
                    });
                  });

                  Fluttertoast.showToast(
                    msg: 'تم إضافة العنوان بنجاج',
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black54,
                    textColor: Colors.white,
                    fontSize: _screenUtil.setSp(50),
                  );
                } else if (state is AddressDeletedState) {
                  setState(() {
                    for (int i = 0; i < _addressesList.length; i++) {
                      if (_addressesList[i]['id'] == state.response.addressId) {
                        _addressesList.remove(_addressesList[i]);
                      }
                    }
                  });

                  Fluttertoast.showToast(
                    msg: 'تم حذف العنوان بنجاج',
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black54,
                    textColor: Colors.white,
                    fontSize: _screenUtil.setSp(50),
                  );
                } else if (state is AddressUpdatedState) {
                  setState(() {
                    for (int i = 0; i < _addressesList.length; i++) {
                      if (state.response.data.id == _addressesList[i]['id']) {
                        _addressesList[i]['buildingNo'] =
                            state.response.data.buildingNo;
                        _addressesList[i]['street'] =
                            state.response.data.street;
                        _addressesList[i]['moreDescription'] =
                            state.response.data.moreDescription;
                        _addressesList[i]['floor'] = state.response.data.floor;
                        _addressesList[i]['department'] =
                            state.response.data.department;
                        _addressesList[i]['governorate']['id'] =
                            state.response.data.governorate.id;
                        _addressesList[i]['governorate']['name'] =
                            state.response.data.governorate.name;
                        _addressesList[i]['city']['id'] =
                            state.response.data.city.id;
                        _addressesList[i]['city']['name'] =
                            state.response.data.city.name;
                        break;
                      }
                    }
                  });

                  Fluttertoast.showToast(
                    msg: 'تم تحديث العنوان بنجاج',
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black54,
                    textColor: Colors.white,
                    fontSize: _screenUtil.setSp(50),
                  );
                }
              },
              child: BlocBuilder<AddressesBloc, AddressesState>(
                builder: (context, state) {
                  if (state is LoadingAddressesState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return _addressesList.length > 0
                      ? Stack(
                          children: [
                            // Addresses List
                            ListView(
                              children:
                                  List.generate(_addressesList.length, (index) {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(
                                          _screenUtil.setHeight(50)),
                                      child: Row(
                                        children: [
                                    // Updating or deleting address
                                    Column(
                                      children: [
                                        GestureDetector(
                                          child: Icon(
                                            Icons.edit,
                                            color: Color(0xff9b7448),
                                            size: _screenUtil.setSp(50),
                                          ),
                                          onTap: () {
                                            showDialog(
                                              builder: (context) =>
                                                  CustomAlertDialog(
                                                    titlePadding:
                                                    EdgeInsets.all(0.0),
                                                    contentPadding:
                                                    EdgeInsets.all(0.0),
                                                    content: UpdateAddress(
                                                      token: token,
                                                      data: {
                                                        'id': _addressesList[index]
                                                        ['id'],
                                                        'buildingNo':
                                                        _addressesList[index]
                                                        ['buildingNo'],
                                                        'city':
                                                        _addressesList[index]
                                                        ['city'],
                                                        'governorate':
                                                        _addressesList[index]
                                                        ['governorate'],
                                                        // country: _addressesList[index]['country'],
                                                        // zipPostalCode: _addressesList[index]['zipPostalCode'],
                                                        'department':
                                                        _addressesList[index]
                                                        ['department'],
                                                        'floor':
                                                        _addressesList[index]
                                                        ['floor'],
                                                        'street':
                                                        _addressesList[index]
                                                        ['street'],
                                                        'moreDescription':
                                                        _addressesList[index]
                                                        ['moreDescription'],
                                                      },
                                                      onAddressUpdated: (address) {
                                                        bloc.add(UpdatingAddress(
                                                            address));
                                                        // bloc.add(AddingAddress(address));
                                                        // List newList = _addressesList;
                                                        // newList.add(address);
                                                        // setState(() {
                                                        //   _addressesList = newList;
                                                        // });
                                                      },
                                                    ),
                                                  ),
                                              context: context,
                                            );
                                          },
                                        ),
                                        SizedBox(
                                          height: _screenUtil.setHeight(100),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            bloc.add(DeletingAddress(token,
                                                _addressesList[index]['id']));
                                          },
                                          child: Icon(
                                            Icons.remove,
                                            color: Color(0xff9b7448),
                                            size: _screenUtil.setSp(50),
                                          ),
                                        ),
                                      ],
                                    ),

                                    // Address item
                                    Expanded(
                                      child: AddressItem(
                                        id: _addressesList[index]['id'],
                                        buildingNo: _addressesList[index]
                                        ['buildingNo'],
                                        city: _addressesList[index]['city'],
                                        governorate: _addressesList[index]
                                        ['governorate'],
                                        // country: _addressesList[index]['country'],
                                        // zipPostalCode: _addressesList[index]['zipPostalCode'],
                                        department: _addressesList[index]
                                        ['department'],
                                        floor: _addressesList[index]['floor'],
                                        street: _addressesList[index]['street'],
                                        moreDescription: _addressesList[index]
                                        ['moreDescription'],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(),
                            ],
                          );
                        }),
                      ),

                      // Adding Address Button
                      Positioned(
                        bottom: 0.0,
                        right: 0.0,
                        child: Padding(
                          padding: EdgeInsets.all(_screenUtil.setWidth(50)),
                          child: FloatingActionButton(
                            backgroundColor: Color(0xff9b7448),
                            onPressed: () {
                              showDialog(
                                builder: (context) => CustomAlertDialog(
                                  titlePadding: EdgeInsets.all(0.0),
                                  contentPadding: EdgeInsets.all(0.0),
                                  content: AddAddress(
                                    token: token,
                                    onAddressAdded: (address) {
                                      bloc.add(AddingAddress(address));
                                      // List newList = _addressesList;
                                      // newList.add(address);
                                      // setState(() {
                                      //   _addressesList = newList;
                                      // });
                                    },
                                  ),
                                ),
                                context: context,
                              );
                            },
                            child: Icon(
                              Icons.add,
                              size: _screenUtil.setSp(60),
                            ),
                          ),
                        ),
                      ),

                      // Circular progress bar
                      state is AddingAddressState ||
                          state is DeletingAddressState ||
                          state is UpdatingAddressState
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
                                              child:
                                                  CircularProgressIndicator()),
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(),
                          ],
                        )
                      : Center(
                          child: RichText(
                            text: TextSpan(
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: _screenUtil.setSp(55)),
                                children: [
                                  TextSpan(
                                    text: 'ليس لديك أي عناوين. بإمكانك ',
                                  ),
                                  TextSpan(
                                    text: ' إنشاء عنوان',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => showDialog(
                                            builder: (context) =>
                                                CustomAlertDialog(
                                              titlePadding: EdgeInsets.all(0.0),
                                              contentPadding:
                                                  EdgeInsets.all(0.0),
                                              content: AddAddress(
                                                token: token,
                                                onAddressAdded: (address) {
                                                  bloc.add(
                                                      AddingAddress(address));
                                                  // List newList = _addressesList;
                                                  // newList.add(address);
                                                  // setState(() {
                                                  //   _addressesList = newList;
                                                  // });
                                                },
                                              ),
                                            ),
                                            context: context,
                                          ),
                                  ),
                                ]),
                          ),
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
