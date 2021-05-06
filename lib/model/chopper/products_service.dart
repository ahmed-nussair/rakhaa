import 'package:chopper/chopper.dart';
import '../response/category.dart';
import '../response/subcategory.dart';
import '../response/product.dart';

import 'json_to_type_converter.dart';

import 'base_url.dart';

part 'products_service.chopper.dart';

@ChopperApi(baseUrl: '/api')
abstract class ProductsService extends ChopperService {
  @Get(path: '/Categories')
  Future<Response<List<Category>>> getCategories();

  @Get(path: '/SubCategories')
  Future<Response<List<SubCategory>>> getSubCategories(
      @Query('categoryId') int categoryId);

  @Get(path: '/Categories')
  Future<Response<List<Category>>> getCategoryById(@Query('id') int id);

  @Get(path: '/SubCategories')
  Future<Response<List<Category>>> getSubCategoryById(
      @Query('categoryId') int categoryId,
      @Query('subCategoryId') int subCategoryId);

  @Get(path: '/Categories/{id}')
  Future<Response<Category>> getCategory(@Path('id') int id);

  @Get(path: '/SubCategories/{categoryId}/{subCategoryId}')
  Future<Response<Category>> getSubCategory(@Path('categoryId') int categoryId,
      @Path('subCategoryId') int subCategoryId);

  @Get(path: '/Products')
  Future<Response<List<Product>>> getProducts(
      @Query('categoryId') int categoryId,
      {@Query('subCategoryId') int subCategoryId = -1});

  @Get(path: '/Search')
  Future<Response<List<Product>>> search(@Query('keyword') String keyword);

  static ProductsService create() {
    var client = ChopperClient(
      baseUrl: baseUrl,
      converter: JsonToTypeConverter({
        Category: (json) => Category.fromJson(json),
        SubCategory: (json) => SubCategory.fromJson(json),
        Product: (json) => Product.fromJson(json),
      }),
      services: [
        _$ProductsService(),
      ],
    );
    return _$ProductsService(client);
  }
}
