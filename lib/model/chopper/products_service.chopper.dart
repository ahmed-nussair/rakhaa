// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$ProductsService extends ProductsService {
  _$ProductsService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = ProductsService;

  @override
  Future<Response<List<Category>>> getCategories() {
    final $url = '/api/Categories';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<Category>, Category>($request);
  }

  @override
  Future<Response<List<SubCategory>>> getSubCategories(int categoryId) {
    final $url = '/api/SubCategories';
    final $params = <String, dynamic>{'categoryId': categoryId};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<List<SubCategory>, SubCategory>($request);
  }

  @override
  Future<Response<List<Category>>> getCategoryById(int id) {
    final $url = '/api/Categories';
    final $params = <String, dynamic>{'id': id};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<List<Category>, Category>($request);
  }

  @override
  Future<Response<List<Category>>> getSubCategoryById(
      int categoryId, int subCategoryId) {
    final $url = '/api/SubCategories';
    final $params = <String, dynamic>{
      'categoryId': categoryId,
      'subCategoryId': subCategoryId
    };
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<List<Category>, Category>($request);
  }

  @override
  Future<Response<Category>> getCategory(int id) {
    final $url = '/api/Categories/$id';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<Category, Category>($request);
  }

  @override
  Future<Response<Category>> getSubCategory(int categoryId, int subCategoryId) {
    final $url = '/api/SubCategories/$categoryId/$subCategoryId';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<Category, Category>($request);
  }

  @override
  Future<Response<List<Product>>> getProducts(int categoryId,
      {int subCategoryId = -1}) {
    final $url = '/api/Products';
    final $params = <String, dynamic>{
      'categoryId': categoryId,
      'subCategoryId': subCategoryId
    };
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<List<Product>, Product>($request);
  }
}
