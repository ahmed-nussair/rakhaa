import 'package:chopper/chopper.dart';
import '../response/signout_response.dart';

import 'json_to_type_converter.dart';

import 'base_url.dart';

part 'signout_service.chopper.dart';

@ChopperApi(baseUrl: '/api')
abstract class SignOutService extends ChopperService {
  @Post(path: '/SignOut')
  @FormUrlEncodedConverter()
  Future<Response<SignOutResponse>> signOut(@Body() Map<String, dynamic> input);

  static SignOutService create() {
    var client = ChopperClient(
      baseUrl: baseUrl,
      converter: JsonToTypeConverter(
          {SignOutResponse: (json) => SignOutResponse.fromJson(json)}),
      services: [
        _$SignOutService(),
      ],
    );
    return _$SignOutService(client);
  }
}
