import 'package:chopper/chopper.dart';

import '../response/signup_response.dart';

import 'json_to_type_converter.dart';

import 'base_url.dart';

part 'signup_service.chopper.dart';

@ChopperApi(baseUrl: '/api')
abstract class SignUpService extends ChopperService {
  @Post(path: '/SignUp')
  @FormUrlEncodedConverter()
  Future<Response<SignUpResponse>> signUp(@Body() Map<String, dynamic> input);

  static SignUpService create() {
    var client = ChopperClient(
      baseUrl: baseUrl,
      converter: JsonToTypeConverter(
          {SignUpResponse: (json) => SignUpResponse.fromJson(json)}),
      services: [
        _$SignUpService(),
      ],
    );
    return _$SignUpService(client);
  }
}
