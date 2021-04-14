import 'package:chopper/chopper.dart';
import '../response/code_resending_response.dart';

import 'json_to_type_converter.dart';

import 'base_url.dart';

part 'code_resending_service.chopper.dart';

@ChopperApi(baseUrl: '/api')
abstract class CodeResendingService extends ChopperService {
  @Get(path: '/CodeVerification/Resend')
  Future<Response<CodeResendingResponse>> resend(@Query('userId') int userId);

  static CodeResendingService create() {
    var client = ChopperClient(
      baseUrl: baseUrl,
      converter: JsonToTypeConverter({
        CodeResendingResponse: (json) => CodeResendingResponse.fromJson(json)
      }),
      services: [
        _$CodeResendingService(),
      ],
    );
    return _$CodeResendingService(client);
  }
}
