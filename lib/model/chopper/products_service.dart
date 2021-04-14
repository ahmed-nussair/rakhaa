import 'package:chopper/chopper.dart';
import '../response/category.dart';

import 'json_to_type_converter.dart';

import 'base_url.dart';

part 'products_service.chopper.dart';

@ChopperApi(baseUrl: '/api')
abstract class ProductsService extends ChopperService {
  @Get(path: '/Categories')
  Future<Response<List<Category>>> getCategories();

  @Get(path: '/Categories')
  Future<Response<List<Category>>> getCategoryById(@Query('id') int id);

  @Get(path: '/Categories/{id}')
  Future<Response<Category>> getCategory(@Path('id') int id);

  static ProductsService create() {
    var client = ChopperClient(
      baseUrl: baseUrl,
      converter:
          JsonToTypeConverter({Category: (json) => Category.fromJson(json)}),
      services: [
        _$ProductsService(),
      ],
    );
    return _$ProductsService(client);
  }
}
