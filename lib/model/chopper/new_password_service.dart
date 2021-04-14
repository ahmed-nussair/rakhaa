import 'package:chopper/chopper.dart';
import '../response/new_password_response.dart';

import 'json_to_type_converter.dart';

import 'base_url.dart';

part 'new_password_service.chopper.dart';

@ChopperApi(baseUrl: '/api')
abstract class NewPasswordService extends ChopperService {
  @Post(path: '/NewPassword')
  @FormUrlEncodedConverter()
  Future<Response<NewPasswordResponse>> changePassword(
      @Body() Map<String, dynamic> input);

  static NewPasswordService create() {
    var client = ChopperClient(
      baseUrl: baseUrl,
      converter: JsonToTypeConverter(
          {NewPasswordResponse: (json) => NewPasswordResponse.fromJson(json)}),
      services: [
        _$NewPasswordService(),
      ],
    );
    return _$NewPasswordService(client);
  }
}
