import 'package:chopper/chopper.dart';
import '../response/forgot_password_response.dart';

import 'json_to_type_converter.dart';

import 'base_url.dart';

part 'forgot_password_service.chopper.dart';

@ChopperApi(baseUrl: '/api')
abstract class ForgotPasswordService extends ChopperService {
  @Post(path: '/ForgotPassword')
  @FormUrlEncodedConverter()
  Future<Response<ForgotPasswordResponse>> send(
      @Body() Map<String, dynamic> input);

  static ForgotPasswordService create() {
    var client = ChopperClient(
      baseUrl: baseUrl,
      converter: JsonToTypeConverter({
        ForgotPasswordResponse: (json) => ForgotPasswordResponse.fromJson(json)
      }),
      services: [
        _$ForgotPasswordService(),
      ],
    );
    return _$ForgotPasswordService(client);
  }
}
