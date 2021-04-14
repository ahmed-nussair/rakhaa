import 'package:chopper/chopper.dart';
import '../response/code_verification_response.dart';

import 'json_to_type_converter.dart';

import 'base_url.dart';

part 'code_verification_service.chopper.dart';

@ChopperApi(baseUrl: '/api')
abstract class CodeVerificationService extends ChopperService {
  @Post(path: '/CodeVerification/Verify')
  @FormUrlEncodedConverter()
  Future<Response<CodeVerificationResponse>> verify(
      @Body() Map<String, dynamic> input);

  static CodeVerificationService create() {
    var client = ChopperClient(
      baseUrl: baseUrl,
      converter: JsonToTypeConverter({
        CodeVerificationResponse: (json) =>
            CodeVerificationResponse.fromJson(json)
      }),
      services: [
        _$CodeVerificationService(),
      ],
    );
    return _$CodeVerificationService(client);
  }
}
