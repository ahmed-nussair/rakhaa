// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$ProductsService extends ProductsService {
  _$ProductsService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  final definitionType = ProductsService;

  Future<Response<List<Category>>> getCategories() {
    final $url = '/api/Categories';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<Category>, Category>($request);
  }

  Future<Response<List<SubCategory>>> getSubCategories(int categoryId) {
    final $url = '/api/SubCategories';
    final Map<String, dynamic> $params = {'categoryId': categoryId};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<List<SubCategory>, SubCategory>($request);
  }

  Future<Response<List<Category>>> getCategoryById(int id) {
    final $url = '/api/Categories';
    final Map<String, dynamic> $params = {'id': id};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<List<Category>, Category>($request);
  }

  Future<Response<List<Category>>> getSubCategoryById(
      int categoryId, int subCategoryId) {
    final $url = '/api/SubCategories';
    final Map<String, dynamic> $params = {
      'categoryId': categoryId,
      'subCategoryId': subCategoryId
    };
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<List<Category>, Category>($request);
  }

  Future<Response<Category>> getCategory(int id) {
    final $url = '/api/Categories/${id}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<Category, Category>($request);
  }

  Future<Response<Category>> getSubCategory(int categoryId, int subCategoryId) {
    final $url = '/api/SubCategories/${categoryId}/${subCategoryId}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<Category, Category>($request);
  }

  Future<Response<List<Product>>> getProducts(int categoryId,
      {int subCategoryId = -1}) {
    final $url = '/api/Products';
    final Map<String, dynamic> $params = {
      'categoryId': categoryId,
      'subCategoryId': subCategoryId
    };
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<List<Product>, Product>($request);
  }

  Future<Response<List<Product>>> search(String keyword) {
    final $url = '/api/Search';
    final Map<String, dynamic> $params = {'keyword': keyword};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<List<Product>, Product>($request);
  }
}
