import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'city_drop_down.dart';
import '../../../../bloc/addresses/addresses_bloc.dart';
import '../../../screen_util.dart';
import 'governorates_drop_down.dart';

class GovernoratesCitiesWidget extends StatefulWidget {
  final Function(int, String) onGovernorateSelected;
  final Function(int, String) onCitySelected;
  final int governorateId;
  final int cityId;

  const GovernoratesCitiesWidget({
    Key key,
    @required this.onGovernorateSelected,
    @required this.onCitySelected,
    this.governorateId = 0,
    this.cityId = 0,
  }) : super(key: key);

  @override
  _GovernoratesCitiesWidgetState createState() =>
      _GovernoratesCitiesWidgetState();
}

class _GovernoratesCitiesWidgetState extends State<GovernoratesCitiesWidget> {
  final ScreenUtil _screenUtil = ScreenUtil();

  List<Map<String, dynamic>> governorates = [];
  List<Map<String, dynamic>> cities = [];

  int _governorateId;
  int _cityId;

  @override
  void initState() {
    _governorateId = widget.governorateId;
    _cityId = widget.cityId;
    governorates.add({
      'id': 0,
      'name': 'اختر المحافظة',
    });
    cities.add({
      'id': 0,
      'name': 'اختر الحي أو المركز',
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _screenUtil.init(context);

    return BlocProvider(
      create: (_) => AddressesBloc()..add(LoadingGovernorates()),
      child: BlocListener<AddressesBloc, AddressesState>(
        listener: (context, state) {
          if (state is GovernoratesLoadedState) {
            setState(() {
              for (int i = 0; i < state.governorates.length; i++) {
                governorates.add({
                  'id': state.governorates[i].id,
                  'name': state.governorates[i].name,
                });
              }
            });
            BlocProvider.of<AddressesBloc>(context)
                .add(LoadingCities(_governorateId));
          } else if (state is CitiesLoadedState) {
            setState(() {
              cities.clear();
              cities.add({
                'id': 0,
                'name': 'اختر الحي أو المركز',
              });
              for (int i = 0; i < state.cities.length; i++) {
                cities.add({
                  'id': state.cities[i].id,
                  'name': state.cities[i].name,
                });
              }
            });
          }
        },
        child: BlocBuilder<AddressesBloc, AddressesState>(
          builder: (context, state) {
            if (state is LoadingGovernoratesState) {
              return Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                ),
              );
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                    child: state is LoadingCitiesState
                        ? Container(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(),
                              ],
                            ),
                          )
                        : CityDropDown(
                            cityId: cities.length > 1 ? _cityId : 0,
                            cities: cities,
                            onCitySelected: (cityId, cityName) {
                              widget.onCitySelected(cityId, cityName);
                            },
                          )),
                SizedBox(
                  width: _screenUtil.setWidth(50),
                ),
                Flexible(
                  child: GovernoratesDropDown(
                    governorateId:
                        governorates.length > 1 ? widget.governorateId : 0,
                    governorates: governorates,
                    onGovernorateSelected: (governorateId, governorateName) {
                      setState(() {
                        _cityId = 0;
                      });
                      widget.onGovernorateSelected(
                          governorateId, governorateName);
                      BlocProvider.of<AddressesBloc>(context)
                          .add(LoadingCities(governorateId));
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
